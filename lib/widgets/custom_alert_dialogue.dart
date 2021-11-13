// ignore_for_file: must_be_immutable

import 'package:acme_fit/utils/screen_config.dart';
import 'package:flutter/material.dart';

class CustomAlertDialogueBox extends StatelessWidget {
  final Function() navigation1, navigation2;
  final String title, content, b1, b2;
  final Widget icon;
  CustomAlertDialogueBox(
      {Key? key,
      required this.b1,
      required this.b2,
      required this.content,
      required this.navigation1,
      required this.navigation2,
      required this.title,
      required this.icon})
      : super(key: key);
  double? gridHeight, gridWidth;
  @override
  Widget build(BuildContext context) {
    ScreenConfig.read(context);
    gridHeight = ScreenConfig.gridHeight!;
    gridWidth = ScreenConfig.gridWidth!;
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 10,
      insetPadding: EdgeInsets.symmetric(
          vertical: gridHeight!, horizontal: gridWidth! * 10),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: gridHeight! * 3,
          horizontal: gridWidth!,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(gridHeight! * 4),
          // color: Colors.grey,
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              spreadRadius: gridHeight! * 2,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: ScreenConfig.mulishH3,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            SizedBox(
              height: gridHeight! * 3,
            ),
            Text(
              content,
              textAlign: TextAlign.center,
              style: ScreenConfig.mulishH4,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
            ),
            SizedBox(
              height: gridHeight! * 3,
            ),
            // _widget != null
            //     ? _widget
            //     :
            icon,

            // SizedBox(
            //   height: gridHeight! * 5,
            // ),
            // ElevatedButton(
            //     onPressed: () {
            //       navigation1;
            //     },
            //     child: Text(
            //       b1,
            //       style: ScreenConfig.blackH6,
            //     )),
            // ElevatedButton(
            //     onPressed: () {
            //       navigation2;
            //     },
            //     child: Text(
            //       b2,
            //       style: ScreenConfig.blackH6,
            //     )),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              InkWell(
                onTap: () {
                  navigation1();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[150],
                    borderRadius: BorderRadius.circular(gridHeight! * 2),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: gridHeight! * 2.5, horizontal: gridWidth! * 6),
                  child: Text(
                    b1,
                    style: ScreenConfig.blackH6Bold,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  navigation2();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(gridHeight! * 2),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: gridHeight! * 1.5, horizontal: gridWidth! * 6),
                  child: Text(
                    b2,
                    style: ScreenConfig.blackH6Bold,
                  ),
                ),
              ),
            ]),
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }
}
