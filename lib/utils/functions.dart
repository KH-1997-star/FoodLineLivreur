import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_line_livreur/utils/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'colors.dart';

double getHeight(context) => MediaQuery.of(context).size.height;
double getWidth(context) => MediaQuery.of(context).size.width;
bool isValidEmail(email) {
  return RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
}

void hideKeyborad() => FocusManager.instance.primaryFocus?.unfocus();
Future<String?> getCurrentId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? id = prefs.getString(constId);
  return id;
}

Future<String?> getCurrentToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString(constToken);
  return token;
}

showLoader(context) => Loader.show(
      context,
      progressIndicator: const CircularProgressIndicator(
        backgroundColor: mygrey,
      ),
      themeData: Theme.of(context).copyWith(
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
      ),
    );
hideLoader(context) => Loader.hide();

showToast(String msg) => Fluttertoast.showToast(
      msg: msg,
    );
