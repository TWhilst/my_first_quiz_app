import 'package:cloud_firestore/cloud_firestore.dart';

class CompletedLevelModel {
  int? correct;
  int? wrong;
  int? totalDone;

  CompletedLevelModel({
    required this.correct,
    required this.wrong,
    required this.totalDone,
  });

  Map<String, dynamic> toJson() {
    return {
      "question": correct,
      "selectedAnswer": wrong,
      "answerColor": totalDone,
    };
  }

  factory CompletedLevelModel.fromJson(DocumentSnapshot snapshot) {
    return CompletedLevelModel(
      correct: snapshot["question"],
      wrong: snapshot["selectedAnswer"],
      totalDone: snapshot["answerColor"],
    );
  }
}
