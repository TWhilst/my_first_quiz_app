import 'package:flutter/material.dart';

class EText extends StatelessWidget {
  final String text;
  final Color color;
  final bool isTitle, selectSize;
  final FontWeight weight;
  final double size, height;
  final TextAlign textAlign;
  const EText({
    Key? key, required this.text, this.color = Colors.black,
    this.isTitle = false, this.selectSize = false,
    this.size = 16, this.weight = FontWeight.normal, this.textAlign = TextAlign.left, this.height = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fontWeight = isTitle? FontWeight.w700 : selectSize? weight : FontWeight.normal;
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: size,
        height: height
      ),
    );
  }
}
