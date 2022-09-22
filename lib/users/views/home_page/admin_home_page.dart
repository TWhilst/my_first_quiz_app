import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/users/view_model/home_view_model.dart';
import 'package:provider/provider.dart';
import 'components/button_with_facts.dart';
import 'components/home_app_bar.dart';
import 'components/menu_bar_items.dart';
import 'components/side_icon_with_world_image.dart';

class AdminHomePage extends StatelessWidget {
  static const routeName = "/AdminHomePage";
  const AdminHomePage({Key? key}) : super(key: key);
  
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

Scaffold buildHomePage(HomeViewModel getHomeState, BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          HomeAppBar(currentUser: "Admin",),
          SizedBox(height: 25,),
          SideIcon(),
          WorldImage(),
          PlayButton(),
          TextFacts(),
          SizedBox(height: 10,),
          CompletedButton(),
        ],
      ),
    ),
  );
}





