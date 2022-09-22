import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';
import 'package:my_first_quiz_app/users/view_model/home_view_model.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import 'common_widgets/landing_app_bar.dart';

class InterestingFactsScreen extends StatelessWidget {
  static const routeName = "/InterestingFactsScreen";
  const InterestingFactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeViewModel getHomeState = context.watch<HomeViewModel>();
    return Scaffold(
      backgroundColor: MyColor.skyBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              LandingAppBar(getHomeState: getHomeState, title: "Interesting Facts",),

              Expanded(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => boxWithText(),
                    itemCount: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget boxWithText() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Material(
                  color: const Color(0xFFf5ce55),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 50, left: 30, top: 30, bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// BLACK CIRCLE

                        Container(
                          padding: const EdgeInsets.only(bottom: 2, top: 5),
                          height: 40,
                          width: 40,
                          alignment: FractionalOffset.bottomCenter,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                          child: Transform.rotate(
                            angle: -math.pi/4,
                            child: Image.asset("assets/images/gold_infinity.png"),
                          )
                        ),

                        const SizedBox(height: 30,),
                        const EText(
                          text: "Chocolate contains phenylethylamine (PEA), the same chemical released in your brain when you fall in love.",
                          size: 22,
                          selectSize: true,
                          weight: FontWeight.w900,
                        ),

                        const SizedBox(height: 30,),
                        const SizedBox(
                          width: 130,
                            child: Divider(thickness: 3, color: Colors.black,)
                        ),

                        EText(text: "@8Fact".toUpperCase(),selectSize: true, weight: FontWeight.w600,)
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

