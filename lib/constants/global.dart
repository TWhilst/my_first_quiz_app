import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/global_widgets/circles_with_lives.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';
import 'package:my_first_quiz_app/users/view_model/user_details_view_model.dart';
import 'package:my_first_quiz_app/users/views/home_page/inner_home_screens/categories_screen/inner_screen/quiz_screen.dart';
import 'package:provider/provider.dart';
import '../global_widgets/lives_timer.dart';
import 'constants.dart';

class Global {
  static Future<void> showAdBox(BuildContext context) async{
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            const EText(text: "Get coins", selectSize: true, weight: FontWeight.w600,),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset("assets/images/close_icon.png",  fit: BoxFit.cover,),
              ),
            ),
          ],
        ),
        titlePadding: const EdgeInsets.only(left: 10, right: 10, top: 20,),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const EText(text: "Coins in the chest: 23", isTitle: true, size: 17,),
            const SizedBox(height: 10,),
            Image.asset("assets/images/chest.png"),
            const EText(
              text: "Watch the video \nto get 10 coins. \nA maximum of 99 coins can be placed in the chest",
              textAlign: TextAlign.center,
              size: 14,
            ),
          ],
        ),
        contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 24, top: 24),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: MaterialButton(
              onPressed: () {},
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
              child: EText(text: "Watch the video".toUpperCase(), size: 14, selectSize: true, weight: FontWeight.w900,),
            ),
          ),
        ],
        actionsPadding: const EdgeInsets.only(bottom: 10),
      ),
    );
  }

  static Future<void> showLivesBox(BuildContext context) async{
    final isFull = Provider.of<UserDetailsViewModel>(context, listen: false).fullLives;
    if(isFull == true) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              const EText(text: "Replenishing lives", selectSize: true, weight: FontWeight.w600,),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 20,
                  width: 20,
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset("assets/images/close_icon.png",  fit: BoxFit.cover,),
                ),
              ),
            ],
          ),
          titlePadding: const EdgeInsets.only(left: 10, right: 10, top: 20,),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              EText(text: "You have maximum lives", selectSize: true, weight: FontWeight.w500,),
              SizedBox(height: 30,),
              CirclesWithLives(),
              SizedBox(height: 30,),
              EText(
                text: "Keep playing! \nThere are many interesting and useful things ahead!",
                textAlign: TextAlign.center,
                size: 14,
              ),
            ],
          ),
          contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 34, top: 34),
        ),
      );
    } else {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              const EText(text: "Replenishing lives", selectSize: true, weight: FontWeight.w600,),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 20,
                  width: 20,
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset("assets/images/close_icon.png",  fit: BoxFit.cover,),
                ),
              ),
            ],
          ),
          titlePadding: const EdgeInsets.only(left: 10, right: 10, top: 20,),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  EText(text: "Lives will appear through", selectSize: true, weight: FontWeight.w400, size: 14,),
                  SizedBox(height: 5,),
                  LivesTimer(),
                ],
              ),
              const SizedBox(height: 30,),
              const CirclesWithLives(),
              const SizedBox(height: 30,),
              const EText(
                text: "You can collect the maximum lives and not wait by watching a short video",
                textAlign: TextAlign.center,
                size: 14,
              ),
            ],
          ),
          contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 2, top: 34),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: MaterialButton(
                onPressed: () {},
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
                child: EText(text: "Watch the video".toUpperCase(), size: 14, selectSize: true, weight: FontWeight.w900,),
              ),
            ),
          ],
          actionsPadding: const EdgeInsets.only(bottom: 10),
        ),
      );
    }

  }

  static Future<void> showProgressBox(BuildContext context) async{
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            const EText(text: "Reset game progress", selectSize: true, weight: FontWeight.w600,),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset("assets/images/close_icon.png",  fit: BoxFit.cover,),
              ),
            ),
          ],
        ),
        titlePadding: const EdgeInsets.only(left: 10, right: 10, top: 20,),
        content: const EText(
          text: "Are you sure you want to reset the passed \ngame questions?",
          textAlign: TextAlign.center,
          size: 16,
          height: 1.2,
        ),
        contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 24),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: MaterialButton(
              onPressed: () {},
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
              child: EText(text: "Reset game progress".toUpperCase(), size: 14, selectSize: true, weight: FontWeight.w900,),
            ),
          ),
        ],
        actionsPadding: const EdgeInsets.only(bottom: 10),
      ),
    );
  }

  int index(BuildContext context) {
    final user = context.watch<QuerySnapshot>();
    int value = 0;
    if(value < user.docs.length) {
      value++;
    }
    return value;
  }

}





