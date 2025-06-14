import 'package:flutter/material.dart';
import 'services/chat_api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatbotPage extends StatefulWidget {
  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final List<Map<String, String>> messages = [];
  final TextEditingController _controller = TextEditingController();
  bool hasStartedChat = false;

  String? industry;
  String? experience;
  String? phase;
  String? launchTime;
  String? funding;
  bool isLoading = true; // To track when data is being fetched

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
    if (text.trim().isEmpty) return;

    setState(() {
      hasStartedChat = true;
      messages.add({'sender': 'user', 'text': text});
      _controller.clear();
    });

    //@minzi
    // Replace these with actual values from your UI or user profile
      String userIndustry = industry ?? "Unknown";
      String userExperience = experience ?? "Unknown";
      String userPhase = phase ?? "Unknown";
      String userLaunchTime = launchTime ?? "Unknown";
      String userFunding = funding ?? "Unknown";

    try {
      final botReply = await ChatApiService().sendMessage(
        question: text,
        industry: userIndustry,
        experience: userExperience,
        phase: userPhase,
        launchTime: userLaunchTime,
        funding: userFunding,
      );
      setState(() {
        messages.add({'sender': 'bot', 'text': botReply});
      });
    } catch (e) {
      setState(() {
        messages.add({'sender': 'bot', 'text': 'Sorry, failed to connect to the server.'});
        print(e);
      });
    }
  }

  Future<void> fetchUserProfileData() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;

  final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

  if (userDoc.exists) {
    final data = userDoc.data();
    setState(() {
      industry = data?['industry'] ?? 'Unknown';
      experience = data?['experience'] ?? 'Unknown';
      phase = data?['stage'] ?? 'Unknown';
      launchTime = data?['planning'] ?? 'Unknown';
      funding = data?['funding'] ?? 'Unknown';
      isLoading = false;
    });
  }
}


  Widget buildBubble(String text, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(maxWidth: 280),
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
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Text(
                "Get instant advice, anytime.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        ...suggestions.map((question) => Padding(
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
                  textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: Text(question),
              ),
            )),
        SizedBox(height: 80), // Space above input bar
      ],
    );
  }

  Widget buildChatView() {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[messages.length - 1 - index];
                return buildBubble(msg['text']!, msg['sender'] == 'user');
              },
            ),
          ),
        ),
        SizedBox(height: 80), // Space above input bar
      ],
    );
  }

  Widget buildInputBar() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16, 8, 16, 24),
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
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
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
      body: SafeArea(child: hasStartedChat ? buildChatView() : buildLandingView()),
      bottomNavigationBar: buildInputBar(),
    );
  }
}
