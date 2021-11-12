import 'package:acme_fit/utils/screen_config.dart';
import 'package:acme_fit/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget(
      {Key? key, required this.gridHeight, required this.gridWidth})
      : super(key: key);
  final double gridHeight, gridWidth;

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  String? errorMessage;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  double height = 140;
  int age = 18;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: widget.gridHeight * 8,
      ),
      SizedBox(
        height: widget.gridHeight * 28,
        width: widget.gridWidth * 60,
        child: Image.asset(
          "assets/app_logo.png",
          fit: BoxFit.contain,
        ),
      ),
      SizedBox(
        height: widget.gridHeight * 12,
      ),
      CustomTextFormField(
        hintText: "Full name",
        validations: (String? value) {
          if (value == null) {
            return 'Please provide your name';
          }
          return null;
        },
        controller: nameController,
        isObscured: false,
        gridHeight: widget.gridHeight,
        gridWidth: widget.gridWidth,
      ),
      CustomTextFormField(
        hintText: "Email",
        validations: (String? value) {
          if (value == null) {
            return 'Please provide a valid Email.';
          }
          return errorMessage;
        },
        controller: emailController,
        isObscured: false,
        gridHeight: widget.gridHeight,
        gridWidth: widget.gridWidth,
      ),
      CustomTextFormField(
        hintText: "Email",
        validations: (String? value) {
          if (value == null) {
            return 'Please provide a valid Email.';
          }
          return errorMessage;
        },
        controller: emailController,
        isObscured: false,
        gridHeight: widget.gridHeight,
        gridWidth: widget.gridWidth,
      ),
      SizedBox(
        height: widget.gridHeight * 5,
      ),
      InkWell(
        onTap: () {
          signUp();
        },
        child: Container(
          height: widget.gridHeight * 11,
          width: widget.gridHeight * 11,
          decoration: BoxDecoration(
            color: Colors.blueGrey[900],
            shape: BoxShape.circle,
            border:
                Border.all(color: Colors.white, width: widget.gridHeight * .1),
          ),
          child: Center(
            child: Text(
              "Log In",
              style: ScreenConfig.whiteH6,
            ),
          ),
        ),
      ),
    ]);
  }

  signUp() {}
}
