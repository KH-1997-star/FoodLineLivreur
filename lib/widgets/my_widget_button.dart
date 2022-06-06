import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line_livreur/utils/colors.dart';

class MyWidgetButton extends StatelessWidget {
  final double height;
  final double width;
  final Widget widget;
  final double radius;
  final Color color;
  final double borderWidth;
  final bool isBordred;
  final VoidCallback onTap;
  final Color borderColor;
  const MyWidgetButton({
    this.height = 40,
    this.width = 40,
    this.radius = 15,
    this.borderColor = myGreen,
    this.isBordred = false,
    this.borderWidth = 1,
    required this.widget,
    this.color = myGreen,
    required this.onTap,
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        height: height.h,
        width: width.w,
        child: widget,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius.r),
          border: isBordred
              ? Border.all(
                  color: borderColor,
                  width: borderWidth,
                )
              : null,
        ),
      ),
    );
  }
}
