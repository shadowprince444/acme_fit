import 'package:acme_fit/utils/screen_config.dart';
import 'package:flutter/material.dart';

class AddingWidget extends StatelessWidget {
  final double gridHeight, gridWidth;
  final String title;
  final Color primaryColor;
  final IconData icon;
  final Widget textField;
  const AddingWidget(
      {Key? key,
      required this.gridHeight,
      required this.gridWidth,
      required this.icon,
      required this.textField,
      required this.primaryColor,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: gridWidth * 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: ScreenConfig.mulishH3,
                ),
                SizedBox(
                  height: gridHeight,
                ),
                Text(
                  "Add your ${title.toLowerCase()}",
                  style: ScreenConfig.mulishH5,
                ),
                SizedBox(
                  height: gridHeight,
                ),
                Expanded(child: textField),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(gridHeight * 2),
          child: Icon(
            icon,
            color: primaryColor,
            size: gridHeight * 6,
          ),
        ),
      ],
    );
  }
}
