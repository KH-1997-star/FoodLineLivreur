import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:food_line_livreur/utils/consts.dart';
import 'package:food_line_livreur/utils/functions.dart';
import 'package:http/http.dart' as http;

class LocationTracking extends ChangeNotifier {
  Future<bool> changeLivreurLocation(
      {required double lat, required double lng}) async {
    try {
      String? id = await getCurrentId(), token = await getCurrentToken();
      Map<String, dynamic> data = {
        "extraPayload": {
          "position": [lat, lng],
        }
      };
      String locUrl = '${hostDynamique}api/livreur/update/comptes/$id';
      var response = await http.post(
        Uri.parse(locUrl),
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
    } catch (e) {
      return false;
    }
  }
}
