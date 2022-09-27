import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_first_quiz_app/model/question_model.dart';
import 'package:my_first_quiz_app/model/sign_up_model.dart';
import 'package:my_first_quiz_app/services/storage_methods.dart';
import '../model/category_model.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String username,
    required String password,
    required String confirmPassword,
  }) async {
    String response = "Some error occurred";
    bool isAdmin = false;
    try{
      
      if(email.isNotEmpty || username.isNotEmpty || password.isNotEmpty || confirmPassword.isNotEmpty) {
        /// register user at the firebase authentication page
        UserCredential credential =
        await _auth.createUserWithEmailAndPassword(email: email, password: password);

        SignUpModel signUp = SignUpModel(
          username: username,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          uid: credential.user!.uid,
          isAdmin: isAdmin,
          points: 20,
          lives: 3,
          answeredCorrectly: 0,
          totalDone: 0,
        );
        
        /// Save the other details to the firebase database using firebaseFirestore
        await _fireStore.collection("users").doc(credential.user!.uid).set(signUp.toJson());
        response = "Success";
      }
    }
    on FirebaseException catch(e) {
      if(e.code == "email-already-in-use") {
        response = "This email is being used by another account";
      }
      // else if(e.code == )
    }

    catch(e) {
      response = e.toString();
    }
    return response;
  }

  /// Login user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String response = "Some error occurred";
    try{
      if(email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        response = "Success";
      }
    } on FirebaseException catch(e) {
      if(e.code == "user-not-found") {
        response = "This user is not valid";
      } else if(e.code == "wrong-password") {
        response = "The password is incorrect";
      }
    }
    catch(e) {
      response = e.toString();
    }
    return response;
  }

  Future<String> uploadQuestions({
    required String category,
    required String question,
    required List<String> options,
    required String answer,
    required String interestingFact,
    required Uint8List? file,
  }) async {
    String response = "Some error occurred";
    bool isAdmin = false;
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



}