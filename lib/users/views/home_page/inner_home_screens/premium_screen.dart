import "package:flutter/material.dart" ;
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';
import 'package:my_first_quiz_app/global_widgets/sky_blue_button.dart';
import 'package:my_first_quiz_app/users/view_model/home_view_model.dart';
import 'package:my_first_quiz_app/users/views/home_page/inner_home_screens/common_widgets/landing_app_bar.dart';
import 'package:provider/provider.dart';

import 'common_widgets/BlueButton.dart';

class PremiumScreen extends StatelessWidget {
  static const routeName = "/PremiumScreen";
  const PremiumScreen({Key? key}) : super(key: key);

  Widget listDetails({
    required dynamic icon,
    required String title,
    required bool isImage,
  }) {
    return ListTile(
      leading: isImage? Image.asset(icon,) : Icon(icon, size: 60, color: Colors.black,),
      title: EText(text: title.toUpperCase(), size: 18, selectSize: true, weight: FontWeight.w600,),
    );
  }

  @override
  Widget build(BuildContext context) {
    HomeViewModel getHomeState = context.watch<HomeViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              LandingAppBar(getHomeState: getHomeState, title: ""),
              const SizedBox(height: 20,),
              Image.asset("assets/images/crown.png"),
              listDetails(icon: Icons.key, title: "New Parmanent Content", isImage: false),
              const SizedBox(height: 10,),
              listDetails(icon: "assets/images/ad.png", title: "no ads", isImage: true),
              const SizedBox(height: 10,),
              listDetails(icon: Icons.favorite, title: "unlimited lives", isImage: false),
              const SizedBox(height: 10,),
              listDetails(icon: "assets/images/coin.png", title: "unlimited coins", isImage: true),
              const SizedBox(height: 20,),
              SkyBlueButton(
                text: "Buy- ₦1,530.00", onPressed: () {}, padding: 0, 
                backgroundColor: MyColor.blue, height: 50,size: 24, color: Colors.white,
              ),
              SizedBox(height: 20,),
              EText(
                text: "*Sometimes, purchase processing may not happen instantly. in case you don't see any changes,try restarting the application.". toUpperCase(),
                size: 14, selectSize: true, textAlign: TextAlign.center, weight: FontWeight.w900,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
