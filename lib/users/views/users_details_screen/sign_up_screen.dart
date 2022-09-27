import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/global_widgets/status_bar_color_changer.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';
import 'package:my_first_quiz_app/global_widgets/text_field.dart';
import 'package:my_first_quiz_app/users/view_model/user_details_view_model.dart';
import 'package:my_first_quiz_app/users/views/home_page/admin_home_page.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "/SignUpScreen";
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isObscure = true;
  bool _isObscure2 = true;

  final _formKey = GlobalKey<FormState>();

  late String _password;

  @override
  void dispose() {
    super.dispose();
    _confirmPasswordController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                          EText(text: "Sign Up", isTitle: true, color: Colors.black, size: 40,),
                          EText(text: "Add your details to begin your journey", isTitle: true, color: Colors.black, size: 15,),
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
                                      label: "Username", hintText: "User",
                                      controller: _userNameController,
                                      validator: RequiredValidator(errorText: "The username is required"),
                                      keyboardType: TextInputType.text,
                                      keyboardCaps: TextCapitalization.sentences,
                                      suffixIcon: const Icon(Icons.person, color: Colors.black,),
                                    ),
                                    Field(
                                      label: "Email address", hintText: "Email",
                                      controller: _emailController, keyboardType: TextInputType.emailAddress,
                                      suffixIcon: const Icon(Icons.email_outlined, color: Colors.black,),
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
                                          setState(() {
                                            _isObscure = !_isObscure;
                                          });
                                        },
                                        child: _isObscure?
                                        const Icon(Icons.visibility_off, color: Colors.black,) :
                                        const Icon(Icons.visibility, color: MyColor.blue),
                                      ),
                                      onChanged: (password) => _password = password,
                                      onSaved: (pass) => _password,
                                      validator: MultiValidator(
                                        [
                                          RequiredValidator(errorText: "Password is required"),
                                          MinLengthValidator(8, errorText: "Password must be as least 8 digits long"),
                                          // PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: "Password must have at least one special character or value"),
                                        ]
                                      ),
                                    ),
                                    Field(
                                      label: "Password", hintText: "Confirm password",
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _isObscure2 = !_isObscure2;
                                          });
                                        },
                                        child: _isObscure2?
                                        const Icon(Icons.visibility_off, color: Colors.black,) :
                                        const Icon(Icons.visibility, color: MyColor.blue),
                                      ),
                                      controller: _confirmPasswordController, obscureText: _isObscure2,
                                      validator: (pass) => MatchValidator(errorText: "Password does not match").validateMatch(pass!, _password),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10,),
                              // BlueButton(
                              //   text: "Sign Up", color: MyColor.blue,
                              //   size: 14, padding: 0, height: 50,
                              //   onPressed: () async {
                              //   },
                              // ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 0),
                                child: MaterialButton(
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    if(_formKey.currentState!.validate()){
                                      // debugPrint("it works");
                                      _formKey.currentState!.save();
                                      userDetails.saveUserDetails(
                                        email: _emailController.text, username: _userNameController.text,
                                        password: _passwordController.text, confirmPassword: _confirmPasswordController.text,
                                        context: context,
                                        onSuccess: () => Navigator.pushNamedAndRemoveUntil(context, AdminHomePage.routeName, (route) => false),
                                      );
                                    }
                                  },
                                  color: MyColor.blue,
                                  // splashColor: const Color(0xFF0080a3),
                                  highlightColor: const Color(0xFF0080a3),
                                  minWidth: double.maxFinite,
                                  height: 50,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(width: 5, color: Colors.white,),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: userDetails.isSaving?
                                  Center(
                                    child: LoadingAnimationWidget.bouncingBall(color: Colors.white, size: 40),
                                  ) :
                                  EText(text: "Sign up".toUpperCase(), color: Colors.white, size: 14, isTitle: true,),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const EText(text: "Already have an account?"),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ButtonStyle(
                                        overlayColor: MaterialStateProperty.all<Color>(Colors.transparent)
                                    ),
                                    child: const EText(text: "Login", color: MyColor.blue,),
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
