import 'package:acme_fit/utils/screen_config.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String? Function(String?) validations;
  final TextEditingController controller;
  final bool isObscured;
  final double gridHeight, gridWidth;
  const CustomTextFormField(
      {Key? key,
      required this.controller,
      required this.isObscured,
      required this.hintText,
      required this.validations,
      required this.gridWidth,
      required this.gridHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: gridHeight * 10,
      padding: EdgeInsets.symmetric(
          vertical: gridHeight, horizontal: gridWidth * 15),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: isObscured,
        validator: validations,
        decoration: InputDecoration(
          errorStyle: ScreenConfig.errortxt!,
          contentPadding: EdgeInsets.only(
            left: gridWidth * 3,
            top: gridHeight * 2,
          ),
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(gridHeight),
              gapPadding: gridWidth * 2,
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 0,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(gridHeight),
              gapPadding: gridWidth * 2,
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 0,
              )),
          filled: true,
          fillColor: Colors.white.withOpacity(.35),
        ),
        controller: controller,
      ),
    );
  }
}
