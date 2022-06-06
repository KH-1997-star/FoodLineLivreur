import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line_livreur/utils/colors.dart';
import 'package:food_line_livreur/utils/functions.dart';

class BottomLocationWidget extends StatelessWidget {
  final Widget? bottomWidget;
  const BottomLocationWidget({this.bottomWidget, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 20,
          offset: const Offset(-2, 2), // Shadow position
        ),
      ]),
      width: getWidth(context),
      height: 77.h,
      child: Column(
        children: [
          SizedBox(
            height: 12.1.h,
          ),
          Container(
            width: 69.5.w,
            height: 3,
            decoration: BoxDecoration(
              color: myblack,
              borderRadius: BorderRadius.circular(5.r),
            ),
          ),
          SizedBox(
            height: 14.9.h,
          ),
          bottomWidget!
        ],
      ),
    );
  }
}
