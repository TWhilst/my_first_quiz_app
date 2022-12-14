import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/global_widgets/loading_screen.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';
import 'package:my_first_quiz_app/model/sign_up_model.dart';
import 'package:my_first_quiz_app/users/view_model/user_details_view_model.dart';
import 'package:my_first_quiz_app/users/views/home_page/inner_home_screens/categories_screen/categories_screen.dart';
import 'package:my_first_quiz_app/users/views/home_page/inner_home_screens/history_of_questions_screen.dart';
import 'package:my_first_quiz_app/utils/route_storage.dart';
import 'package:provider/provider.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({
    Key? key, this.sign,
  }) : super(key: key);
  final SignUpModel? sign;

  @override
  Widget build(BuildContext context) {
    final details = context.watch<UserDetailsViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: MaterialButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            CategoriesScreen.routeName,
          );
          if(sign == null) {

          }else {
            details.getSignUpDetails(sign!);
          }

        },
        color: MyColor.darkBlue,
        // splashColor: const Color(0xFF0080a3),
        highlightColor: const Color(0xFF0080a3),
        minWidth: double.maxFinite,
        height: 65,
        elevation: 5,
        // padding: const EdgeInsets.only(bottom: 6),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 5, color: Colors.white,),
          borderRadius: BorderRadius.circular(15),
        ),
        child: EText(text: "Play".toUpperCase(), color: Colors.white, size: 40, isTitle: true,),
      ),
    );
  }
}

class TextFacts extends StatelessWidget {
  const TextFacts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 3,),
        child: EText(
          text: "You can see your answers and read interesting facts", size: 14,
          selectSize: true, weight: FontWeight.w400,
        ),
      ),
    );
  }
}

class CompletedButton extends StatelessWidget {
  const CompletedButton({
    Key? key, required this.sign,
  }) : super(key: key);

  final SignUpModel? sign;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: MaterialButton(
        onPressed: () => Navigator.pushNamed(context, HistoryOfQuestionsScreen.routeName),
        color: MyColor.lightBlue,
        // splashColor: const Color(0xFF0080a3),
        highlightColor: const Color(0xFF79bbc7),
        minWidth: double.maxFinite,
        height: 50,
        elevation: 5,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 5, color: Colors.white,),
          borderRadius: BorderRadius.circular(15),
        ),
        child: EText(
          text: "Completed Levels: ${sign!.answeredCorrectly}/${sign!.totalDone}".toUpperCase(),
          size: 14, selectSize: true,
          weight: FontWeight.w900,
        ),
      ),
    );
  }
}