import 'package:flutter/material.dart';
import 'chat_page.dart';

class MentorDetailPage extends StatelessWidget {
  final String name;
  final String description;
  final String imagePath;
  final String about;

  const MentorDetailPage({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.about,
  });

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
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Color(0xFFCFF5D4),
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Body Content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFEBFFEE), Color(0xFFFFFFFF)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      padding: EdgeInsets.all(6),
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: AssetImage(imagePath),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF344D57),
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.circle, color: Colors.green, size: 12),
                        SizedBox(width: 6),
                        Text(
                          "Available to Chat Now!",
                          style: TextStyle(
                            color: Color(0xFF344D57),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),

                    // About Box
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ABOUT",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xFF344D57),
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            about,
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              color: Color(0xFF6C6C6C),
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ChatPage(mentorName: name),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF4EA46A),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 12),
                                child: Text(
                                  "Start Chat",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                     color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
