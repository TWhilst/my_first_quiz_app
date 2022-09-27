import 'dart:async';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/constants/global.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';
import 'package:my_first_quiz_app/model/question_model.dart';
import 'package:my_first_quiz_app/users/views/home_page/inner_home_screens/categories_screen/inner_screen/completed_quiz.dart';
import 'package:my_first_quiz_app/users/views/home_page/inner_home_screens/common_widgets/BlueButton.dart';
import 'components/options_tile.dart';
import 'components/quiz_options.dart';

class QuizScreen2 extends StatefulWidget {
  static const routeName = "/QuizScreen2";
  const QuizScreen2({Key? key, }) : super(key: key);

  @override
  State<QuizScreen2> createState() => _QuizScreen2State();
}

class _QuizScreen2State extends State<QuizScreen2> {
  QuestionModel? q;
  bool _firstPressed = true;
  bool _Pressed = true;
  bool _isFinished = false;
  double elevation = 5;
  double raised = 5;

  List<String> title = [
    "Canada",
    "Poland",
    "Ukraine",
    "France",
  ];

  String timer = "00 : 59";
  int time = 59;
  bool stopped = false;
  void startTimer() async {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer t) {
      if(mounted){
        setState(() {
          if(time < 1) {
            t.cancel();
            correctAnswer(q!.option, q!.answer);
            _isSelected = true;
          } else {
            time = time - 1;
          }
          if(_isSelected == true) {
            t.cancel();
          }
          // if(_isFinished = true) {
          //   t.cancel();
          // }
          if(time < 10) {
            timer = "00 : 0$time";
          }else if(time >= 60){
            if((time-60) < 10) {
              timer = "01 : 0${time-60}";
            } else {
              timer = "01 : ${time-60}";
            }
          } else{
            timer = "00 : $time";
          }

        });
      }

    });
  }

  void moreTime() {
    setState(() {
      time = time + 30;
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  int value = 0;

  bool _isSelected = false;
  Color color = Colors.white;
  Color correctColor = Colors.green;
  Color wrongColor = Colors.red;
  Color? neutralColor = Colors.grey[300];

  Map<int,Color?> btnColor = {
    0: Colors.white,
    1: Colors.white,
    2: Colors.white,
    3: Colors.white,
  };

  void checkAnswer(int index, String answer, List option) {
    btnColor = {
      0: Colors.grey[300],
      1: Colors.grey[300],
      2: Colors.grey[300],
      3: Colors.grey[300],
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
    correctAnswer(option, answer);
  }

  void theAnswer(List option, String answer) {
    btnColor = {
      0: Colors.grey[300],
      1: Colors.grey[300],
      2: Colors.grey[300],
      3: Colors.grey[300],
    };
    correctAnswer(option, answer);
    _isSelected = true;
    setState(() {});
  }

  void correctAnswer(List option, String answer) {
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

  void nextQuestion(List<DocumentSnapshot> snap, BuildContext c) {
    time = 60;
    _Pressed = true;
    _firstPressed = true;
    elevation = 5;
    raised = 5;
    _isSelected = false;
    startTimer();
    btnColor = {
      0: Colors.white,
      1: Colors.white,
      2: Colors.white,
      3: Colors.white,
    };
    if(value>snap.length-1) {
      _isFinished = true;
      value = snap.length;
    } else {
      value++;
    }
    setState(() {});
  }

  navigateTo(BuildContext c) {
    Navigator.pushReplacement(c, MaterialPageRoute(builder: (c) => const CompletedQuiz()));
  }

  void halfHalf(String answer, List option) {
    int a = 0;
    int b = 0;
    a = Random().nextInt(4);
    b = Random().nextInt(4);
    int position = 0;
    for(String s in option){
      if(s==answer){
        position = option.indexOf(s);
        btnColor.forEach((key, value) {
          if(position==key){
            btnColor[position]=Colors.white;
          }else{
            btnColor[key]=neutralColor;
          }

          if(a!=position){
            btnColor[a]=Colors.white;
          }else{
            if(position<btnColor.length-1){
              btnColor[position-1]=Colors.white;
            }else{
              btnColor[position+1]=Colors.white;
            }
          }


        });
      }
    }
    // if(option[0] != answer && option[1] != answer && option[2] != answer ) {
    //   btnColor = {
    //     0: Colors.grey[300],
    //     1: Colors.grey[300],
    //     2: Colors.grey[300],
    //     3: Colors.white,
    //   };
    //   if(a != 3 && b == 3) {
    //     btnColor[a] = color;
    //   } else if(a == 3 && b != 3){
    //     btnColor[b] = color;
    //   } else {
    //     btnColor[1] = color;
    //   }
    // } else if(option[2] != answer && option[0] != answer && option[3] != answer) {
    //   btnColor = {
    //     0: Colors.grey[300],
    //     1: Colors.white,
    //     2: Colors.grey[300],
    //     3: Colors.grey[300],
    //   };
    //   if(a != 1 && b == 1) {
    //     btnColor[a] = color;
    //   } else if(a == 1 && b != 1){
    //     btnColor[b] = color;
    //   } else {
    //     btnColor[2] = color;
    //   }
    // } else if(option[1] != answer && option[2] != answer && option[3] != answer) {
    //   btnColor = {
    //     0: Colors.white,
    //     1: Colors.grey[300],
    //     2: Colors.grey[300],
    //     3: Colors.grey[300],
    //   };
    //   if(a != 0 && b == 0) {
    //     btnColor[a] = color;
    //   } else if(a == 0 && b != 0){
    //     btnColor[b] = color;
    //   } else {
    //     btnColor[3] = color;
    //   }
    // } else if(option[0] != answer && option[1] != answer && option[3] != answer ) {
    //   btnColor = {
    //     0: Colors.grey[300],
    //     1: Colors.grey[300],
    //     2: Colors.white,
    //     3: Colors.grey[300],
    //   };
    //   if(a != 2 && b == 2) {
    //     print(a);
    //     btnColor[a] = color;
    //   } else if(a == 2 && b != 2){
    //     btnColor[b] = color;
    //   } else {
    //     btnColor[0] = color;
    //   }
    //
    // }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot?>(
      stream: FirebaseFirestore.instance.collection("Questions").snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          List<DocumentSnapshot> snap = snapshot.data!.docs;

          if(value>snap.length-1){
            return const CompletedQuiz();
          }else{
            QuestionModel question = QuestionModel.fromJson(snap[value]);
            q = question;
            return Scaffold(
              // floatingActionButton: FloatingActionButton(
              //   onPressed: () {
              //     // halfHalf(question.answer, question.option);
              //     print(value);
              //     print(value);
              //   },
              // ),
              body:  CustomScrollView(
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
                              timer,
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
                            imageUrl: question.image,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: EText(text: question.question, textAlign: TextAlign.center,),
                        ),
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
                                  return OptionsTile(
                                    title: question.option[index],
                                    color: btnColor[index]!,
                                    onTap: () {
                                      if(_isSelected == false) {
                                        _isSelected = true;
                                        checkAnswer(index, question.answer, question.option);
                                      }
                                    }
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
                        _isSelected?
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
                                        child: EText(selectSize: false, height: 1.2, weight: FontWeight.w500, size: 14, text: question.interestingFact, textAlign: TextAlign.center,),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15,),
                              BlueButton(
                                text: "Next question",
                                size: 14, height: 45, padding: 5,
                                onPressed: () => nextQuestion(snap, context),
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
                              const SizedBox(height: 280,),
                            ],
                          ),
                        ) :
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  QuizOptions(
                                    elevation: elevation,
                                    text: "50 : 50",
                                    onPressed: () {
                                      if(_firstPressed) {
                                        _firstPressed = false;
                                        elevation = 0;
                                        halfHalf(question.answer, question.option);
                                      }
                                    },
                                  ),
                                  const Spacer(),
                                  QuizOptions(
                                    text: "+30 sec",
                                    elevation: raised,
                                    onPressed: () {
                                      if(_Pressed) {
                                        _Pressed = false;
                                        raised = 0;
                                        moreTime();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: QuizOptions(
                                text: "Show answer", minus: "-4",
                                width: double.maxFinite, stackLeft: 332,
                                onPressed: () => theAnswer(question.option, question.answer),
                              ),
                            ),
                            const SizedBox(height: 280,),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

        } else {
          return Center(
            child: LoadingAnimationWidget.threeArchedCircle(color: Colors.black, size: 40),
          );
        }
        // if(snapshot.hasData) {
        //   List<DocumentSnapshot> snap = snapshot.data!.docs;
        //   QuestionModel question = QuestionModel.fromJson(snap[value]);
        //   q = question;
        //   return Scaffold(
        //     floatingActionButton: FloatingActionButton(
        //       onPressed: () {
        //         halfHalf(question.answer, question.option);
        //         print(btnColor);
        //       },
        //     ),
        //     body: CustomScrollView(
        //       slivers: [
        //         SliverAppBar(
        //           automaticallyImplyLeading: false,
        //           elevation: 2,
        //           backgroundColor: MyColor.skyBlue,
        //           toolbarHeight: 70,
        //           pinned: true,
        //           title: Padding(
        //             padding: const EdgeInsets.only( top: 30, bottom: 20, left: 0, right: 0),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 /// BACK ICON
        //                 InkWell(
        //                   borderRadius: BorderRadius.circular(17.5),
        //                   onTap: () {
        //                     // getHomeState.setTapped = false;
        //                     Navigator.pop(context);
        //                   },
        //                   child: Container(
        //                     padding: const EdgeInsets.all(1),
        //                     height: 32,
        //                     width: 32,
        //                     decoration: BoxDecoration(
        //                         color: MyColor.skyBlue,
        //                         border: Border.all(color: Colors.black, width: 3),
        //                         shape: BoxShape.circle
        //                     ),
        //                     child: const Icon(
        //                       Icons.arrow_back_sharp,
        //                       size: 23,
        //                       color: Colors.black,
        //                       shadows: [
        //                         Shadow(
        //                           offset: Offset(1, 0),
        //                         ),
        //                         Shadow(
        //                           offset: Offset(0, 0.5),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ),
        //
        //                 /// TIMER
        //                 Container(
        //                   padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
        //                   alignment: Alignment.center,
        //                   decoration: BoxDecoration(
        //                     color: MyColor.skyBlue,
        //                     border: Border.all(width: 1, color: Colors.black),
        //                     borderRadius: BorderRadius.circular(12),
        //                   ),
        //                   child: Text(
        //                     timer,
        //                     style: const TextStyle(
        //                         fontSize: 20,
        //                         fontWeight: FontWeight.w600,
        //                         color: Colors.black
        //                     ),
        //                   ),
        //                 ),
        //
        //                 /// Lives button
        //                 InkWell(
        //                   onTap: () {
        //                     // getHomeState.setTapped = false;
        //                     Global.showLivesBox(context);
        //                   },
        //                   child: const Icon(
        //                     Icons.favorite,
        //                     color: MyColor.heart,
        //                     size: 40,
        //                   ),
        //                 ),
        //
        //               ],
        //             ),
        //           ),
        //         ),
        //         SliverAppBar(
        //           automaticallyImplyLeading: false,
        //           floating: false,
        //           backgroundColor: MyColor.skyBlue,
        //           expandedHeight: 230,
        //           flexibleSpace: Material(
        //             elevation: 2,
        //             child: FlexibleSpaceBar(
        //               background: Container(
        //                 // height: 300,
        //                 decoration: BoxDecoration(
        //                   color: Colors.white,
        //                   border: Border.all(color: Colors.white, width: 10),
        //                 ),
        //                 child: CachedNetworkImage(
        //                   imageUrl: question.image,
        //                   width: double.maxFinite,
        //                   fit: BoxFit.cover,
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //
        //         SliverToBoxAdapter(
        //           child: Column(
        //             children: [
        //               const SizedBox(height: 15,),
        //               Padding(
        //                 padding: const EdgeInsets.symmetric(horizontal: 20),
        //                 child: EText(text: question.question, textAlign: TextAlign.center,),
        //               ),
        //               const SizedBox(height: 20,),
        //               SizedBox(
        //                 height: 210,
        //                 // color: Colors.black,
        //                 // padding: EdgeInsets.symmetric(vertical: 10),
        //                 child: MediaQuery.removePadding(
        //                   context: context,
        //                   removeTop: true,
        //                   removeBottom: true,
        //                   child: ListView.builder(
        //                       shrinkWrap: true,
        //                       physics: const NeverScrollableScrollPhysics(),
        //                       itemCount: 4,
        //                       // padding: EdgeInsets.only(bottom: 5),
        //                       itemBuilder: (context, index) {
        //                         return OptionsTile(
        //                           title: question.option[index],
        //                           color: btnColor[index]!,
        //                           onTap: () => checkAnswer(index, question.answer, question.option),
        //                         );
        //                       }
        //                   ),
        //                 ),
        //               ),
        //               const SizedBox(height: 5,),
        //               Padding(
        //                 padding: const EdgeInsets.symmetric(horizontal: 20),
        //                 child: Row(
        //                   children: [
        //                     const EText(text: "Coins in the chest:", isTitle: true, size: 14,),
        //                     const Spacer(),
        //                     Row(
        //                       children: [
        //                         const EText(text: "34/99", isTitle: true, size: 14,),
        //                         const SizedBox(width: 5,),
        //                         InkWell(
        //                           borderRadius: BorderRadius.circular(20),
        //                           onTap: () {
        //                             // getHomeState.setTapped = false;
        //                             Global.showAdBox(context);
        //                           },
        //                           child: Container(
        //                             height: 35,
        //                             width: 35,
        //                             alignment: Alignment.center,
        //                             decoration: BoxDecoration(
        //                               color: MyColor.gold,
        //                               borderRadius: BorderRadius.circular(20),
        //                             ),
        //                             child: const Center(child: Text(""),),
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //               const SizedBox(height: 15,),
        //               _isSelected?
        //               Padding(
        //                 padding: const EdgeInsets.symmetric(horizontal: 10),
        //                 child: Column(
        //                   children: [
        //                     Material(
        //                       color: Colors.white,
        //                       borderRadius: BorderRadius.circular(6),
        //                       child: Padding(
        //                         padding: const EdgeInsets.symmetric(vertical: 15),
        //                         child: Wrap(
        //                           alignment: WrapAlignment.center,
        //                           children: [
        //                             const EText(text: "Interesting facts", isTitle: true, size: 14,),
        //                             Padding(
        //                               padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
        //                               child: EText(selectSize: false, height: 1.2, weight: FontWeight.w500, size: 14, text: question.interestingFact, textAlign: TextAlign.center,),
        //                             ),
        //                           ],
        //                         ),
        //                       ),
        //                     ),
        //                     const SizedBox(height: 15,),
        //                     BlueButton(
        //                       text: "Next question",
        //                       size: 14, height: 45, padding: 5,
        //                       onPressed: () => nextQuestion(snap, context),
        //                     ),
        //                     const SizedBox(height: 7,),
        //                     Row(
        //                       children: [
        //                         const SizedBox(width: 5,),
        //                         Padding(
        //                           padding: const EdgeInsets.only(right: 5, left: 0, bottom: 7),
        //                           child: MaterialButton(
        //                             onPressed: () {},
        //                             color:MyColor.lightBlue,
        //                             // splashColor: const Color(0xFF0080a3),
        //                             highlightColor: const Color(0xFF79bbc7),
        //                             minWidth: 230,
        //                             height: 45,
        //                             elevation: 5,
        //                             shape: RoundedRectangleBorder(
        //                               side: const BorderSide(width: 5, color: Colors.white,),
        //                               borderRadius: BorderRadius.circular(15),
        //                             ),
        //                             child: EText(text: "Wikipedia".toUpperCase(), size: 14, selectSize: true, weight: FontWeight.w900, color: Colors.white,),
        //                           ),
        //                         ),
        //                         const Spacer(),
        //                         const Icon(Icons.star_border_outlined, color: Colors.white, size: 50,),
        //                         const Spacer(),
        //                         const Icon(Icons.email_outlined, color: Colors.white, size: 50,),
        //                         const SizedBox(width: 5,),
        //                       ],
        //                     ),
        //                     const SizedBox(height: 280,),
        //                   ],
        //                 ),
        //               ) :
        //               Column(
        //                 children: [
        //                   Padding(
        //                     padding: const EdgeInsets.symmetric(horizontal: 10),
        //                     child: Row(
        //                       children: [
        //                         QuizOptions(
        //                           elevation: elevation,
        //                           text: "50 : 50",
        //                           onPressed: () {
        //                             if(_firstPressed) {
        //                               _firstPressed = false;
        //                               elevation = 0;
        //                               halfHalf(question.answer, question.option);
        //                             }
        //                           },
        //                         ),
        //                         const Spacer(),
        //                         QuizOptions(
        //                           text: "+30 sec",
        //                           elevation: raised,
        //                           onPressed: () {
        //                             if(_Pressed) {
        //                               _Pressed = false;
        //                               raised = 0;
        //                               moreTime();
        //                             }
        //                           },
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                   Padding(
        //                     padding: const EdgeInsets.symmetric(horizontal: 10),
        //                     child: QuizOptions(
        //                       text: "Show answer", minus: "-4",
        //                       width: double.maxFinite, stackLeft: 332,
        //                       onPressed: () => theAnswer(question.option, question.answer),
        //                     ),
        //                   ),
        //                   SizedBox(height: 280,),
        //                 ],
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   );
        // } else {
        //   return Center(
        //     child: LoadingAnimationWidget.threeArchedCircle(color: Colors.black, size: 40),
        //   );
        // }


      }
    );
  }
}
