import 'package:flutter/material.dart';
import 'mentor_detail_page.dart';

class MentorPage extends StatelessWidget {
  final List<Map<String, String>> mentors = [
    {
      'name': 'Dash Dhakshinamoorthy',
      'desc': 'Founder of StartupMalaysia.org',
      'image': 'assets/dash.jpg',
      'about':
          'Dash has mentored hundreds of Malaysian startups and is involved in shaping the local startup scene. He has also worked with the Malaysian Global Innovation & Creativity Centre (MaGIC).',
    },
    {
      'name': 'Cheryl Yeoh',
      'desc': 'Former CEO of MaGIC',
      'image': 'assets/cheryl.jpg',
      'about':
          'A successful entrepreneur herself (Reclip.it, acquired by Walmart Labs), Cheryl is passionate about building the startup ecosystem in Malaysia and Asia.',
    },
    {
      'name': 'Khaillee Ng',
      'desc': 'Managing Partner of 500 Global',
      'image': 'assets/khailee.jpg',
      'about':
          'Khailee has invested in over 180 startups across Southeast Asia, including Grab and Carousell. He\'s a prominent voice in Malaysia’s tech entrepreneurship scene.',
    },
    {
      'name': 'Dr. V. Sivapalan',
      'desc': 'Co-Founder: Proficeo Consultants',
      'image': 'assets/sivapalan.jpg',
      'about':
          'A veteran in Malaysia’s startup ecosystem, he runs the Coach & Grow Programme (CGP) which has helped scale many local startups.',
    },
    {
      'name': 'Renyi Chin',
      'desc': 'Co-Founder of myBurgerLab',
      'image': 'assets/renyi.jpg',
      'about':
          'A hands-on entrepreneur who turned a startup F&B business into a household name in Malaysia. He often speaks at startup events and shares practical advice.',
    },
  ];

  MentorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // This sets the background for the mentor list area
      child: Column(
        children: [
          Padding(padding: const EdgeInsets.all(16.0)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search anything...',
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                fillColor: Color(0xFF267F60),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: mentors.length,
              itemBuilder: (context, index) {
                final mentor = mentors[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => MentorDetailPage(
                              name: mentor['name']!,
                              description: mentor['desc']!,
                              imagePath: mentor['image']!,
                              about: mentor['about']!,
                            ),
                      ),
                    );
                  },
                  child: MentorCard(
                    name: mentor['name']!,
                    description: mentor['desc']!,
                    imagePath: mentor['image']!,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MentorCard extends StatelessWidget {
  final String name;
  final String description;
  final String imagePath;

  const MentorCard({
    super.key,
    required this.name,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFEBFFEE),
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(radius: 28, backgroundImage: AssetImage(imagePath)),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF344D57),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF344D57),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.circle, color: Colors.green, size: 12),
                      SizedBox(width: 6),
                      Text(
                        "Available to Chat Now!",
                        style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Color(0xFF4EA46A), size: 20),
          ],
        ),
      ),
    );
  }
}
