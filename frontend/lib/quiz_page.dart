import 'package:flutter/material.dart';

class QuizPage extends StatelessWidget {
  final VoidCallback onShowScore;
  final VoidCallback onAbandon;

  const QuizPage({super.key, required this.onShowScore, required this.onAbandon});

  Future<bool> _onWillPop(BuildContext context) async {
    bool? shouldLeave = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Abandon attempt?'),
        content: const Text(
            "It seems that you are leaving while attempting this quiz. Are you sure you want to leave?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Continue'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              onAbandon();
            },
            child: const Text('Leave', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    return shouldLeave ?? false;
  }

  @override
  Widget build(BuildContext context) {
  
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            const Text(
              "Have you identified your target audience?",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 32),
            ...[
              "Yes, and I have done thorough research and analysis",
              "Yes, and I did a little bit of research and data on it",
              "I think I know, but I have not set my targets yet",
              "I have no idea for now"
            ].map((text) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Center(
                    child: SizedBox(
                      width: 500,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Color(0xFF005C57)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: onShowScore,
                        child: Text(
                          text,
                          style: const TextStyle(
                            color: Color(0xFF005C57),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}