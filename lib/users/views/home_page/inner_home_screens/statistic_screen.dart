import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';
import 'package:my_first_quiz_app/users/view_model/home_view_model.dart';
import 'package:my_first_quiz_app/users/views/home_page/inner_home_screens/common_widgets/landing_app_bar.dart';
import 'package:provider/provider.dart';

class StatisticScreen extends StatelessWidget {
  static const routeName = "/StatisticScreen";
  const StatisticScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeViewModel getHomeState = context.watch<HomeViewModel>();
    return Scaffold(
      backgroundColor: MyColor.skyBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LandingAppBar(getHomeState: getHomeState, title: "Statistic"),
              // const SizedBox(height: 30,),
              Expanded(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 10, 
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: imageWithSection(),
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
  }

  Material imageWithSection() {
    return Material(
            color: Colors.white,
            type: MaterialType.card,
            borderRadius: BorderRadius.circular(7),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0,top: 8, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 22,
                    foregroundColor: Colors.transparent,
                    foregroundImage: CachedNetworkImageProvider("https://static.vecteezy.com/system/resources/previews/000/455/720/original/waterfall-scene-with-big-mountains-in-background-vector.jpg"),
                  ),
                  const Spacer(),
                  const SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const EText(text: "Waterfalls", isTitle: true,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: const [
                              EText(text: "Correct", size: 14,),
                              EText(text: "0 (0.0%)", color: Colors.green, size: 14,)
                            ],
                          ),
                          const SizedBox(width: 80,),
                          Column(
                            children: const [
                              EText(text: "Wrong", size: 14,),
                              EText(text: "1 (100.0%)", color: Colors.red, size: 14,)
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          );
  }
}
