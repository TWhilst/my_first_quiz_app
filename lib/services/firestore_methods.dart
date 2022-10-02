import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/model/completed_level_model.dart';
import 'package:my_first_quiz_app/model/question_model.dart';
import 'package:my_first_quiz_app/model/sign_up_model.dart';
import 'package:my_first_quiz_app/services/storage_methods.dart';
import 'package:my_first_quiz_app/users/view_model/user_details_view_model.dart';
import 'package:provider/provider.dart';

import '../model/category_model.dart';

class FireStoreMethods{
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadQuestions({
    required String category,
    required String question,
    required List<String> options,
    required String answer,
    required String interestingFact,
    required Uint8List? file,
  }) async {
    String response = "Some error occurred";
    try{

      if(category.isNotEmpty || question.isNotEmpty || answer.isNotEmpty || interestingFact.isNotEmpty || file != null) {
        /// Save the other details to the firebase database using firebaseFirestore
        StorageMethods _storage = StorageMethods();
        String image = await _storage.uploadImageToStorage("Question", file!);

        var id = DateTime.now().millisecondsSinceEpoch.toString();
        QuestionModel questions = QuestionModel(
          interestingFact: interestingFact,
          id: id,
          image: image,
          question: question,
          answer: answer,
          category: category,
          option: options,
        );

        await _fireStore.collection("Questions").doc(id).set(questions.toJson());

        response = "Success";
      }
    }

    catch(e) {
      response = e.toString();
    }
    return response;
  }

  Future<String> uploadCategory({
    required String category,
    required Uint8List? file,
  }) async {
    String response = "Some error occurred";
    try{

      if(category.isNotEmpty ||  file != null) {
        /// Save the other details to the firebase database using firebaseFirestore
        StorageMethods _storage = StorageMethods();
        String image = await _storage.uploadImageToStorage("Categories", file!);

        var id = DateTime.now().millisecondsSinceEpoch.toString();
        CategoryModel headline = CategoryModel(
          id: id,
          image: image,
          category: category,
        );

        await _fireStore.collection("Categories").doc(id).set(headline.toJson());

        response = "Success";
      }
    }

    catch(e) {
      response = e.toString();
    }
    return response;
  }

  Future addToPoints(int points, int value) async {
    points = points + value;
    _fireStore.collection("Users").doc(_auth.currentUser!.uid).update({
      "points" : points,
    });
  }

  Future addToLives(bool activate, int lives, BuildContext context) async {
    if(activate == true) {
      if(lives >= 1) {
        lives = lives - 1;
        _fireStore.collection("Users").doc(_auth.currentUser!.uid).update({
          "lives" : lives,
        });

        final details = Provider.of<UserDetailsViewModel>(context, listen: false);
        if(lives<3) {
          details.full = false;
        } else if(lives == 3) {
          details.full = true;
        }
        print(details.fullLives);
      }
    } else {
      final details = Provider.of<UserDetailsViewModel>(context, listen: false);
      if(lives<3) {
        details.full = false;
      } else if(lives == 3) {
        details.full = true;
      }
      print(details.fullLives);
    }
  }

  Future marks(bool correct, SignUpModel sign) async {
    int totalDone = sign.totalDone!;
    int answeredCorrectly = sign.answeredCorrectly!;
    if(correct == false) {
      totalDone = totalDone + 1;
      _fireStore.collection("Users").doc(_auth.currentUser!.uid).update({
        "totalDone" : totalDone,
      });
    } else {
      answeredCorrectly = answeredCorrectly + 1;
      totalDone = totalDone + 1;
      _fireStore.collection("Users").doc(_auth.currentUser!.uid).update({
        "totalDone" : totalDone,
        "answeredCorrectly" : answeredCorrectly,
      });
    }
  }

  void completedLevelDetails({
    required String selectedOption,
    required String answer,
    required String question,
  }) {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    bool? isCorrect;
    if(selectedOption == answer) {
      isCorrect = true;
    } else {
      isCorrect = false;
    }

    CompletedLevelModel level = CompletedLevelModel(
      question: question,
      selectedOption: selectedOption,
      id: id,
      answer: answer,
      isCorrect: isCorrect
    );

    _fireStore.collection("Completed Level").doc(id).set(level.toJson());
  }

  void getStatistics() {
    // _fireStore.collection(FireConst.statistics).doc(id).set(data);
  }

}