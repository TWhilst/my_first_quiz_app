

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/global_widgets/status_bar_color_changer.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';

import 'home_page/admin_home_page.dart';
import 'home_page/user_home_page.dart';

class WelcomeSplashScreen extends StatefulWidget {
  const WelcomeSplashScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeSplashScreen> createState() => _WelcomeSplashScreenState();
}

class _WelcomeSplashScreenState extends State<WelcomeSplashScreen> {

  @override
  void initState() {
    super.initState();
    checkRole();
  }

  void checkRole() async{
    bool isAdmin = false;
    User user = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot snap =
    await FirebaseFirestore.instance.collection("users").doc(user.uid).get();
    setState(() {
      isAdmin = snap["isAdmin"];
    });
    if(isAdmin == false) {
      navigateTo(UserHomePage.routeName);
    } else {
      navigateTo(AdminHomePage.routeName);
    }
  }

  navigateTo(String newRouteName) {
    Timer(const Duration(seconds: 1), () {
      Navigator.pushNamedAndRemoveUntil(context, newRouteName, (route) => false);
    });

  }

  @override
  Widget build(BuildContext context) {
    return const StatusBarColorChanger(
      isDark: false,
      child: Scaffold(
        body: Center(
          child: EText(text: "Welcome "),
        ),
      ),
    );
  }
}
