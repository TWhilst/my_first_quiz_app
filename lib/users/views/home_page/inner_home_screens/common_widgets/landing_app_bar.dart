import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';
import 'package:my_first_quiz_app/users/view_model/home_view_model.dart';

class LandingAppBar extends StatelessWidget {
  LandingAppBar({
    Key? key,
    required this.getHomeState,
    required this.title,
    this.hasIcon = false,
  }) : super(key: key);

  final HomeViewModel getHomeState;
  final String title;
  final bool hasIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
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

          /// TEXT
          EText(text: title, selectSize: true, size: 19, weight: FontWeight.w600,),
          
          hasIcon? const Icon(Icons.star_border_outlined, color: Colors.white, size: 50,)  : Container(),
        ],
      ),
    );
  }
}
