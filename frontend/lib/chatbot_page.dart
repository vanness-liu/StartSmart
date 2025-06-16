import 'package:flutter/material.dart';
import 'services/chat_api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatbotPage extends StatefulWidget {
  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

/// A widget that displays a pulsing typing indicator with three dots.
class PulsingTypingIndicator extends StatefulWidget {
  final Color dotColor;
  final Color bubbleColor;

  const PulsingTypingIndicator({
    Key? key,
    this.dotColor = Colors.white70,
    this.bubbleColor = const Color(0xFF005C57),
  }) : super(key: key);

  @override
  _PulsingTypingIndicatorState createState() => _PulsingTypingIndicatorState();
}

class _PulsingTypingIndicatorState extends State<PulsingTypingIndicator>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  final List<Animation<double>> _animations = [];
  final int _dotCount = 3;
  final double _dotSize = 8.0;
  final double _spacing = 4.0;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(_dotCount, (index) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      );
    });

    for (int i = 0; i < _dotCount; i++) {
      _animations.add(
        Tween<double>(begin: 0.5, end: 1.0).animate(
          CurvedAnimation(parent: _controllers[i], curve: Curves.easeInOut),
        ),
      );

      // Create a staggered animation
      Future.delayed(Duration(milliseconds: i * 150), () {
        if (mounted) {
          _controllers[i].repeat(reverse: true);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: widget.bubbleColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(_dotCount, (index) {
            return FadeTransition(
              opacity: _animations[index],
              child: Container(
                width: _dotSize,
                height: _dotSize,
                margin: EdgeInsets.symmetric(horizontal: _spacing / 2),
                decoration: BoxDecoration(
                  color: widget.dotColor,
                  shape: BoxShape.circle,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

class _ChatbotPageState extends State<ChatbotPage> {
  final List<Map<String, String>> messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool hasStartedChat = false;
  bool isBotTyping = false;

  String? industry;
  String? experience;
  String? phase;
  String? launchTime;
  String? funding;
  bool isProfileLoading = true; // To track when data is being fetched

  @override
  void initState() {
    super.initState();
    fetchUserProfileData();
  }

  final Color userBubbleColor = Color(0xFFCFF5D4);
  final Color botBubbleColor = Color(0xFF005C57);
  final Color textColor = Color(0xFF4EA46A);
  final Color backgroundInput = Color(0xFF005C57);

  final List<String> suggestions = [
    "What's the first step to start my startup?",
    "How do I know if my idea is worth building?",
    "What should be in a simple business plan?",
  ];

  void sendMessage(String text) async {
    if (text.trim().isEmpty || isBotTyping) return;

    // 1. Add user message and show typing indicator
    setState(() {
      hasStartedChat = true;
      messages.add({'sender': 'user', 'text': text});
      isBotTyping = true;
      _controller.clear();
    });
    _scrollToBottom();

    // 2. Start API call timer and fetch reply
    final apiCallStartTime = DateTime.now();
    String botReply;

    try {
      final userIndustry = industry ?? "Unknown";
      final userExperience = experience ?? "Unknown";
      final userPhase = phase ?? "Unknown";
      final userLaunchTime = launchTime ?? "Unknown";
      final userFunding = funding ?? "Unknown";

      botReply = await ChatApiService().sendMessage(
        question: text,
        industry: userIndustry,
        experience: userExperience,
        phase: userPhase,
        launchTime: userLaunchTime,
        funding: userFunding,
      );
    } catch (e) {
      botReply = 'Sorry, I encountered an error. Please try again.';
    }

    // 3. Enforce minimum 1-second loading time
    final apiCallDuration = DateTime.now().difference(apiCallStartTime);
    final remainingTime = Duration(seconds: 1) - apiCallDuration;

    if (remainingTime > Duration.zero) {
      await Future.delayed(remainingTime);
    }

    // 4. Hide typing indicator and add the final bot reply
    setState(() {
      isBotTyping = false;
      messages.add({'sender': 'bot', 'text': botReply});
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    // A small delay to allow the list to build before scrolling
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> fetchUserProfileData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      setState(() => isProfileLoading = false);
      return;
    }

    try {
      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.exists) {
        final data = userDoc.data();
        setState(() {
          industry = data?['industry'] ?? 'Unknown';
          experience = data?['experience'] ?? 'Unknown';
          phase = data?['stage'] ?? 'Unknown';
          launchTime = data?['planning'] ?? 'Unknown';
          funding = data?['funding'] ?? 'Unknown';
        });
      }
    } catch (e) {
      print("Failed to fetch user profile: $e");
      // Handle error, maybe show a snackbar
    } finally {
      setState(() => isProfileLoading = false);
    }
  }

  Widget buildBubble(String text, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isUser ? userBubbleColor : botBubbleColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colors.black87 : Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget buildLandingView() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
      children: [
        Center(
          child: Column(
            children: [
              SizedBox(height: 30),
              Text(
                "Stuck on your startup journey?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, height: 1.2),
              ),
              SizedBox(height: 12),
              Text(
                "Get instant advice, anytime.",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        ...suggestions.map(
          (question) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: ElevatedButton(
              onPressed: () => sendMessage(question),
              style: ElevatedButton.styleFrom(
                backgroundColor: userBubbleColor,
                foregroundColor: textColor,
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              child: Text(question),
            ),
          ),
        ),
        SizedBox(height: 80), // Space above input bar
      ],
    );
  }

  Widget buildChatView() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      itemCount: messages.length + (isBotTyping ? 1 : 0),
      itemBuilder: (context, index) {
        if (isBotTyping && index == messages.length) {
          return PulsingTypingIndicator();
        }
        final msg = messages[index];
        return buildBubble(msg['text']!, msg['sender'] == 'user');
      },
    );
  }

  Widget buildInputBar() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(
        16,
        8,
        16,
        MediaQuery.of(context).padding.bottom + 8,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundInput,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Ask anything",
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                cursorColor: textColor,
                onSubmitted: (value) => sendMessage(value),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send, color: Colors.white),
              onPressed: () => sendMessage(_controller.text),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              bottom: 80, // Reserve space for the input bar at the bottom
              child: hasStartedChat ? buildChatView() : buildLandingView(),
            ),
            Positioned(bottom: 0, left: 0, right: 0, child: buildInputBar()),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
