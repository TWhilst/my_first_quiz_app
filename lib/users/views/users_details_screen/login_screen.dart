import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/global_widgets/status_bar_color_changer.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';
import 'package:my_first_quiz_app/global_widgets/text_field.dart';
import 'package:my_first_quiz_app/users/views/users_details_screen/sign_up_screen.dart';
import 'package:provider/provider.dart';

import '../../view_model/user_details_view_model.dart';
import '../home_page/admin_home_page.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/LoginScreen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isObscure = true;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userDetails = context.watch<UserDetailsViewModel>();
    return GestureDetector(
      onTap: () {
        // this is used to leave the textField when you touch any part of the screen
        FocusScope.of(context).unfocus();
      },
      child: StatusBarColorChanger(
        isDark: false,
        child: Scaffold(
          body: SafeArea(
            child: Container(
              // padding: EdgeInsets.only(top: 30),
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    MyColor.skyBlue,
                    MyColor.lightBlue,
                    MyColor.blue,
                    MyColor.darkBlue,
                  ],
                )
              ),
              child: Stack(
                children: [
                  // const SizedBox(height: 80,),
                  Positioned(
                    top: 40,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          EText(text: "Login", isTitle: true, color: Colors.black, size: 40,),
                          EText(text: "Welcome back", isTitle: true, color: Colors.black, size: 20,)
                        ],
                      ),
                    ),
                  ),
                  // const SizedBox(height: 30,),
                  Positioned(
                    bottom: 0,
                    top: 200,
                    child: Container(
                      padding: const EdgeInsets.only(top: 50),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20,),
                          child: Column(
                            children: [
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Field(
                                      label: "Email address", hintText: "Email",
                                      suffixIcon: const Icon(Icons.email_outlined, color: Colors.black,),
                                      controller: _emailController, keyboardType: TextInputType.emailAddress,
                                      validator: MultiValidator(
                                          [
                                            EmailValidator(errorText: "The imputed email is not valid"),
                                            RequiredValidator(errorText: "Email is required"),
                                          ]
                                      ),
                                    ),
                                    Field(
                                      label: "Password", hintText: "Password",
                                      controller: _passwordController, obscureText: _isObscure,
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          _isObscure = !_isObscure;
                                          setState(() {});
                                        },
                                        child: _isObscure?
                                        const Icon(Icons.visibility_off, color: Colors.black,) :
                                        const Icon(Icons.visibility, color: MyColor.blue),
                                      ),
                                      validator: MultiValidator(
                                          [
                                            RequiredValidator(errorText: "Password is required"),
                                            MinLengthValidator(8, errorText: "Password must be as least 8 digits long"),
                                            // PatternValidator("'!~`@#%^&*()_-+={}[]|;:?/.>,<", errorText: "Password must have at least one special character"),
                                          ]
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: const EText(text: "Forgot password?", size: 15, selectSize: true, weight: FontWeight.w400,),
                                ),
                              ),
                              const SizedBox(height: 20,),
                              // const BlueButton(text: "Login", color: MyColor.blue, size: 14, padding: 0, height: 50,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 0),
                                child: MaterialButton(
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    if(_formKey.currentState!.validate()){
                                      // debugPrint("it works");
                                      _formKey.currentState!.save();
                                      userDetails.loginUser(
                                        email: _emailController.text,
                                        password: _passwordController.text, context: context,
                                        onSuccess: () {
                                          Navigator.pushNamedAndRemoveUntil(context, AdminHomePage.routeName, (route) => false);
                                        }
                                      );
                                    }
                                  },
                                  color: MyColor.blue,
                                  // splashColor: const Color(0xFF0080a3),
                                  highlightColor: const Color(0xFF0080a3),
                                  minWidth: double.maxFinite,
                                  height: 50,
                                  elevation: 5,
                                  padding: const EdgeInsets.only(bottom: 6),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(width: 5, color: Colors.white,),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: userDetails.isSaving?
                                  Center(
                                    child: LoadingAnimationWidget.bouncingBall(color: Colors.white, size: 40),
                                  ) :
                                  EText(text: "Login".toUpperCase(), color: Colors.white, size: 14, isTitle: true,),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const EText(text: "Don't have an account?", size: 15, selectSize: true, weight: FontWeight.w400,),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, SignUpScreen.routeName);
                                    },
                                    style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                    ),
                                    child: const EText(text: "Sign Up", color: MyColor.blue,),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),

            ),
          ),
        ),
      ),
    );
  }
}
