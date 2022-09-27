import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';

class OptionsTile extends StatelessWidget {
  final String title;
  final Function() onTap;
  final Color color;
  const OptionsTile({Key? key, required this.title, required this.onTap, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, top: 0, bottom: 10, right: 20),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Container(
              padding: const EdgeInsets.only(left: 10, top: 15, bottom: 14),
              margin: const EdgeInsets.only(left: 0, top: 0, bottom: 1.5, right: 0),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
              child: EText(text: title, isTitle: true, size: 14,),
            ),
          ),
          // Container(
          //   height: 1,
          //   margin: const EdgeInsets.only(left: 20, right: 20),
          //   width: double.maxFinite,
          //   decoration: const BoxDecoration(
          //     color: Colors.black,
          //   ),
          // ),
        ],
      ),
    );
  }
}
