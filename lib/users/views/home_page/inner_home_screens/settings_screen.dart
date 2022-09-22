import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/constants/global.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';
import 'package:my_first_quiz_app/global_widgets/sky_blue_button.dart';
import 'package:my_first_quiz_app/users/view_model/home_view_model.dart';
import 'package:my_first_quiz_app/users/views/home_page/inner_home_screens/common_widgets/landing_app_bar.dart';
import 'package:provider/provider.dart';

import 'common_widgets/BlueButton.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = "/SettingsScreen";
  const SettingsScreen({Key? key}) : super(key: key);



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
              Padding(
                padding: const EdgeInsets.only(),
                child: LandingAppBar(getHomeState: getHomeState, title: "Settings",),
              ),
              const SizedBox(height: 20,),
              CheckboxListTile(
                value: getHomeState.isChecked1,
                focusNode: FocusNode(
                    descendantsAreFocusable: false,
                    skipTraversal: true,
                    descendantsAreTraversable: false
                ),
                onChanged: (value) {
                  getHomeState.setChecked1 = value!;
                },
                dense: false,
                selectedTileColor: const Color(0xFFa3ebf9),
                title: const EText(text: "Sounds", size: 14,),
                contentPadding: EdgeInsets.zero,
                activeColor: const Color(0xFFa3ebf9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                side: const BorderSide(width: 9, color: Color(0xFFa3ebf9),),
              ),

              CheckboxListTile(
                value: getHomeState.isChecked2,
                onChanged: (value) {
                  getHomeState.setChecked2 = value!;
                },
                dense: false,
                selectedTileColor: const Color(0xFFa3ebf9),
                title: const EText(text: "Vibrations", size: 14,),
                contentPadding: EdgeInsets.zero,
                activeColor: const Color(0xFFa3ebf9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                side: const BorderSide(width: 9, color: Color(0xFFa3ebf9),),
              ),

              CheckboxListTile(
                value: getHomeState.isChecked3,
                focusNode: FocusNode(
                    descendantsAreFocusable: false,
                    skipTraversal: true,
                    descendantsAreTraversable: false
                ),
                onChanged: (value) {
                  getHomeState.setChecked3 = value!;
                },
                dense: false,
                selectedTileColor: const Color(0xFFa3ebf9),
                title: const EText(text: "Skip loading screen", size: 14,),
                contentPadding: EdgeInsets.zero,
                activeColor: const Color(0xFFa3ebf9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                side: const BorderSide(width: 9, color: Color(0xFFa3ebf9),),
              ),

              CheckboxListTile(
                value: getHomeState.isChecked4,
                focusNode: FocusNode(
                    descendantsAreFocusable: false,
                    skipTraversal: true,
                    descendantsAreTraversable: false
                ),
                onChanged: (value) {
                  getHomeState.setChecked4 = value!;
                },
                dense: false,
                selectedTileColor: const Color(0xFFa3ebf9),
                title: const EText(text: "Notification", size: 14,),
                contentPadding: EdgeInsets.zero,
                activeColor: const Color(0xFFa3ebf9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                side: const BorderSide(width: 9, color: Color(0xFFa3ebf9),),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Divider(color: Colors.white, thickness: 2.5,),
              ),

              const SizedBox(height: 15,),
              const BlueButton(text: "Image Caching", size: 16, height: 50,padding: 0, color: MyColor.blue,),

              const SizedBox(height: 10,),
              const EText(
                text: "*To play without the internet, for complete convenience, you need to save the pictures of the quizzes. To do this, click on image caching, wait a short time and after that you can safely play with or without the internet!",
                size: 14,
                selectSize: false,
                weight: FontWeight.w600,
                height: 1.2,
              ),

              const SizedBox(height: 30,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Divider(color: Colors.white, thickness: 2.5,),
              ),

              const SizedBox(height: 20,),
              SkyBlueButton(
                text: "Reset game progress",
                padding: 0, color: Colors.white,
                onPressed: () {
                  Global.showProgressBox(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }


}


