// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line_livreur/utils/colors.dart';

class MyTitleButton extends StatelessWidget {
  final double height;
  final double width;
  final String title;
  final Color titleColor;
  final Color color;
  final bool border;
  final Color bordorColor;
  final double fontSize;
  final VoidCallback? onTap;
  final double borderRadius;
  final double? titlePadding;

  const MyTitleButton({
    this.onTap,
    this.color = myblack,
    this.height = 44,
    this.width = 295,
    this.title = '',
    this.border = false,
    this.bordorColor = myblack,
    this.titleColor = Colors.white,
    this.fontSize = 16,
    this.borderRadius = 13,
    this.titlePadding = 0,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap!(),
      child: Container(
        alignment: Alignment.center,
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius.r),
          border: border
              ? Border.all(
                  color: bordorColor,
                  width: 1,
                )
              : Border.all(
                  width: 0,
                  color: Colors.transparent,
                ),
        ),
        child: Padding(
          padding: EdgeInsets.all(titlePadding!),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: TextStyle(
                color: titleColor,
                fontWeight: FontWeight.w700,
                fontSize: fontSize.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
