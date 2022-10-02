import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_first_quiz_app/constants/constants.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.skyBlue,
      body: SafeArea(
        child: Center(
          child: LoadingAnimationWidget.threeArchedCircle(color: Colors.black, size: 40),
        ),
      ),
    );
  }
}
