import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/constants/global.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';
import 'package:my_first_quiz_app/users/view_model/home_view_model.dart';
import 'package:my_first_quiz_app/users/views/home_page/inner_home_screens/Admin/input_details/input_details.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget {
  final String? currentUser;
  const HomeAppBar({
    Key? key, this.currentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = currentUser ?? "";
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
                  child: const Center(child: Text("22"),),
                ),
              ),
              const SizedBox(width: 20,),
              InkWell(
                onTap: () {
                  getHomeState.setTapped = false;
                  Global.showLivesBox(context);
                },
                child: const Icon(
                  Icons.favorite,
                  color: MyColor.heart,
                  size: 40,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}