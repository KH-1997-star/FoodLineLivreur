import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeColoredWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;
  final bool? clicked;
  final String? number;
  final String? titre;
  final bool isBlack, arret;
  const HomeColoredWidget({
    this.color,
    required this.clicked,
    required this.number,
    this.onTap,
    this.titre,
    this.arret = true,
    this.isBlack = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: arret ? () {} : () => onTap!(),
      child: Container(
        width: 89.w,
        height: 73.h,
        decoration: BoxDecoration(
          color: color!.withOpacity(0.11),
          border: clicked! && !arret ? Border.all() : null,
          borderRadius: BorderRadius.all(
            Radius.circular(18.r),
          ),
        ),
        child: Column(
          children: [
            Text(
              number!,
              style: TextStyle(
                fontSize: 25.sp,
                color: isBlack ? Colors.black : color,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              titre!,
              style: TextStyle(
                fontSize: 11.sp,
                color: isBlack ? Colors.black : color,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
