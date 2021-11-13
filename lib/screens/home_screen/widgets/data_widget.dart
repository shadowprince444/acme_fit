import 'package:acme_fit/utils/screen_config.dart';
import 'package:flutter/material.dart';

class DataWidget extends StatelessWidget {
  final double gridHeight, gridWidth;
  final String title, subtitle;
  final Widget icon;
  final String? lastReading;
  const DataWidget(
      {Key? key,
      required this.gridHeight,
      required this.gridWidth,
      required this.icon,
      this.lastReading,
      required this.subtitle,
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
                Text(
                  subtitle,
                  style: ScreenConfig.mulishH5,
                ),
                Text(
                  lastReading ?? "-/-",
                  style: ScreenConfig.mulishH2,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: gridWidth * 30,
          child: icon,
        ),
      ],
    );
  }
}
