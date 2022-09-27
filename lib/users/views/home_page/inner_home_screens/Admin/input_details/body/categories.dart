import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_first_quiz_app/constants/constants.dart';
import 'package:my_first_quiz_app/global_widgets/text_field.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';
import 'package:my_first_quiz_app/users/view_model/user_details_view_model.dart';
import 'package:my_first_quiz_app/utils/utils.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  final TextEditingController _categoryController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _categoryController.dispose();
  }
  Uint8List? _image;

  void selectImage() async  {
    Uint8List im = await Utils.pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userDetails = context.watch<UserDetailsViewModel>();
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            children: [
              _image != null ? InkWell(
                onTap: () => selectImage(),
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: MyColor.darkBlue),
                  ),
                  child: Image(
                    image: MemoryImage(_image!),
                    fit: BoxFit.fill,
                  ),
                ),
              ) :
              InkWell(
                onTap: () => selectImage(),
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    border: Border.all(color: MyColor.darkBlue),
                  ),
                  child: const Icon(Icons.upload, color: MyColor.darkBlue,),
                ),
              ),
              const SizedBox(height: 30,),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Field(
                      label: "Category", hintText: "Category",
                      controller: _categoryController,
                      validator: RequiredValidator(errorText: "The category is required"),
                      keyboardType: TextInputType.text,
                      keyboardCaps: TextCapitalization.sentences,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: MaterialButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if(_formKey.currentState!.validate()){
                      // debugPrint("it works");
                      _formKey.currentState!.save();
                      userDetails.uploadCategories(
                          category: _categoryController.text, file: _image, context: context
                      );
                      _categoryController.clear();
                      _image = null;
                    }
                  },
                  color: MyColor.darkBlue,
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
                  EText(text: "Upload".toUpperCase(), color: Colors.white, size: 14, isTitle: true,),
                ),
              ),
              const SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
