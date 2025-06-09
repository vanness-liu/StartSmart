import 'package:flutter/material.dart';
import 'quiz_page.dart';

class ReadinessquizPage extends StatefulWidget {
  @override
  State<ReadinessquizPage> createState() => _ReadinessquizPageState();
}

class _ReadinessquizPageState extends State<ReadinessquizPage> {
  int _step = 0; // 0: pre-quiz 1, 1: pre-quiz 2, 2: quiz, 3: score

  void _goToPreQuiz2() => setState(() => _step = 1);
  void _goToQuiz() => setState(() => _step = 2);
  void _goToScore() => setState(() => _step = 3);
  void _restart() => setState(() => _step = 0);

  @override
  Widget build(BuildContext context) {
    if (_step == 0) {
      // Pre-quiz page 1
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Text(
              "Are you ready to build your empire?",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(height: 24),
            Image.asset(
              'assets/Billy1.jpg',
              height: 200,
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                "Answer a few questions and we'll let you know if you're prepared to take on the startup world!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF005C57),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              ),
              onPressed: _goToPreQuiz2,
              child: const Text(
                "Try Now!",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      );
    } else if (_step == 1) {
      // Pre-quiz page 2
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Text(
              "Let's get you check-up real quick!",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(height: 24),
            Image.asset(
              'assets/Billy2.jpg',
              height: 200,
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                "Answer a few questions and we'll let you know if you're prepared to take on the startup world!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFF005C57)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                  onPressed: _goToScore,
                  child: const Text(
                    "Review Previous Score",
                    style: TextStyle(
                      color: Color(0xFF005C57),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF005C57),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                  onPressed: _goToQuiz,
                  child: const Text(
                    "Re-attempt Quiz",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else if (_step == 2) {
      // Quiz page
      return QuizPage(
        onShowScore: _goToScore,
        onAbandon: _restart,
      );
    } else {
      // Score page
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            const Text(
              "Just a bit more prep!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(height: 24),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    value: 0.7,
                    strokeWidth: 10,
                    backgroundColor: const Color(0xFFE0E0E0),
                    valueColor: const AlwaysStoppedAnimation(Color(0xFF4EA46A)),
                  ),
                ),
                const Text(
                  "70%",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Color(0xFF005C57),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              "You've Done Well In",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: Color(0xFF4EA46A), size: 20),
                      SizedBox(width: 8),
                      Text("You have a clear business plan"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: Color(0xFF4EA46A), size: 20),
                      SizedBox(width: 8),
                      Text("You've identified target audience"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: Color(0xFF4EA46A), size: 20),
                      SizedBox(width: 8),
                      Text("You've considered legalities"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Areas to Improve",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                children: [
                  Icon(Icons.cancel, color: Colors.red, size: 20),
                  SizedBox(width: 8),
                  Text("No clear financial planning"),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF005C57),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              ),
              onPressed: _goToQuiz,
              child: const Text(
                "Re-attempt Quiz",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}