import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/services/firebase_auth.dart';
import 'package:my_first_quiz_app/users/view_model/home_view_model.dart';
import 'package:my_first_quiz_app/users/view_model/user_details_view_model.dart';
import 'package:my_first_quiz_app/users/views/home_page/admin_home_page.dart';
import 'package:my_first_quiz_app/users/views/home_page/inner_home_screens/Admin/input_details.dart';
import 'package:my_first_quiz_app/users/views/home_page/inner_home_screens/about_the_game_screen.dart';
import 'package:my_first_quiz_app/users/views/home_page/inner_home_screens/categories_screen/categories_screen.dart';
import 'package:my_first_quiz_app/users/views/home_page/inner_home_screens/categories_screen/inner_screen/quiz_screen.dart';
import 'package:my_first_quiz_app/users/views/home_page/inner_home_screens/history_of_questions_screen.dart';
import 'package:my_first_quiz_app/users/views/home_page/inner_home_screens/interesting_facts_screen.dart';
import 'package:my_first_quiz_app/users/views/home_page/inner_home_screens/premium_screen.dart';
import 'package:my_first_quiz_app/users/views/home_page/inner_home_screens/settings_screen.dart';
import 'package:my_first_quiz_app/users/views/home_page/inner_home_screens/statistic_screen.dart';
import 'package:my_first_quiz_app/users/views/home_page/user_home_page.dart';
import 'package:my_first_quiz_app/users/views/splash_screen.dart';
import 'package:my_first_quiz_app/users/views/users_details_screen/login_screen.dart';
import 'package:my_first_quiz_app/users/views/users_details_screen/sign_up_screen.dart';
import 'package:provider/provider.dart';

Future main() async {
  runApp(const MyApp());
  // setting up firebase for the flutter project
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // this is used to change the color of the status bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: MyColor.skyBlue,
      statusBarIconBrightness: Brightness.dark,
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => UserDetailsViewModel()),
        Provider<AuthMethods>(create: (_) => AuthMethods()),
        StreamProvider(create: (context) => context.read<AuthMethods>().authStateChanges, initialData: null,)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: MyColor.skyBlue,
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
        routes: {
          SignUpScreen.routeName: (context) => const SignUpScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          AdminHomePage.routeName: (context) => const AdminHomePage(),
          UserHomePage.routeName: (context) => const UserHomePage(),
          InterestingFactsScreen.routeName: (context) => const InterestingFactsScreen(),
          SettingsScreen.routeName: (context) => const SettingsScreen(),
          StatisticScreen.routeName: (context) => const StatisticScreen(),
          AboutTheGameScreen.routeName: (context) => const AboutTheGameScreen(),
          PremiumScreen.routeName: (context) => const PremiumScreen(),
          HistoryOfQuestionsScreen.routeName: (context) => const HistoryOfQuestionsScreen(),
          CategoriesScreen.routeName: (context) => const CategoriesScreen(),
          QuizScreen.routeName: (context) => const QuizScreen(),
          InputDetails.routeName: (context) => const InputDetails(),
        },
      ),
    );
  }
}

