import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';
import 'package:my_first_quiz_app/model/sign_up_model.dart';

class CirclesWithLives extends StatelessWidget {
  const CirclesWithLives({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          SignUpModel sign = SignUpModel.fromJson(snapshot.data!);
          return Container(
            height: 160,
            width: 160,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(width: 3, color: MyColor.heart)
            ),
            child: Container(
              // height: 160,
              // width: 160,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(width: 3, color: MyColor.heart)
              ),
              child: Container(
                // height: 140,
                // width: 140,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(width: 3, color: MyColor.heart)
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(7.0),
                      child: Icon(Icons.favorite, color: MyColor.heart, size: 100,),
                    ),
                    EText(text: "${sign.lives}", selectSize: true, weight: FontWeight.w900, size: 40, color: Colors.white,),
                  ],
                ),
              ),
            ),
          );
        } else{
          return Center(
            child: LoadingAnimationWidget.bouncingBall(color: Colors.black, size: 40),
          );
        }

      }
    );
  }
}