import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/global_widgets/loading_screen.dart';
import 'package:my_first_quiz_app/global_widgets/status_bar_color_changer.dart';
import 'package:my_first_quiz_app/model/sign_up_model.dart';
import 'package:my_first_quiz_app/users/view_model/home_view_model.dart';
import 'package:my_first_quiz_app/users/view_model/user_details_view_model.dart';
import 'package:provider/provider.dart';
import 'components/button_with_facts.dart';
import 'components/home_app_bar.dart';
import 'components/menu_bar_items.dart';
import 'components/side_icon_with_world_image.dart';

class UserHomePage extends StatefulWidget {
  static const routeName = "/UserHomePage";
  const UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {

  @override
  Widget build(BuildContext context) {
    HomeViewModel getHomeState = context.watch<HomeViewModel>();
    return getHomeState.isTapped?
    landingPage(context, getHomeState) :
    buildHomePage(getHomeState, context);
  }
}

Widget landingPage(BuildContext context, HomeViewModel getHomeState) {
  return const SafeArea(
    child: MenuBarItems(),
  );
}

Widget buildHomePage(HomeViewModel getHomeState, BuildContext context) {
  return StatusBarColorChanger(
    isDark: false,
    child: StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          // DocumentSnapshot snap = snapshot.data!;
          SignUpModel sign = SignUpModel.fromJson(snapshot.data!);
          return Scaffold(
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //   },
            // ),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeAppBar(sign: sign,),
                  const SizedBox(height: 25,),
                  const SideIcon(),
                  const WorldImage(),
                  const PlayButton(),
                  const TextFacts(),
                  const SizedBox(height: 10,),
                  CompletedButton(sign: sign,),
                ],
              ),
            ),
          );
        } else {
          return const LoadingScreen();
        }

      }
    ),
  );
}