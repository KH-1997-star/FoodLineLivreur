import 'package:flutter/material.dart';
import 'package:food_line_livreur/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GOWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String? title;
  const GOWidget({this.title, this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap!(),
      child: Container(
        alignment: Alignment.center,
        height: 82.w,
        width: 82.w,
        decoration: const BoxDecoration(
          color: myGreen,
          shape: BoxShape.circle,
        ),
        child: Container(
          alignment: Alignment.center,
          height: 52.w,
          width: 52.w,
          decoration: BoxDecoration(
            color: myGreen,
            border: Border.all(
              color: Colors.white,
            ),
            shape: BoxShape.circle,
          ),
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                title!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
