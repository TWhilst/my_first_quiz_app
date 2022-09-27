import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';

class CompletedQuiz extends StatelessWidget {
  static const routeName = "/CompletedQuiz";
  const CompletedQuiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: EText(text: "Congratulations", size: 22, color: Colors.black,),
        ),
      ),
    );
  }
}
