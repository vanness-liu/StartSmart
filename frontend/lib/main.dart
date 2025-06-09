import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'mentor_page.dart';
import 'faq.dart';
import 'chatbotPage.dart';
import 'readinessquizPage.dart';
import 'checkbox_page.dart';

void main() {
  runApp(MentorApp());
}

class MentorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mentor App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: MainScreen(), // ✅ This points to the stateful widget below
    );
  }
}

// ✅ Add this class to fix the missing part
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<String> titles = [
    "CheckBox",
    "Readiness Quiz",
    "StartSmart Advisor",
    "Explore Mentor",
  ];

  final List<Widget> pages = [
    CheckboxPage(),
    ReadinessquizPage(),
    ChatbotPage(),
    MentorPage(),
  ];

  void onIconTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top Bar with dynamic title
          // In your _MainScreenState class, modify the top bar widget:
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Faq()),
                    );
                  },
                  child: SvgPicture.asset(
                    'assets/icons/startsmart.svg',
                    width: 30,
                    height: 30,
                    color: Color(0xFFCFF5D4),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      titles[selectedIndex],
                      style: TextStyle(
                        color: Color(0xFFCFF5D4),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SvgPicture.asset(
                  'assets/icons/Frame.svg',
                  width: 28,
                  height: 28,
                  color: Color(0xFFCFF5D4),
                ),
              ],
            ),
          ),

          // Page content
          Expanded(child: pages[selectedIndex]),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFFEBFFEE),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 8),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: onIconTapped,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFF005C57),
          unselectedItemColor: Color(0xFF4EA46A),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/checklist.svg',
                color:
                    selectedIndex == 0 ? Color(0xFF005C57) : Color(0xFF4EA46A),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/spedometer.svg',
                color:
                    selectedIndex == 1 ? Color(0xFF005C57) : Color(0xFF4EA46A),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/chat.svg',
                color:
                    selectedIndex == 2 ? Color(0xFF005C57) : Color(0xFF4EA46A),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/calendar.svg',
                color:
                    selectedIndex == 3 ? Color(0xFF005C57) : Color(0xFF4EA46A),
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
