import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/constants/global.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';
import 'package:my_first_quiz_app/model/question_model.dart';
import 'package:my_first_quiz_app/users/view_model/question_provider.dart';
import 'package:my_first_quiz_app/users/views/home_page/inner_home_screens/common_widgets/BlueButton.dart';
import 'package:provider/provider.dart';
import 'components/options_tile.dart';
import 'components/quiz_options.dart';

class QuizScreen extends StatefulWidget {
  static const routeName = "/QuizScreen";
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

    List<String> title = [
      "Canada",
      "Poland",
      "Ukraine",
      "France",
    ];

    String timer = "60";
    int time = 60;

    void startTimer() async {
      const oneSec = Duration(seconds: 1);
      Timer.periodic(oneSec, (Timer t) {
        if(mounted){
          setState(() {
            if(time < 1) {
              t.cancel();
            } else {
              time = time - 1;
            }
            if(isSelected == true) {
              t.cancel();
            }
            if(time < 10) {
              timer = "0$time";
            }else{
              timer = time.toString();
            }

          });
        }

      });
    }

    @override
    void initState() {
      super.initState();
      startTimer();
    }

    bool isSelected = false;
    Color color = Colors.white;
    Color correctColor = Colors.green;
    Color wrongColor = Colors.red;
    Color? neutralColor = Colors.grey[400];

    Map<int,Color?> btnColor = {
      0: Colors.white,
      1: Colors.white,
      2: Colors.white,
      3: Colors.white,
    };

    void checkAnswer(int index, String answer, List option) {
      isSelected = true;
      btnColor = {
        0: Colors.grey[200],
        1: Colors.grey[200],
        2: Colors.grey[200],
        3: Colors.grey[200],
      };
      showAnswer(index, option, answer);
      setState(() {});
    }

    void showAnswer(int index, List option, String answer) {
      if(option[index] == answer){
        btnColor[index] = correctColor;
      } else {
        btnColor[index] = wrongColor;
      }


      if(option[0] == answer) {
        btnColor[0] = correctColor;
      } else if(option[1] == answer) {
        btnColor[1] = correctColor;
      } else if(option[2] == answer) {
        btnColor[2] = correctColor;
      } else if(option[3] == answer) {
        btnColor[3] = correctColor;
      }
    }

    int value = 0;

    void nextQuestion (int value, List<DocumentSnapshot> snap) {
      if(value < snap.length) {
        setState(() {
          value = value + 1;
        });
      }
    }

  @override
  Widget build(BuildContext context) {
    // final user = context.read<QuerySnapshot<Object?>?>();
    // final quest = context.watch<QuestionProvider>();
    //
    // Global global = Global();
    // int value = global.index(context);
    // DocumentSnapshot data = user!.docs[value];
    // QuestionModel question = QuestionModel.fromJson(data);

    return StreamBuilder<QuerySnapshot?>(
      stream: FirebaseFirestore.instance.collection("Questions").snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          // List<DocumentSnapshot> data = snapshot.data!.docs;
          List<DocumentSnapshot> snap = snapshot.data!.docs;
          QuestionModel rule = QuestionModel.fromJson(snap[value]);
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                print("");
              },
            ),
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  elevation: 2,
                  backgroundColor: MyColor.skyBlue,
                  toolbarHeight: 70,
                  pinned: true,
                  title: Padding(
                    padding: const EdgeInsets.only( top: 30, bottom: 20, left: 0, right: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// BACK ICON

                        InkWell(
                          borderRadius: BorderRadius.circular(17.5),
                          onTap: () {
                            // getHomeState.setTapped = false;
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
                              color: Colors.black,
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

                        /// TIMER
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: MyColor.skyBlue,
                            border: Border.all(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "00 : $timer",
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black
                            ),
                          ),
                        ),

                        /// Lives button
                        InkWell(
                          onTap: () {
                            // getHomeState.setTapped = false;
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
                  ),
                ),
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  floating: false,
                  backgroundColor: MyColor.skyBlue,
                  expandedHeight: 230,
                  flexibleSpace: Material(
                    elevation: 2,
                    child: FlexibleSpaceBar(
                      background: Container(
                        // height: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white, width: 10),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: rule.image,
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 15,),
                      EText(text: rule.question),
                      const SizedBox(height: 20,),
                      SizedBox(
                        height: 210,
                        // color: Colors.black,
                        // padding: EdgeInsets.symmetric(vertical: 10),
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          removeBottom: true,
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 4,
                              // padding: EdgeInsets.only(bottom: 5),
                              itemBuilder: (context, index) {
                                return OptionsTile(color: btnColor[index]!, title: rule.option[index],
                                  onTap: () => checkAnswer(index, rule.answer, rule.option),
                                );
                              }
                          ),
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const EText(text: "Coins in the chest:", isTitle: true, size: 14,),
                            const Spacer(),
                            Row(
                              children: [
                                const EText(text: "34/99", isTitle: true, size: 14,),
                                const SizedBox(width: 5,),
                                InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    // getHomeState.setTapped = false;
                                    Global.showAdBox(context);
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: MyColor.gold,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Center(child: Text(""),),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15,),
                      isSelected?
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  children: [
                                    const EText(text: "Interesting facts", isTitle: true, size: 14,),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                                      child: EText(selectSize: false, height: 1.2, weight: FontWeight.w500, size: 14, text: rule.interestingFact, textAlign: TextAlign.center,),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 15,),
                            BlueButton(
                              text: "Next question",
                              size: 14, height: 45, padding: 5,
                              onPressed: () => nextQuestion(value, snap),
                            ),
                            const SizedBox(height: 7,),
                            Row(
                              children: [
                                const SizedBox(width: 5,),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5, left: 0, bottom: 7),
                                  child: MaterialButton(
                                    onPressed: () {},
                                    color:MyColor.lightBlue,
                                    // splashColor: const Color(0xFF0080a3),
                                    highlightColor: const Color(0xFF79bbc7),
                                    minWidth: 230,
                                    height: 45,
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(width: 5, color: Colors.white,),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: EText(text: "Wikipedia".toUpperCase(), size: 14, selectSize: true, weight: FontWeight.w900, color: Colors.white,),
                                  ),
                                ),
                                const Spacer(),
                                const Icon(Icons.star_border_outlined, color: Colors.white, size: 50,),
                                const Spacer(),
                                const Icon(Icons.email_outlined, color: Colors.white, size: 50,),
                                const SizedBox(width: 5,),
                              ],
                            ),
                            const SizedBox(height: 103,),
                          ],
                        ),
                      ) :
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: const [
                                QuizOptions(text: "50 : 50",),
                                Spacer(),
                                QuizOptions(text: "+30 sec",),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: QuizOptions(text: "Show answer", minus: "-4", width: double.maxFinite, stackLeft: 332,),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: LoadingAnimationWidget.threeArchedCircle(color: Colors.black, size: 40),
          );
        }

      }
    );
  }
}


