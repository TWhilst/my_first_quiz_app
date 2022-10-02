import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';
import 'package:my_first_quiz_app/users/view_model/user_details_view_model.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import 'circles_with_lives.dart';

class LivesTimer extends StatefulWidget {
  const LivesTimer({Key? key}) : super(key: key);

  @override
  State<LivesTimer> createState() => _LivesTimerState();
}

class _LivesTimerState extends State<LivesTimer> {
  Duration duration = const Duration(seconds: 1800);
  Timer? timer;


  @override
  void initState() {
    super.initState();
    // startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }



  void addTime() {
    const removeSeconds = -1;

    setState(() {
      final seconds = duration.inSeconds + removeSeconds;
      duration = Duration(seconds: seconds);
    });

  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final minutes = twoDigits(duration.inMinutes);
    return EText(text: "$minutes:$seconds", isTitle: true, size: 24,);
  }
}
