import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/constants/global.dart';
import 'package:my_first_quiz_app/global_widgets/loading_screen.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';
import 'package:my_first_quiz_app/model/category_model.dart';
import 'package:my_first_quiz_app/model/sign_up_model.dart';
import 'package:my_first_quiz_app/users/view_model/home_view_model.dart';
import 'package:my_first_quiz_app/users/views/home_page/inner_home_screens/categories_screen/inner_screen/quiz_screen_2.dart';
import 'package:provider/provider.dart';

import '../../../../view_model/user_details_view_model.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = "/CategoriesScreen";
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeViewModel getHomeState = context.watch<HomeViewModel>();
    return StreamBuilder<QuerySnapshot?>(
      stream: FirebaseFirestore.instance.collection("Categories").snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          final snap = snapshot.data!.docs;
          return Scaffold(
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //     print(details.signUp!.points);
            //   },
            // ),
            backgroundColor: MyColor.skyBlue,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only( top: 10, bottom: 20),
                      child: StreamBuilder<DocumentSnapshot?>(
                        stream: FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                        builder: (context, details) {
                          if(details.hasData) {
                            SignUpModel sign = SignUpModel.fromJson(details.data!);
                            return Row(
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
                                        child: Center(
                                          child: EText(text: "${sign.points}", isTitle: true, size: 16,),
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
                                            child: EText(text: "${sign.lives}", isTitle: true, size: 16, color: Colors.white,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return Container(
                              width: double.maxFinite,
                              color: MyColor.skyBlue,
                            );
                          }

                        }
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
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
                                children: const [
                                  CircleAvatar(
                                    radius: 22,
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.white,
                                    foregroundImage: AssetImage(
                                      "assets/images/random.png",

                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  EText(text: "Random Questions", isTitle: true,),
                                ],
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snap.length,
                              itemBuilder: (context, index) {
                                CategoryModel category = CategoryModel.fromJson(snap[index]);
                                return InkWell(
                                  borderRadius: BorderRadius.circular(8),
                                  onTap: () {
                                    Navigator.pushNamed(context, QuizScreen2.routeName);
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
                                        CircleAvatar(
                                          radius: 22,
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.white,
                                          foregroundImage: CachedNetworkImageProvider(category.image!),
                                        ),
                                        const SizedBox(width: 10,),
                                        EText(text: category.category!, isTitle: true,),
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }else{
          return const LoadingScreen();
        }

      }
    );
  }
}
