import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';
import 'package:my_first_quiz_app/global_widgets/sky_blue_button.dart';
import 'package:my_first_quiz_app/users/view_model/home_view_model.dart';
import 'package:my_first_quiz_app/users/views/home_page/inner_home_screens/common_widgets/landing_app_bar.dart';
import 'package:provider/provider.dart';

class AboutTheGameScreen extends StatelessWidget {
  static const routeName = "/AboutTheGameScreen";
  const AboutTheGameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeViewModel getHomeState = context.watch<HomeViewModel>();
    return Scaffold(
      backgroundColor: MyColor.skyBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LandingAppBar(getHomeState: getHomeState, title: "About the game"),

              const SizedBox(height: 20,),
              const EText(text: "About the game", isTitle: true, size: 18,),
              const SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                 EText(text: "Version", size: 14,),
                 EText(text: "3.1.4", size: 14,),
                ],
              ),

              const SizedBox(height: 10,),
              const EText(text: "Terms & Conditions", size: 14,),

              const SizedBox(height: 10,),
              const EText(text: "Privacy Policy", size: 14,),

              const SizedBox(height: 20,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(thickness: 2.5, color: Colors.white,),
              ),

              const SizedBox(height: 20,),
              SkyBlueButton(
                text: "Feedback",
                onPressed: () {},
                color: Colors.white,
                padding: 0,
                inSmallz: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
