import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoAccountWidget extends StatelessWidget {
  final VoidCallback? onTap;
  const NoAccountWidget({this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Vous n\'avez pas de compte ?',
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w200,
          ),
        ),
        InkWell(
          onTap: () => onTap!(),
          child: Text(
            ' S\'inscrire',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
