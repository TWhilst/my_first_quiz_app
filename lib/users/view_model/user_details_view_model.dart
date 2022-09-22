import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/services/firebase_auth.dart';
import 'package:my_first_quiz_app/utils/utils.dart';

class UserDetailsViewModel extends ChangeNotifier {

  bool _isSaving = false;
  bool _isAdmin = false;

  bool get isSaving => _isSaving;
  bool get isAdmin => _isAdmin;

  void saving(bool isSaving) {
    _isSaving = isSaving;
    notifyListeners();
  }

  /// To save the user details to the firebaseDatabase
  Future<void> saveUserDetails({
    required String email,
    required String username,
    required String password,
    required String confirmPassword,
    required BuildContext context,
    required VoidCallback onSuccess,
  }) async {
    saving(true);
    String response = await AuthMethods().signUpUser(
      email: email, username: username,
      password: password, confirmPassword: confirmPassword,
    );
    saving(false);
    debugPrint(response);
    if(response != "Success") {
      Utils.showSnackBar(content: response, context: context);
    } else {
      onSuccess.call();
    }
  }

  /// Login user with email and password
  Future<void> loginUser({
    required String email,
    required String password,
    required BuildContext context,
    required VoidCallback onSuccess,
  }) async {
    saving(true);
    String response = await AuthMethods().loginUser(email: email, password: password);
    saving(false);
    debugPrint(response);
    if(response != "Success") {
      Utils.showSnackBar(content: response, context: context);
    } else {
      onSuccess.call();
    }
  }

  Future<void> uploadDetails({
    required String category,
    required String question,
    required List<String> answer,
    required String interestingFact,
    required BuildContext context,
  }) async {
    saving(true);
    String response = await AuthMethods().uploadDetails(
      category: category, question: question,
      answer: answer, interestingFact: interestingFact,
    );
    saving(false);
    debugPrint(response);
    if(response != "Success") {
      Utils.showSnackBar(content: response, context: context);
    } else {
      Utils.showSnackBar(content: "Success", context: context);
    }
  }
}