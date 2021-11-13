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
        // Stack(
        //   children: [
        //     SizedBox(
        //       height: gridHeight * 18,
        //       width: gridWidth * 30,
        //       child: Center(
        //         child: CircularPercentIndicator(
        //           progressColor: primaryColor,
        //           backgroundColor: Colors.transparent,
        //           radius: gridHeight * 10,
        //           center: Text(
        //             "${percentage!.round()}%",
        //             style: ScreenConfig.mulishH4,
        //           ),
        //           percent: percentage! / 100,
        //         ),
        //       ),
        //     ),
        //     percentage! > 50.0
        //         ? Positioned(
        //             right: 0,
        //             child: Transform.rotate(
        //                 angle: .7,
        //                 child: Icon(
        //                   Icons.arrow_upward_rounded,
        //                   size: gridHeight * 4,
        //                   color: primaryColor.withOpacity(.5),
        //                 )),
        //           )
        //         : Positioned(
        //             right: 0,
        //             child: Transform.rotate(
        //                 angle: 2.5,
        //                 child: Icon(
        //                   Icons.arrow_upward_rounded,
        //                   size: gridHeight * 4,
        //                   color: primaryColor.withOpacity(.5),
        //                 )),
        //           )
        //   ],
        // )
      ],
    );
  }
}
