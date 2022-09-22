import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';

class CirclesWithLives extends StatelessWidget {
  const CirclesWithLives({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 140,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(width: 3, color: MyColor.heart)
      ),
      child: Container(
        height: 120,
        width: 120,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(width: 3, color: MyColor.heart)
        ),
        child: Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(width: 3, color: MyColor.heart)
          ),
          child: Stack(
            alignment: Alignment.center,
            children: const [
              Icon(Icons.favorite, color: MyColor.heart, size: 90,),
              EText(text: "3", selectSize: true, weight: FontWeight.w900, size: 40, color: Colors.white,),
            ],
          ),
        ),
      ),
    );
  }
}