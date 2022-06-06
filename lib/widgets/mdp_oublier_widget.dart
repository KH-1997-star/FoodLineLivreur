import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MDPOublierWidget extends StatelessWidget {
  final VoidCallback? onMdpOublier;
  const MDPOublierWidget({this.onMdpOublier, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onMdpOublier!(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 36.w),
            child: Text(
              'Mot de passe oublié ?',
              style: TextStyle(
                fontSize: 11.sp,
              ),
            ),
          )
        ],
      ),
    );
  }
}
