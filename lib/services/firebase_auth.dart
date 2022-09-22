import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/users/views/home_page/admin_home_page.dart';

import '../users/views/home_page/user_home_page.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _auth.idTokenChanges();

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
        
        /// Save the other details to the firebase database using firebaseFirestore
        await _fireStore.collection("users").doc(credential.user!.uid).set({
          "username" : username,
          "email" : email,
          "password" : password,
          "confirmPassword" : confirmPassword,
          "uid" : credential.user!.uid,
          "isAdmin" : isAdmin,
        });
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

  Future<String> uploadDetails({
    required String category,
    required String question,
    required List<String> answer,
    required String interestingFact,
  }) async {
    String response = "Some error occurred";
    bool isAdmin = false;
    try{

      if(category.isNotEmpty || question.isNotEmpty || answer.isNotEmpty || interestingFact.isNotEmpty) {

        /// Save the other details to the firebase database using firebaseFirestore
        await _fireStore.collection("categories").doc(category).update({
          "question" : FieldValue.arrayUnion(elements),
          "category" : category,
          "answer" : answer,
          "interestingFact" : interestingFact,
        });
        response = "Success";
      }
    }

    catch(e) {
      response = e.toString();
    }
    return response;
  }



}