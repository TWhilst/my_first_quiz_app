import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/users/views/home_page/components/home_utils.dart';
import 'package:my_first_quiz_app/users/views/home_page/user_home_page.dart';
import 'package:provider/provider.dart';
import '../../../view_model/home_view_model.dart';

class MenuBarItems extends StatelessWidget {
  const MenuBarItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeViewModel getHomeState = context.watch<HomeViewModel>();
    return Stack(
      children: [
        buildHomePage(getHomeState, context),
        Positioned(
          top: 22,
          left: 10,
          child: Material(
            child: Container(
              height: 480,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 7,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                        itemCount: 8,
                        itemBuilder: (context, index) => HomeUtils.iconWithDesc(
                            icon: HomeUtils.sideBar[index]["icons"],
                            text: HomeUtils.sideBar[index]["desc"],
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(HomeUtils.sideBar[index]["route"]);
                            }),
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Expanded(
                    flex: 1,
                    child: HomeUtils.iconWithDesc(
                      icon: HomeUtils.sideBar[8]["icons"],
                      text: HomeUtils.sideBar[8]["desc"],
                      onTap: () {
                        getHomeState.setTapped = false;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
