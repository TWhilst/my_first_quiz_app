import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';

import '../inner_home_screens/about_the_game_screen.dart';
import '../inner_home_screens/interesting_facts_screen.dart';
import '../inner_home_screens/premium_screen.dart';
import '../inner_home_screens/settings_screen.dart';
import '../inner_home_screens/statistic_screen.dart';

class HomeUtils {
  static final List<Map<String, dynamic>> sideBar = [
    {
      "icons": Icons.file_open_sharp,
      "desc": "Interesting Facts",
      "route": InterestingFactsScreen.routeName
    },
    {
      "icons": Icons.settings_outlined,
      "desc": "Settings",
      "route": SettingsScreen.routeName
    },
    {
      "icons": Icons.show_chart_outlined,
      "desc": "Statistics",
      "route": StatisticScreen.routeName
    },
    {
      "icons": Icons.info_outline,
      "desc": "About us",
      "route": AboutTheGameScreen.routeName
    },
    {
      "icons": Icons.star_border_outlined,
      "desc": "Rate us",
      "route": InterestingFactsScreen.routeName
    },
    {
      "icons": Icons.badge_sharp,
      "desc": "Achievements",
      "route": InterestingFactsScreen.routeName
    },
    {
      "icons": Icons.bar_chart_outlined,
      "desc": "Leaderboard",
      "route": InterestingFactsScreen.routeName
    },
    {
      "icons": Icons.diamond,
      "desc": "Premium",
      "route": PremiumScreen.routeName
    },
    {"icons": Icons.clear, "desc": "Close Menu"},
  ];

  static Widget iconWithDesc({
    required IconData icon,
    required String text,
    required Function() onTap
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 250,
        color: Colors.white,
        child: Row(
          children: [
            const SizedBox(width: 10,),
            Icon(icon, size: 30,),
            const SizedBox(width: 10,),
            EText(text: text, isTitle: true,),
          ],
        ),
      ),
    );
  }
}