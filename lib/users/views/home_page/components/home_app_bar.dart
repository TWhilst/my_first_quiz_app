import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/constants/global.dart';
import 'package:my_first_quiz_app/global_widgets/lives_timer.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';
import 'package:my_first_quiz_app/model/sign_up_model.dart';
import 'package:my_first_quiz_app/users/view_model/home_view_model.dart';
import 'package:my_first_quiz_app/users/views/home_page/inner_home_screens/Admin/input_details/input_details.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget {
  final String? currentUser;
  final SignUpModel? sign;
  const HomeAppBar({
    Key? key, this.currentUser, required this.sign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = currentUser ?? "";
    LivesTimer global = LivesTimer();
    HomeViewModel getHomeState = context.watch<HomeViewModel>();
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20,top: 20 ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              getHomeState.setTapped = true;
            },
            child: const Icon(
              Icons.menu_sharp,
              color: Colors.black,
              size: 40,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              if(currentUser != null) {
                Navigator.pushNamed(context, InputDetails.routeName);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: EText(text: title, size: 18, isTitle: true,),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  getHomeState.setTapped = false;
                  Global.showAdBox(context);
                },
                child: Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: MyColor.gold,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: EText(text: "${sign!.points}", isTitle: true, size: 16,),
                  ),
                ),
              ),
              const SizedBox(width: 20,),
              InkWell(
                onTap: () {
                  getHomeState.setTapped = false;
                  Global.showLivesBox(context);
                },
                child: Stack(
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: MyColor.heart,
                      size: 40,
                    ),
                    Positioned(
                      top: 11,
                      left: 16,
                      child: EText(text: "${sign!.lives}", isTitle: true, size: 16, color: Colors.white,),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}