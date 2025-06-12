class QuizQuestion {
  final int id;
  final String text;
  final List<String> options = const ['Yes', 'No', 'Not Sure'];

  QuizQuestion({required this.id, required this.text});
}

class QuizAnswer {
  final int questionId;
  final String answer;

  QuizAnswer({required this.questionId, required this.answer});

  Map<String, dynamic> toJson() {
    return {
      'question_id': questionId,
      'answer': answer,
    };
  }
}

class QuizResult {
  final String title; 
  final int score;
  final List<String> doneWell;
  final List<String> areasToImprove;

  QuizResult({
    required this.title,
    required this.score,
    required this.doneWell,
    required this.areasToImprove,
  });

  factory QuizResult.fromJson(Map<String, dynamic> json) {
    // Safely parse the 'doneWell' list. If it's null, default to an empty list.
    final doneWellList = json['done_well'] != null
        ? List<String>.from(json['done_well'])
        : <String>[];
        
    // Safely parse the 'areasToImprove' list. If it's null, default to an empty list.
    final areasToImproveList = json['areas_to_improve'] != null
        ? List<String>.from(json['areas_to_improve'])
        : <String>[];

    return QuizResult(
      // Safely parse the score, default to 0 if null.
      title: json['title'],
      score: json['score'] ?? 0,
      doneWell: doneWellList,
      areasToImprove: areasToImproveList,
    );
  }
}