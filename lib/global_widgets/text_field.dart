import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';

class Field extends StatelessWidget {
  final String label, hintText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final bool? obscureText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Function()? onTap;
  final TextCapitalization keyboardCaps;
  final Widget? suffixIcon;
  const Field({Key? key,
    required this.label, this.obscureText,
    required this.hintText, required this.controller,
    this.keyboardType = TextInputType.text, this.validator,
    this.onChanged, this.onSaved,
    this.onTap, this.keyboardCaps = TextCapitalization.none,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) { 
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EText(text: label, selectSize: true, size: 15, weight: FontWeight.w400,),
        const SizedBox(height: 5,),
        TextFormField(
          validator: validator,
          obscureText: obscureText ?? false,
          cursorColor: MyColor.blue,
          cursorRadius: const Radius.circular(5),
          controller: controller,
          keyboardType: keyboardType,
          // this allows the keyboard to start in caps
          textCapitalization: keyboardCaps,
          onChanged: onChanged,
          onSaved: onSaved,
          onTap:  onTap,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10,),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: MyColor.blue
              ),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: MyColor.blue
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: MyColor.blue
              ),
            ),
            filled: true,
            fillColor: MyColor.skyBlue,
          ),
        ),
        const SizedBox(height: 10,),
      ],
    );
  }
}
