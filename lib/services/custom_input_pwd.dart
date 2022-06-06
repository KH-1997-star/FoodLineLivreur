import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line_livreur/utils/colors.dart';

class CustomInputPwd extends StatelessWidget {
  //final FormFieldValidator<String> validator;
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget suffixIcon;
  final double width;
  final bool enableField;
  //final FocusNode myFocusNode;
  final FormFieldValidator<String> validator;
  final VoidCallback onTap;
  final double height;
  final double radius;
  const CustomInputPwd({
    key,
    required this.validator,
    required this.labelText,
    //required this.myFocusNode,
    this.height = 60,
    this.width = 330,
    this.radius = 13,
    required this.onTap,
    // required this.validator,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    required this.suffixIcon,
    this.enableField = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        //padding: const EdgeInsets.symmetric(horizontal: 10),
        width: width.w,
        height: 80.h,
        constraints: BoxConstraints(minHeight: height.h),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(
            Radius.circular(radius.r),
          ),
        ),
        child: TextFormField(
          keyboardType: keyboardType,
          obscureText: obscureText,
          controller: controller,

          cursorColor: myhint,
          // focusNode: myFocusNode,
          decoration: InputDecoration(
              helperText: ' ',
              // contentPadding:
              // new EdgeInsets.symmetric(vertical: 18.0, horizontal: 18.0),
              suffixIcon: suffixIcon,
              contentPadding: EdgeInsets.only(top: 5.h, left: 10.w),
              hintText: labelText,
              labelText: labelText,
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(13.0.r),
              ),
              focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(13.r),
                  ),
                  borderSide: BorderSide(width: 1, color: Colors.white)),
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(radius.r),
                borderSide: const BorderSide(
                  color: Colors.white,
                  // width: 0.5,
                ),
              ),
              errorBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(13.0.r),
                borderSide: const BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              hintStyle: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  color: myhint),
              labelStyle: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  color: enableField ? myGreen : myhint),
              fillColor: mywhitegrey,
              filled: true),

          style: const TextStyle(
            fontFamily: "Roboto",
          ),
          onTap: onTap,
          // validator: validator
          validator: validator,
        ));
  }
}
