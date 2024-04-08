

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({
    Key? key,
    this.text,
    required this.ontap,
    required this.height,
    required this.width,
    this.radius,
    this.color,
    this.fontsize,
    this.fontWeight,
    this.top,
    this.left,
    this.right,
    this.bottom,
    this.widget,
  }) : super(key: key);
  final String? text;
  final void Function() ontap;
  final double height;
  final double width;
  final double? radius;
  final Color? color;
  final double? fontsize;
  final FontWeight? fontWeight;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: top ?? 0,
          right: right ?? 0,
          left: left ?? 0,
          bottom: bottom ?? 0),
      child: ElevatedButton(
        onPressed: ontap,
        style: ButtonStyle(
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius ?? 10))),
            fixedSize: MaterialStatePropertyAll(Size(width, height)),
            backgroundColor: MaterialStatePropertyAll(color ?? Colors.blue)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text ?? '',
                style: TextStyle(color: Colors.white,
                    fontSize: fontsize ?? 20,
                    fontWeight: fontWeight ?? FontWeight.w500)),
            widget ??
                SizedBox(
                  width: 0,
                )
          ],
        ),
      ),
    );
  }
}
