import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpModel{
  String? username;
  String? email;
  String? password;
  String? confirmPassword;
  String? uid;
  bool? isAdmin;
  int? points;
  int? totalPoints;
  int? lives;
  int? answeredCorrectly;
  int? totalDone;

  SignUpModel({
    this.uid,
    this.answeredCorrectly,
    this.confirmPassword,
    this.email,
    this.isAdmin,
    this.lives,
    this.password,
    this.points,
    this.totalPoints,
    this.totalDone,
    this.username,
  });

  Map<String, dynamic> toJson() {
    return {
      "username" : username,
      "email" : email,
      "password" : password,
      "confirmPassword" : confirmPassword,
      "uid" : uid,
      "isAdmin" : isAdmin,
      "points" : points,
      "totalPoints" : totalPoints,
      "lives" : lives,
      "answeredCorrectly" : answeredCorrectly,
      "totalDone" : totalDone,
    };
  }

  factory SignUpModel.fromJson(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return SignUpModel(
      username : snap["username"],
      email : snap["email"],
      password : snap["password"],
      confirmPassword : snap["confirmPassword"],
      uid : snap["uid"],
      isAdmin : snap["isAdmin"],
      points : snap["points"],
      totalPoints : snap["totalPoints"],
      lives : snap["lives"],
      answeredCorrectly : snap["answeredCorrectly"],
      totalDone : snap["totalDone"],
    );
  }
}