import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'mentor_page.dart';
import 'faq.dart';
import 'chatbotPage.dart';
import 'checkbox_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'providers/quiz_provider.dart';
import 'quiz_launcher_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => QuizProvider(),
      child: const MentorApp(),
    ),
  );
}

class MentorApp extends StatelessWidget {
  const MentorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StartSmart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      initialRoute: '/login',
      routes: {
        '/signup': (context) => const SignupPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const MainScreen()
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<String> titles = [
    "Readiness Quiz",
    "StartSmart Advisor",
    "Explore Mentor",
  ];

  final List<Widget> pages = [
    const QuizLauncherPage(),
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
            // BottomNavigationBarItem(
            //   icon: SvgPicture.asset(
            //     'assets/icons/checklist.svg',
            //     color:
            //         selectedIndex == 0 ? Color(0xFF005C57) : Color(0xFF4EA46A),
            //   ),
            //   label: '',
            // ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/spedometer.svg',
                color:
                    selectedIndex == 0 ?Color(0xFF005C57) : Color(0xFF4EA46A),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/chat.svg',
                color:
                    selectedIndex == 1 ? Color(0xFF005C57) : Color(0xFF4EA46A),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/calendar.svg',
                color:
                    selectedIndex == 2 ? Color(0xFF005C57) : Color(0xFF4EA46A),
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
