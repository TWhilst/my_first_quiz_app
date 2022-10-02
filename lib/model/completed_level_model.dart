import 'package:cloud_firestore/cloud_firestore.dart';

class CompletedLevelModel {
  String? question;
  String? selectedOption;
  String? answer;
  String? id;
  bool isCorrect;

  CompletedLevelModel({
    required this.question,
    required this.selectedOption,
    required this.id,
    required this.answer,
    required this.isCorrect,
  });

  Map<String, dynamic> toJson() {
    return {
      "question": question,
      "selectedAnswer": selectedOption,
      "id": id,
      "answerColor": answer,
      "isCorrect": isCorrect,
    };
  }

  factory CompletedLevelModel.fromJson(DocumentSnapshot snapshot) {
    return CompletedLevelModel(
      question: snapshot["question"],
      selectedOption: snapshot["selectedAnswer"],
      id: snapshot["id"],
      answer: snapshot["answerColor"],
      isCorrect: snapshot["isCorrect"],
    );
  }
}

