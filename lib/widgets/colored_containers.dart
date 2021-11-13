import 'package:flutter/material.dart';

class ColoredContainer extends StatelessWidget {
  const ColoredContainer(
      {Key? key,
      required this.f1,
      required this.gridWidth,
      required this.gridHeight,
      required this.backgroundColor,
      required this.child})
      : super(key: key);

  final Color backgroundColor;
  final Widget child;

  final double gridWidth, gridHeight;
  final Function()? f1;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: f1!,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: gridWidth * 5, vertical: gridHeight * 2.5),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(gridHeight * 4))),
        height: gridHeight * 18,
        width: gridWidth * 90,
        child: child,
      ),
    );
  }
}
