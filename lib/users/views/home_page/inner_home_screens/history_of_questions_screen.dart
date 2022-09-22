import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';
import 'package:my_first_quiz_app/users/view_model/home_view_model.dart';
import 'package:my_first_quiz_app/users/views/home_page/inner_home_screens/common_widgets/landing_app_bar.dart';
import 'package:provider/provider.dart';

class HistoryOfQuestionsScreen extends StatelessWidget {
  static const routeName = "/HistoryOfQuestionsScreen";
  const HistoryOfQuestionsScreen({Key? key}) : super(key: key);
  
  Widget customListTile() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          EText(text: "Copenhagen", color: Colors.red, isTitle: true, size: 14,),
          EText(text: "What is the capital of Denmark?", size: 14,),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    HomeViewModel getHomeState = context.watch<HomeViewModel>();
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
                    itemCount: 15,
                    itemBuilder: (context, index) => customListTile(),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
