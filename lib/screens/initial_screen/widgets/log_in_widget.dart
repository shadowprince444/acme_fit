import 'package:acme_fit/repository/log_in_repository.dart';
import 'package:acme_fit/utils/screen_config.dart';
import 'package:acme_fit/widgets/custom_text_form_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';

class LogInWidget extends StatefulWidget {
  const LogInWidget({Key? key}) : super(key: key);

  @override
  _LogInWidgetState createState() => _LogInWidgetState();
}

class _LogInWidgetState extends State<LogInWidget> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? errorMessage;

  double? gridHeight, gridWidth;

  @override
  Widget build(BuildContext context) {
    ScreenConfig.read(context);
    gridHeight = ScreenConfig.gridHeight;
    gridWidth = ScreenConfig.gridWidth;

    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Form(
        key: formKey,
        child: Column(children: [
          SizedBox(
            height: gridHeight! * 12,
          ),
          CustomTextFormField(
            hintText: "Email",
            validations: (String? value) {
              if (value == null || !EmailValidator.validate(value)) {
                return 'Please provide a valid Email.';
              } else {
                return errorMessage;
              }
            },
            controller: _emailController,
            isObscured: false,
            gridHeight: gridHeight!,
            gridWidth: gridWidth!,
          ),
          CustomTextFormField(
            hintText: "Password",
            validations: (String? value) {
              if (value == null || value == "") {
                return 'Please provide a password.';
              }
              return null;
            },
            controller: _passwordController,
            isObscured: true,
            gridHeight: gridHeight!,
            gridWidth: gridWidth!,
          ),
          SizedBox(
            height: gridHeight! * 5,
          ),
          InkWell(
            onTap: () {
              logIn(context);
            },
            child: Container(
              height: gridHeight! * 11,
              width: gridHeight! * 11,
              decoration: BoxDecoration(
                color: Colors.blueGrey[900],
                shape: BoxShape.circle,
                border:
                    Border.all(color: Colors.white, width: gridHeight! * .1),
              ),
              child: Center(
                child: Text(
                  "Log In",
                  style: ScreenConfig.whiteH6,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  logIn(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    String? errorMessageString = await LogInRepository.logIn(
        _emailController.text, _passwordController.text);
    if (errorMessageString == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LogInPage()));
    } else {
      setState(() {
        errorMessage = errorMessageString;
      });
    }
  }
}
