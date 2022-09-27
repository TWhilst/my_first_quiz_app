import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';

class QuizOptions extends StatelessWidget {
  final double? width;
  final String text;
  final String? minus;
  final double? stackLeft;
  final Function()? onPressed;
  final double? elevation;
  const QuizOptions({
    Key? key, this.width, required this.text, this.minus, this.stackLeft, this.onPressed, this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5, left: 0, bottom: 7),
          child: MaterialButton(
            onPressed: onPressed ?? () {},
            color:MyColor.lightBlue,
            // splashColor: const Color(0xFF0080a3),
            highlightColor: const Color(0xFF79bbc7),
            minWidth: width ?? 160,
            height: 45,
            elevation: elevation ?? 5,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 5, color: Colors.white,),
              borderRadius: BorderRadius.circular(15),
            ),
            child: EText(text: text.toUpperCase(), size: 14, selectSize: true, weight: FontWeight.w900, color: Colors.black,),
          ),
        ),
        Positioned(
          left: stackLeft ?? 132,
          top: 22,
          child: Container(
            height: 30,
            width: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: MyColor.gold,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: EText(text: minus ?? "-2", isTitle: true,),
            ),
          ),
        ),
      ],
    );
  }
}
