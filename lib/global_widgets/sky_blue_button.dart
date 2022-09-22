import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';

class SkyBlueButton extends StatelessWidget {
  const SkyBlueButton({
    Key? key, required this.text,this.padding = 20,
    this.color = Colors.black, required this.onPressed,
    this.inSmallz = false, this.height = 45, this.size = 14, this.backgroundColor = const Color(0xFFa3ebf9),
  }) : super(key: key);
  final String text;
  final double padding, height, size;
  final Color color, backgroundColor;
  final Function() onPressed;
  final bool inSmallz;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: MaterialButton(
        onPressed: onPressed,
        color:backgroundColor,
        // splashColor: const Color(0xFF0080a3),
        highlightColor: const Color(0xFF79bbc7),
        minWidth: double.maxFinite,
        height: height,
        elevation: 5,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 5, color: Colors.white,),
          borderRadius: BorderRadius.circular(15),
        ),
        child: EText(text: inSmallz? text : text.toUpperCase(), size: size, selectSize: true, weight: FontWeight.w900, color: color,),
      ),
    );
  }
}
