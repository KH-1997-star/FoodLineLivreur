import 'package:flutter/material.dart';
import 'package:food_line_livreur/utils/functions.dart';

class FullScreenForStackWidget extends StatelessWidget {
  const FullScreenForStackWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeight(context),
      width: getWidth(context),
    );
  }
}
