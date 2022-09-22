import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';

class Utils {

  static void showSnackBar({
    required String content,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: EText(text: content),
        behavior: SnackBarBehavior.floating,
        backgroundColor: MyColor.blue,
        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 16),
        // shape: StadiumBorder(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(width: 1, color: Colors.white,),
        ),
        elevation: 3,
        dismissDirection: DismissDirection.up,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 730),
        // margin: const EdgeInsets.fromLTRB(20, 0, 20, 600),
      ),
    );
  }
}