
import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';

class BlueButton extends StatelessWidget {
  const BlueButton({
    Key? key, required this.text, this.size = 40,
    this.padding = 20, this.height = 65,
    this.color = const Color(0xFF00a6d3), this.onPressed,
  }) : super(key: key);
  final String text;
  final double size, padding, height;
  final Color color;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: MaterialButton(
        onPressed: onPressed ?? () {},
        color: color,
        // splashColor: const Color(0xFF0080a3),
        highlightColor: const Color(0xFF0080a3),
        minWidth: double.maxFinite,
        height: height,
        elevation: 5,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 5, color: Colors.white,),
          borderRadius: BorderRadius.circular(15),
        ),
        child: EText(text: text.toUpperCase(), color: Colors.white, size: size, isTitle: true,),
      ),
    );
  }
}
