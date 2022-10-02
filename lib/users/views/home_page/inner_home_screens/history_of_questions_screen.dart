import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';
import 'package:my_first_quiz_app/model/completed_level_model.dart';
import 'package:my_first_quiz_app/users/view_model/home_view_model.dart';
import 'package:my_first_quiz_app/users/views/home_page/inner_home_screens/common_widgets/landing_app_bar.dart';
import 'package:provider/provider.dart';

import '../../../../global_widgets/loading_screen.dart';

class HistoryOfQuestionsScreen extends StatelessWidget {
  static const routeName = "/HistoryOfQuestionsScreen";
  const HistoryOfQuestionsScreen({Key? key}) : super(key: key);
  
  Widget customListTile({
    required String title,
    required String question,
    required bool isCorrect,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EText(text: title, color: isCorrect? Colors.green : Colors.red, isTitle: true, size: 14,),
          const SizedBox(height: 5,),
          EText(text: question, size: 14,selectSize: true, weight: FontWeight.w400,),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    HomeViewModel getHomeState = context.watch<HomeViewModel>();
    return StreamBuilder<QuerySnapshot?>( 
      stream: FirebaseFirestore.instance.collection(FireConst.completedLevel).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
         List <QueryDocumentSnapshot> snap = snapshot.data!.docs;
          return Scaffold(
            backgroundColor: MyColor.skyBlue,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8),
                child: Column(
                  children: [
                    LandingAppBar(getHomeState: getHomeState, title: "History of questions", hasIcon: true,),
                    MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snap.length,
                          itemBuilder: (context, index) {
                            CompletedLevelModel level = CompletedLevelModel.fromJson(snap[index]);
                            return customListTile(
                              title: level.selectedOption!,
                              question: level.question!,
                              isCorrect: level.isCorrect,
                            );
                          }
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
          );
        } else {
          return const LoadingScreen();
        }

      }
    );
  }
}
