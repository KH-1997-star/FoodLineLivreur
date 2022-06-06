import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:food_line_livreur/screens/forget_password_second_screen.dart';
import 'package:food_line_livreur/screens/forget_password_third_screen.dart';
import 'package:food_line_livreur/utils/colors.dart';
import 'package:food_line_livreur/utils/consts.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'dart:convert';
import 'dart:io';

class ForgetPasswordViewModel extends ChangeNotifier {
  final url = hostDynamique + "account/codeActivationMotDePasseOublier";
  final urlActiv = hostDynamique + "account/checkCodeActivation";
  final urlchange = hostDynamique + "account/changerPassword";
  bool? _isLoading;
  String? _email;
  String? _password;
  String? _code;
  String? token;
  ForgetPasswordViewModel();
  bool get isLoading => _isLoading ?? false;
  String get email => _email ?? "false";
  String get password => _password ?? "false";
  String get code => _code ?? "false";
  set password(String password) {
    _password = email;
  }

  set code(String code) {
    _code = code;
  }

  set email(String email) {
    _email = email;
  }

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
  }

  updateWith({isLoading}) {
    _isLoading = isLoading;
    notifyListeners();
  }

  String typee = "";
  Future<void> forgetPasswordOne(BuildContext context, String _email) async {
    Loader.show(context,
        progressIndicator: const CircularProgressIndicator(
          backgroundColor: myGreen,
          color: myGreen,
        ),
        themeData: Theme.of(context).copyWith(accentColor: Colors.white));
    updateWith(isLoading: true);

    var data = {"email": _email};
    print("************************************");
    print(data);
    print(url + "*********");
    try {
      var response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
          encoding: Encoding.getByName('utf-8'),
          body: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Loader.hide();

        print(response.body[0]);

//TODO
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ForgetPwdTwoScreen(
                      email: _email,
                    )));
      } else {
        Loader.hide();
        print(response.body);

        Toast.show("E-mail invalide", context,
            backgroundColor: Colors.red, duration: 2, gravity: 3);

        print("Il semble qu'il a y eu un problème !.");
      }
    } on SocketException {
      Loader.hide();

      Toast.show("Veuillez vérifier votre connexion réseau.", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      print("Il semble qu'il a y eu un problème !.");
    } on HttpException {
      Loader.hide();

      Toast.show("Il semble qu'il a y eu un problème !", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      print("Il semble qu'il a y eu un problème !.");
    } on FormatException {
      Loader.hide();

      Toast.show("Il semble qu'il a y eu un problème !", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      print("Il semble qu'il a y eu un problème !.");
    }
  }

  Future<void> forgetPasswordTwo(
      BuildContext context, String _pinCODE, String? _email) async {
    updateWith(isLoading: true);
    Loader.show(context,
        progressIndicator: const CircularProgressIndicator(
          backgroundColor: myGreen,
        ),
        themeData: Theme.of(context).copyWith(accentColor: Colors.white));

    var data = {
      "email": _email,
      "code": _pinCODE,
    };
    print("************************************");
    print(data);
    print(urlActiv);
    try {
      var response = await http.post(Uri.parse(urlActiv), body: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Loader.hide();

        print(response.body);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ForgetPwdThreeScreen(
                      email: _email,
                    )));
      } else if (response.statusCode == 400) {
        Loader.hide();
        Toast.show('Code incorrect', context,
            backgroundColor: Colors.red, duration: 2, gravity: 3);

        print(response.body);
        print("Il semble qu'il a y eu un problème !.");
      } else {
        Loader.hide();
        Toast.show('Code incorrect', context,
            backgroundColor: Colors.red, duration: 2, gravity: 3);

        print(response.body);
        print("Il semble qu'il a y eu un problème !.");
      }
    } on SocketException {
      Loader.hide();

      Toast.show("Veuillez vérifier votre connexion", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      print("Il semble qu'il a y eu un problème !.");
    } on HttpException {
      Loader.hide();

      Toast.show("Il semble qu'il a y eu un problème !", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      print("Il semble qu'il a y eu un problème !.");
    } on FormatException {
      Loader.hide();

      Toast.show("Il semble qu'il a y eu un problème !", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      print("Il semble qu'il a y eu un problème !.");
    }
  }

  Future<void> newPassword(
      BuildContext context, String? _newpwd, String? _email) async {
    Loader.show(context,
        progressIndicator: const CircularProgressIndicator(
          backgroundColor: myGreen,
        ),
        themeData: Theme.of(context).copyWith(
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Colors.white)));
    updateWith(isLoading: true);

    var data = {
      "email": _email,
      "password": _newpwd,
    };
    print("************************************");
    print(data);
    print(urlchange);
    try {
      var response = await http.post(Uri.parse(urlchange),
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
          encoding: Encoding.getByName('utf-8'),
          body: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Loader.hide();

        print(response.body);
        Toast.show("Mot de passe changé avec succés!", context,
            duration: 1, gravity: 1);
        Navigator.pushNamed(context, '/conexion_screen');
      } else {
        Loader.hide();
        Toast.show("Il semble qu'il y a eu un problème!", context,
            backgroundColor: Colors.red, duration: 2, gravity: 3);

        print("Il semble qu'il a y eu un problème !.");
      }
    } on SocketException {
      Loader.hide();
      Toast.show("Il semble qu'il a y eu un problème !", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);

      print("Il semble qu'il a y eu un problème !.");
    } on HttpException {
      Loader.hide();

      Toast.show("Il semble qu'il a y eu un problème !", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      print("Il semble qu'il a y eu un problème !.");
    } on FormatException {
      Loader.hide();

      Toast.show("Il semble qu'il a y eu un problème !", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      print("Il semble qu'il a y eu un problème !.");
    }
  }

  void resendCode(BuildContext context, String? email) async {
    Loader.show(context,
        progressIndicator: const CircularProgressIndicator(
          backgroundColor: myGreen,
        ),
        themeData: Theme.of(context).copyWith(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white)));
    var data = {"email": email};
    String url = hostDynamique + "account/codeActivationMotDePasseOublier";
    print(data);
    try {
      var response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("******************** SUCCESS **********************");
        print(response.body);
        Loader.hide();
        Toast.show("E-mail envoyé", context,
            backgroundColor: myhint, duration: 2, gravity: 3);
      } else {
        Loader.hide();
        print("******************** FAILD **********************");
        print(response.body);
        Toast.show("Réessayer", context,
            backgroundColor: Colors.red, duration: 2, gravity: 3);
      }
    } on SocketException {
      Loader.hide();
      print('**************** EXCEPTION*******************');
      Toast.show("Veuillez Vérifier votre conexion ", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
    } on HttpException {
      print('**************** EXCEPTION*******************');
      Toast.show("Il semble qu'il a y eu un problème.", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      Loader.hide();
    } on FormatException {
      print('**************** EXCEPTION*******************');
      Toast.show("Il semble qu'il a y eu un problème.", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      Loader.hide();
    }
  }
}
