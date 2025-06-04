import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatPage extends StatefulWidget {
  final String mentorName;

  const ChatPage({required this.mentorName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isHovering = false;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4FFF7),
      body: Column(
        children: [
          // Top Bar
          Container(
            padding: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4EA46A), Color(0xFF005C57)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.mentorName,
                    style: const TextStyle(
                      color: Color(0xFFCFF5D4),
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      fontFamily: 'Poppins',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                // Added SVG Icon (make sure the asset path is correct)
                SvgPicture.asset(
                  'assets/icons/video.svg', // replace with your actual SVG path
                  width: 20,
                  height: 20,
                  color: Colors.white,
                ),
                const SizedBox(width: 12),
                const Icon(Icons.more_vert, color: Colors.white),
              ],
            ),
          ),

          // Chat content
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                MouseRegion(
                  onEnter: (_) => setState(() => _isHovering = true),
                  onExit: (_) => setState(() => _isHovering = false),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: _isHovering
                          ? [
                              const BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ]
                          : [
                              const BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 12,
                              backgroundColor: Color(0xFF4EA46A),
                              child: Icon(Icons.smart_toy,
                                  color: Colors.white, size: 14),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "Mentor Buddies Bot",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                color: Color(0xFF267F60),
                              ),
                            ),
                            const Spacer(),
                            const Text(
                              "5:23 pm",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Hi there, buddy! We’re connecting you with ${widget.mentorName} now!",
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Message input
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(fontFamily: 'Poppins'),
                      decoration: const InputDecoration(
                        hintText: "Write a message...",
                        hintStyle: TextStyle(fontFamily: 'Poppins'),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF4EA46A)),
                  onPressed: () {
                    // Implement send message
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
