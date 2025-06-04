import 'package:flutter/material.dart';

class ChatbotPage extends StatefulWidget {
  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final List<Map<String, String>> messages = [];
  final TextEditingController _controller = TextEditingController();
  bool hasStartedChat = false;

  final Color userBubbleColor = Color(0xFFCFF5D4);
  final Color botBubbleColor = Color(0xFF005C57);
  final Color textColor = Color(0xFF4EA46A);
  final Color backgroundInput = Color(0xFF005C57);

  final List<String> suggestions = [
    "What's the first step to start my startup?",
    "How do I know if my idea is worth building?",
    "What should be in a simple business plan?",
  ];

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      hasStartedChat = true;
      messages.add({'sender': 'user', 'text': text});
      _controller.clear();
    });

    // Simulated chatbot response
    Future.delayed(Duration(milliseconds: 400), () {
      setState(() {
        messages.add({
          'sender': 'bot',
          'text':
              'Great idea! You can start by asking your target audience questions or building a landing page to test interest.'
        });
      });
    });
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      padding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 20),
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
            SizedBox(height: 30),
            buildInputBar(),
          ],
        ),
      ),
    );
  }

  Widget buildChatView() {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ListView(
              reverse: true,
              children: messages.reversed
                  .map((msg) =>
                      buildBubble(msg['text']!, msg['sender'] == 'user'))
                  .toList(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: buildInputBar(),
        ),
      ],
    );
  }

  Widget buildInputBar() {
    return Container(
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
                hintStyle: TextStyle(color:const Color.fromARGB(255, 255, 255, 255)),
                border: InputBorder.none,
              ),
              cursorColor: textColor,
              onSubmitted: (value) => sendMessage(value),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color:const Color.fromARGB(255, 255, 255, 255)),
            onPressed: () => sendMessage(_controller.text),
            
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return hasStartedChat ? buildChatView() : buildLandingView();
  }
}
