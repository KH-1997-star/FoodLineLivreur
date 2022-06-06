import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IdentityProfile extends StatelessWidget {
  final String? name, id, path;
  final int? score;
  const IdentityProfile({this.name, this.id, this.path, this.score, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 42.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 6.w),
                child: SizedBox(
                  width: 120.w,
                  child: Text(
                    name!,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                  ),
                ),
              ),
              /*  SizedBox(
                height: 6.h,
              ), */
              /*   Text(
                'ID:$id',
                style: TextStyle(
                  color: const Color(0xff89898A),
                  fontSize: 12.sp,
                ),
              ), */
              SizedBox(
                height: 12.h,
              ),
              /*  Padding(
                padding: EdgeInsets.only(left: 3.w),
                child: Row(
                  children: [
                    Text(
                      'Score',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 33.6.w,
                    ),
                    starsWidget(5, 5, 'icons/star_icon.svg')
                  ],
                ),
              ), */
            ],
          ),
        ),
        SizedBox(
          width: 70.w,
        ),
        Container(
          height: 63.h,
          width: 63.w,
          child: path == '' || path == null
              ? Image.asset('icons/user.png')
              : Image.network(
                  path!,
                  fit: BoxFit.cover,
                ),
          color: Colors.grey,
        )
      ],
    );
  }

  Widget starsWidget(int ns, int note, String path) {
    return SizedBox(
      width: 11.08.w * ns * 2.9,
      height: 10.5.h,
      child: ListView.builder(
        itemCount: ns,
        itemBuilder: (context, inedx) {
          return Row(
            children: [
              SvgPicture.asset(
                path,
                height: 10.5.h,
                width: 11.08.w,
                color: note > inedx ? const Color(0xffFFC529) : Colors.grey,
              ),
              SizedBox(
                width: 2.9.w,
              ),
            ],
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
