import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/constants/global.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';
import 'package:my_first_quiz_app/users/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

import 'inner_screen/quiz_screen.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = "/CategoriesScreen";
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeViewModel getHomeState = context.watch<HomeViewModel>();
    return Scaffold(
      backgroundColor: MyColor.skyBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only( top: 10, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// BACK ICON

                    InkWell(
                      borderRadius: BorderRadius.circular(17.5),
                      onTap: () {
                        getHomeState.setTapped = false;
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(1),
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                            color: MyColor.skyBlue,
                            border: Border.all(color: Colors.black, width: 3),
                            shape: BoxShape.circle
                        ),
                        child: const Icon(
                          Icons.arrow_back_sharp,
                          size: 23,
                          shadows: [
                            Shadow(
                              offset: Offset(1, 0),
                            ),
                            Shadow(
                              offset: Offset(0, 0.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    /// TEXT
                    const EText(text: "Categories", selectSize: true, size: 19, weight: FontWeight.w600,),

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
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: const[
                            CircleAvatar(
                              radius: 22,
                              foregroundColor: Colors.transparent,
                              foregroundImage: CachedNetworkImageProvider("https://www.bing.com/th?id=OIP.Xl24fgQvfe320Bv5HXp2DAHaEK&w=164&h=100&c=8&rs=1&qlt=90&o=6&pid=3.1&rm=2"),
                            ),
                            SizedBox(width: 10,),
                            EText(text: "Random Questions", isTitle: true,),
                          ],
                        ),
                      ),
                      // child: MediaQuery.removePadding(
                      //   context: context,
                      //   removeTop: true,
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              Navigator.pushNamed(context, QuizScreen.routeName);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)
                              ),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 22,
                                    foregroundColor: Colors.transparent,
                                    foregroundImage: CachedNetworkImageProvider("https://www.bing.com/th?id=OIP.Xl24fgQvfe320Bv5HXp2DAHaEK&w=164&h=100&c=8&rs=1&qlt=90&o=6&pid=3.1&rm=2"),
                                  ),
                                  const SizedBox(width: 10,),
                                  const EText(text: "Europe", isTitle: true,),
                                  const Spacer(),
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color(0xFFe2e3e5),
                                    ),

                                    child: Image.asset("assets/images/clear.png",),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
