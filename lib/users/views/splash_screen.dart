import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart" ;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/global_widgets/status_bar_color_changer.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';
import 'package:my_first_quiz_app/services/firebase_auth.dart';
import 'package:my_first_quiz_app/users/views/home_page/admin_home_page.dart';
import 'package:my_first_quiz_app/users/views/users_details_screen/login_screen.dart';
import 'package:my_first_quiz_app/users/views/welcome_splash_screen.dart';

import 'home_page/user_home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {




  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) {
          // return const LoginScreen();
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.active) {
                if(snapshot.hasData) {
                  return const WelcomeSplashScreen();
                } else if(snapshot.hasError) {
                  return Center(
                    child: EText(text: snapshot.error.toString()),
                  );
                }
              }
              if(snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LoadingAnimationWidget.threeArchedCircle(color: Colors.white, size: 40),
                );
              }
              return const LoginScreen();
            }
          );
        }), (route) => false,
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return StatusBarColorChanger(
      isDark: false,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: 0.4,
            child: Image.asset("assets/images/splash.png", fit: BoxFit.fitHeight,),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.only(bottom: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Resolve",
                    style: TextStyle(color: MyColor.blue, decoration: TextDecoration.none),
                  ),
                  Text(
                    "Test yourself with our amazing set of questions.",
                    style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: 12),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
