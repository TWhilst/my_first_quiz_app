import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/model/category_model.dart';
import 'package:my_first_quiz_app/model/sign_up_model.dart';
import 'package:my_first_quiz_app/services/firebase_auth.dart';
import 'package:my_first_quiz_app/services/firestore_methods.dart';
import 'package:my_first_quiz_app/utils/utils.dart';

class UserDetailsViewModel extends ChangeNotifier {
  bool _fullLives = true;
  bool _isSaving = false;
  final _auth = AuthMethods();

  final bool _isAdmin = false;
  SignUpModel _signUp = SignUpModel();
  bool get fullLives => _fullLives;


  bool get isSaving => _isSaving;
  bool get isAdmin => _isAdmin;
  SignUpModel? get signUp => _signUp;

  void saving(bool isSaving) {
    _isSaving = isSaving;
    notifyListeners();
  }

  set full(bool fullLives) {
    _fullLives = fullLives;
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

  Future<void> uploadQuestions({
    required String category,
    required String question,
    required List<String> options,
    required String answer,
    required String interestingFact,
    required Uint8List? file,
    required BuildContext context,
  }) async {
    saving(true);
    String response = await FireStoreMethods().uploadQuestions(
      options: options,
      category: category, question: question,
      answer: answer, interestingFact: interestingFact,
      file: file,
    );
    saving(false);
    debugPrint(response);
    if(response != "Success") {
      Utils.showSnackBar(content: response, context: context);
    } else {
      Utils.showSnackBar(content: "Success", context: context);
    }
  }

  Future<void> uploadCategories({
    required String category,
    required Uint8List? file,
    required BuildContext context,
  }) async {
    saving(true);
    String response = await FireStoreMethods().uploadCategory(
      category: category,
      file: file,
    );
    saving(false);
    debugPrint(response);
    if(response != "Success") {
      Utils.showSnackBar(content: response, context: context);
    } else {
      Utils.showSnackBar(content: "Success", context: context);
    }
  }

  Future getSignUpDetails(SignUpModel signUp) async {
    _signUp = signUp;
    notifyListeners();
  }
}