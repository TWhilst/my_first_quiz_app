import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/model/question_model.dart';
import 'package:my_first_quiz_app/services/firebase_auth.dart';
import 'package:provider/provider.dart';

class QuestionProvider extends ChangeNotifier{

  int _index = 0;
  QuerySnapshot? _user;

  int get index => _index;
  QuerySnapshot? get user => _user;

  void getIndex(int index) {
    _index = index;
    notifyListeners();
  }

  void getUser(QuerySnapshot? user) {
    _user = user;
    notifyListeners();
  }

  void nextQuestion(BuildContext context) {
    QuerySnapshot? user = context.watch<QuerySnapshot>();
    int value = 0;
    if(value < user.docs.length) {
      value++;
    }
    getIndex(value);
    getUser(user);
  }

}