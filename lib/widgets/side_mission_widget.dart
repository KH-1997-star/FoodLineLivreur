import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SideMissionWidget extends StatelessWidget {
  final Color? color;
  final Widget? myWidget;
  final bool? top, center;
  final double? opacity;
  final double height;

  final VoidCallback? onTap;
  const SideMissionWidget(
      {this.color,
      this.opacity,
      this.myWidget,
      this.center = false,
      this.top = false,
      this.onTap,
      this.height = 57.72,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap!(),
      child: Container(
        alignment: Alignment.center,
        height: height.h,
        width: 50.h,
        decoration: BoxDecoration(
          color: color!.withOpacity(opacity!),
          borderRadius: BorderRadius.only(
            topRight: top! && !center!
                ? Radius.circular(12.r)
                : const Radius.circular(0),
            bottomRight: !top! && !center!
                ? Radius.circular(12.r)
                : const Radius.circular(0),
          ),
        ),
        child: myWidget,
      ),
    );
  }
}
