import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:food_line_livreur/utils/consts.dart';
import 'package:food_line_livreur/utils/functions.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends ChangeNotifier {
  String urlLogin = '${hostDynamique}login';
  Location location = Location();
  String msg = '';

  Future<String> signInWithEmailAndPassWord(email, password) async {
    Map<String, dynamic> data = {
      'email': email,
      'password': password,
      'role': 'ROLE_LIVREUR',
    };
    try {
      var responce = await http.post(
        Uri.parse(urlLogin),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName('utf-8'),
        body: data,
      );
      if (responce.statusCode == 200) {
        var body = jsonDecode(responce.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(constId, body["identifiantMongo"]);
        prefs.setString(constToken, body["token"]);
        msg = body['message'];
        var loc = await location.getLocation();
        String id = body["identifiantMongo"];
        String token = body["token"];
        String locUrl = '${hostDynamique}api/livreur/update/comptes/$id';
        Map<String, dynamic> data = {
          "extraPayload": {
            "position": [loc.latitude, loc.longitude],
          }
        };
        var postResp = await http.post(
          Uri.parse(locUrl),
          body: jsonEncode(data),
          headers: {
            "Content-Type": "application/json",
            "authorization": "Bearer " + token,
          },
        );
        if (postResp.statusCode == 200) {
          ('b3aaathna il position yaaal touhemy');
        }

        return body['message'];
      } else {
        var body = jsonDecode(responce.body);
        var message = body['message'];
        if (message == 'Login incorrecte') {
          message = 'email incorrect,veuillez entrer un email valide!';
        }
        if (message == 'Invalid credentials.') {
          message =
              'mots de passe incorrect,veuillez entrer un mots de passe valide!';
        }

        return message.toString();
      }
    } on HttpException {
      return erreurUlterieur;
    } on FormatException {
      ('2');
      ('autre probleme');
      return erreurUlterieur;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        (e.code);
      }

      return 'activer votre localisation gps svp';
    } catch (e) {
      return 'vérifier votre connexion internet et réessayer';
    }
  }

  Future<Map<String, dynamic>> login(email, password, message) async {
    message = await signInWithEmailAndPassWord(email, password);

    return {'result': true, 'message': message};
  }

  Future<bool> logOut() async {
    bool done = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    done = await prefs.remove('token');
    if (done) {
      done = await prefs.remove('id');
    }
    return done;
  }
}
