import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/users/views/home_page/inner_home_screens/premium_screen.dart';

class SideIcon extends StatelessWidget {
  const SideIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: InkWell(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(19),
          bottomLeft: Radius.circular(19),
        ),
        onTap: () => Navigator.of(context).pushNamed(PremiumScreen.routeName),
        child: Container(
          width: 72,
          height: 38,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(19),
              bottomLeft: Radius.circular(19),
            ),
          ),
          child: Image.asset("assets/images/crown.png"),
        ),
      ),
    );
  }
}

class WorldImage extends StatelessWidget {
  const WorldImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.6,
      child: Center(
        child: SizedBox(
          height: 450,
          width: 270,
          child: Image.asset(
            "assets/images/world.png",
          ),
        ),
      ),
    );
  }
}

