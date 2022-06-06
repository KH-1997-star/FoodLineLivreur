import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line_livreur/utils/colors.dart';

class CustomInput extends StatelessWidget {
  final FormFieldValidator<String> validator;
  final double height;
  final double width;
  final TextEditingController controller;
  final double radius;
  final String hintText;
  final TextInputType keyboardType;
  final bool enableField;
  final VoidCallback onTap;
  //final TextInputFormatter? formater;
  final bool? isphone;
  final String? texte;
  const CustomInput({
    this.texte,
    required this.onTap,
    this.enableField = false,
    //required this.formater,
    this.height = 60,
    this.width = 303,
    this.radius = 13,
    this.keyboardType = TextInputType.text,
    required this.validator,
    required this.hintText,
    required this.controller,
    key,
    this.isphone = false,
    // required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.symmetric(horizontal: 10),
      width: width.w,
      constraints: BoxConstraints(minHeight: height.h),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(radius.r),
        ),
      ),
      child: TextFormField(
          keyboardType: keyboardType,
          controller: controller,
          cursorColor: myhint,
          //inputFormatters: [formater],
          decoration: InputDecoration(
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(13.0.r),
              ),
              contentPadding: EdgeInsets.only(top: 5.h, left: 10.w),
              hintText: hintText,
              labelText: isphone! ? texte : hintText,
              hintStyle: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  color: myhint),
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
              labelStyle: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  color: enableField ? myGreen : myhint),
              fillColor: mywhitegrey,
              filled: true),
          onTap: onTap,
          // width: width.w,
          validator: validator),
    );
  }
}
