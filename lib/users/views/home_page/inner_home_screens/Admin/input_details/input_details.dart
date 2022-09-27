import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/global_widgets/status_bar_color_changer.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';
import 'package:my_first_quiz_app/users/view_model/user_details_view_model.dart';
import 'package:my_first_quiz_app/users/views/home_page/admin_home_page.dart';
import 'package:provider/provider.dart';
import 'body/categories.dart';
import 'body/questions.dart';

class InputDetails extends StatefulWidget {
  static const routeName = "/InputDetails";
  const InputDetails({Key? key}) : super(key: key);

  @override
  State<InputDetails> createState() => _InputDetailsState();
}

class _InputDetailsState extends State<InputDetails> {

  List<Widget> body = [
    const Questions(),
    const Categories(),
  ];

  List<String> title = [
    "Questions",
    "Categories",
  ];

  int position = 0;

  onTap(int index) {
    position = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userDetails = context.watch<UserDetailsViewModel>();
    return GestureDetector(
      onTap: () {
        // this is used to leave the textField when you touch any part of the screen
        FocusScope.of(context).unfocus();
      },
      child: StatusBarColorChanger(
        isDark: true,
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  Timer(const Duration(seconds: 2), () {
                    Navigator.popAndPushNamed(context, AdminHomePage.routeName);
                  });
                },
                child: const Icon(Icons.arrow_back_outlined),
              ),
              centerTitle: true,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const EText(text: "Qu", size: 30,),

                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EText(text: "Update ", isTitle: true, size: 15,color: Colors.white,),
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: EText(text: title[position], isTitle: true, size: 22, color: Colors.white,),
                      ),
                    ],
                  ),
                  const EText(text: "iz", size: 30,),

                ],
              ),
              backgroundColor: MyColor.darkBlue,
              bottom: TabBar(
                onTap: onTap,
                indicatorColor: Colors.black45,
                // indicatorPadding: EdgeInsets.symmetric(horizontal: 50),
                // indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black12,
                tabs: const [
                  Tab(text: "Questions",),
                  Tab(text: "Categories",),
                ],
              ),
            ),
            body: body[position],
          ),
        ),
      ),
    );
  }
}
