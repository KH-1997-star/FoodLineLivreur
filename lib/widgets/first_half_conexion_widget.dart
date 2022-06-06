import 'package:flutter/material.dart';
import 'package:food_line_livreur/utils/colors.dart';
import 'package:food_line_livreur/utils/functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirstHalfConexionWidget extends StatelessWidget {
  const FirstHalfConexionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: getWidth(context),
      height: 320.h,
      color: myblack,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Food',
                style: TextStyle(
                  fontSize: 27.sp,
                  color: mywhite,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'Line',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 27.sp,
                  color: myGreen,
                ),
              )
            ],
          ),
          Text(
            'Livraison',
            style: TextStyle(
              fontSize: 27.sp,
              color: mywhite,
            ),
          )
        ],
      ),
    );
  }
}
