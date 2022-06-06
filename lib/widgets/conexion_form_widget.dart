import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConexionFormWidget extends StatefulWidget {
  final String? titleTxt;
  final Function(String)? onWriting;
  final bool? isPassword;
  final bool? isNumber;
  final String? validationStr;

  const ConexionFormWidget({
    this.titleTxt,
    this.onWriting,
    this.isPassword = false,
    this.isNumber = false,
    this.validationStr = '',
    Key? key,
  }) : super(key: key);

  @override
  State<ConexionFormWidget> createState() => _ConexionFormWidgetState();
}

class _ConexionFormWidgetState extends State<ConexionFormWidget> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.titleTxt!,
          style: TextStyle(
            fontSize: 14.sp,
          ),
        ),
        SizedBox(
          height: 14.h,
        ),
        Container(
          alignment: Alignment.center,
          width: 295.w,
          height: 42.h,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
            ),
            borderRadius: BorderRadius.circular(13.r),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 10.w,
            ),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return widget.validationStr;
                }
              },
              keyboardType:
                  widget.isNumber! ? TextInputType.phone : TextInputType.text,
              obscureText: widget.isPassword!,
              onChanged: (value) => widget.onWriting!(value.trim()),
              controller: textEditingController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                    left: 11.w, right: 3.w, top: 14.h, bottom: 14.h),
                errorStyle: TextStyle(fontSize: 10.sp, height: 0.3),
                border: InputBorder.none,
              ),
            ),
          ),
        )
      ],
    );
  }
}
