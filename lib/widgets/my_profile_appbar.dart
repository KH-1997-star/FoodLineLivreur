import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileAppBar extends StatelessWidget {
  final bool fromHome;
  const ProfileAppBar({required this.fromHome, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 32.h, left: 31.w),
      child: Row(
        children: [
          InkWell(
            onTap: () => fromHome
                ? Navigator.pushNamed(context, '/home_screen')
                : Navigator.pop(context),
            child: Stack(
              children: [
                SizedBox(
                  height: 50.h,
                  width: 50.w,
                ),
                Positioned(
                  top: 16.h,
                  child: SvgPicture.asset(
                    'icons/arrow_ios_icon.svg',
                    width: 10.w,
                    height: 17.h,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 70.w,
          ),
          Text(
            'Profil',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
