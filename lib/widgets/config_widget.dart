import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfigurationWidget extends StatelessWidget {
  final VoidCallback? onConfig;
  const ConfigurationWidget({this.onConfig, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onConfig!(),
      child: Container(
        alignment: Alignment.center,
        height: 29.w,
        width: 29.w,
        child: SvgPicture.asset(
          'icons/path.svg',
          height: 20.h,
          width: 20.w,
        ),
        decoration: BoxDecoration(
          color: const Color(0xffF5F5F5),
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              blurRadius: 4,
              offset: const Offset(0, 1), // Shadow position
            ),
          ],
        ),
      ),
    );
  }
}
