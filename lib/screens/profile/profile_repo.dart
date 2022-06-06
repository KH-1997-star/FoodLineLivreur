import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:food_line_livreur/models/profilelivreur.dart';
import 'package:food_line_livreur/utils/consts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileLivreurNotifier extends ChangeNotifier {
  ProfileLivreur? livreur;
  Future<bool> getProfileLivreur() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? id = prefs.getString(constId),
          token = prefs.getString(constToken);
      String urlGetProfile =
          '${hostDynamique}api/livreur/read/$id?vueAvancer=comptes_single';

      var response = await http.get(Uri.parse(urlGetProfile), headers: {
        "authorization": "Bearer " + token!,
      });
      if (response.statusCode == 200) {
        (response.body);
        var body = jsonDecode(response.body);
        livreur = ProfileLivreur.fromJson(body[0]);
        ('waalahy t3aaadina ou jawna behy thaabet m3aa touhemi');
        return true;
      } else {
        (response.body);
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateProfile(String? nom, String? prenom, String? ville,
      String? adresse, String? pays, int? codePostale, String? phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString(constId);
    String? token = prefs.getString(constToken);
    Map<String, dynamic> data = {
      "extraPayload": {
        "nom": nom,
        "prenom": prenom,
        "phone": phone,
        "ville": ville,
        "addresse": adresse,
        "pays": pays,
        "codePostal": codePostale,
      }
    };
    String urlUpdateAccount = '${hostDynamique}api/account/updateAccount/$id';
    (urlUpdateAccount);
    var response = await http.post(
      Uri.parse(urlUpdateAccount),
      body: jsonEncode(data),
      headers: {
        "Content-Type": "application/json",
        "authorization": "Bearer " + token!,
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
