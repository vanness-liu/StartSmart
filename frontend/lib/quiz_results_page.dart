// frontend/lib/quiz_results_page.dart
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../models/quiz_models.dart';
import '../providers/quiz_provider.dart';
import 'readiness_quiz_page.dart';

class QuizResultsContent extends StatelessWidget {
  final QuizResult result;
  final VoidCallback? onReattempt;

  const QuizResultsContent({super.key, required this.result, this.onReattempt});

  Future<void> _reattemptQuiz(BuildContext context) async {
    if (context.mounted) {
      context.read<QuizProvider>().resetQuiz();

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const ReadinessQuizPage()))
          .then((_) {
            if (onReattempt != null) {
              onReattempt!();
            }
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color darkGreen = Color(0xFF005C57);
    const Color darkRed = Color(0xFFC62828);

    return Container(
      color: Colors.white, // This sets the background for the results content
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              result.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            CircularPercentIndicator(
              radius: 90.0,
              lineWidth: 15.0,
              percent: (result.score / 100.0).clamp(0.0, 1.0),
              center: Text(
                "${result.score}%",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: darkGreen,
                ),
              ),
              progressColor: darkGreen,
              backgroundColor: darkGreen.withOpacity(0.2),
              circularStrokeCap: CircularStrokeCap.round,
            ),
            const SizedBox(height: 32),
            _buildFeedbackCard(
              title: "You've Done Well In",
              items: result.doneWell,
              icon: Icons.check_circle,
              color: Colors.green,
            ),
            const SizedBox(height: 16),
            _buildFeedbackCard(
              title: "Areas to Improve",
              items: result.areasToImprove,
              icon: Icons.warning,
              color: darkRed,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => _reattemptQuiz(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(
                  0xFF004D40,
                ), // A slightly darker, richer green
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Re-attempt Quiz",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackCard({
    required String title,
    required List<String> items,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color.withOpacity(0.1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const Divider(),
            if (items.isEmpty)
              const Text(
                "Nothing here yet!",
                style: TextStyle(fontStyle: FontStyle.italic),
              )
            else
              ...items.map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Icon(icon, color: color, size: 20),
                      const SizedBox(width: 8),
                      Expanded(child: Text(item)),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class QuizResultsPage extends StatelessWidget {
  final QuizResult result;
  final VoidCallback? onReattempt;

  const QuizResultsPage({super.key, required this.result, this.onReattempt});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Readiness Score")),
      body: QuizResultsContent(result: result, onReattempt: onReattempt),
    );
  }
}
