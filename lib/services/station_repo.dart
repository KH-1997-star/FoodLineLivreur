import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_line_livreur/models/command_list.dart';
import 'package:food_line_livreur/models/command_status.dart';
import 'package:food_line_livreur/models/commande_menu.dart';
import 'package:food_line_livreur/models/station.dart';
import 'package:food_line_livreur/screens/command_list_screen.dart';
import 'package:food_line_livreur/utils/consts.dart';
import 'package:food_line_livreur/utils/functions.dart';
import 'package:http/http.dart' as http;

class StationNotifier extends ChangeNotifier {
  late String urlGetStations;
  List<Station> staions = [];
  CommandStatus? commandStatus;
  bool? resultForStaion;
  CommandList? commandList;
  Future<bool> getStation() async {
    try {
      String? id = await getCurrentId();
      String? token = await getCurrentToken();
      urlGetStations =
          '${hostDynamique}api/livreur/listeStationsDuJour?livreur=$id';
      var response = await http.get(
        Uri.parse(urlGetStations),
        headers: {
          "authorization": "Bearer " + token!,
        },
      );
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        (json['listeStations']);
        List stationList = json['listeStations'];
        List<Station> myStationList = [];
        for (var element in stationList) {
          myStationList.add(Station.fromJson(element));
        }
        staions = myStationList;
        print(staions);

        return true;
      } else {
        print(response.body);

        return false;
      }
    } catch (e) {
      print('ERROR');
      return false;
    }
  }

  getAllCommandStatus() async {
    try {
      String? id = await getCurrentId(), token = await getCurrentToken();
      String urlGetCommandStatus =
          '${hostDynamique}api/livreur/nbreCommandesDujourParLivreur?livreur=$id';
      var response = await http.get(Uri.parse(urlGetCommandStatus), headers: {
        "authorization": "Bearer " + token!,
      });
      if (response.statusCode == 200) {
        print('GETTING ALL COMMAND');
        var json = jsonDecode(response.body);
        commandStatus = CommandStatus.fromJson(json);
        return true;
      } else {
        print('Not GETTING ALL COMMAND');
        return false;
      }
    } catch (e) {
      print(' NOT GETTING ALL COMMAND');
      return false;
    }
  }

  Future<bool> updateLivreurDispo(bool dispo) async {
    try {
      String? id = await getCurrentId();
      String? token = await getCurrentToken();
      String urlDispo = '${hostDynamique}api/livreur/update/comptes/$id';
      Map<String, dynamic> data = {
        "extraPayload": {
          "disponible": dispo ? "1" : "0",
        }
      };
      (data);
      var response = await http.post(
        Uri.parse(urlDispo),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json",
          "authorization": "Bearer " + token!,
        },
      );
      if (response.statusCode == 200) {
        notifyListeners();
        return true;
      } else {
        notifyListeners();
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<CommandList> getCommands(
      String idStation, String idTrajetCamion) async {
    try {
      String? id = await getCurrentId();
      String? token = await getCurrentToken();
      String urlCommands =
          '${hostDynamique}api/livreur/listeDesCommandesRegroupresParStatut?livreur=$id&idStation=$idStation&idTrajetCamion=$idTrajetCamion';
      var response = await http.get(Uri.parse(urlCommands), headers: {
        "authorization": "Bearer " + token!,
      });
      print(
          '${hostDynamique}api/livreur/listeDesCommandesRegroupresParStatut?livreur=$id&idStation=$idStation&idTrajetCamion=$idTrajetCamion');
      if (response.statusCode == 200) {
        print('20000000000');
        print(response.body);
        commandList = CommandList.fromJson(jsonDecode(response.body));
        return commandList ??
            CommandList(
              delivered: [],
              annule: [],
              enAttente: [],
            );
      } else {
        print('ERREUR KH');
        print(response.body);
        return CommandList(
          delivered: [],
          annule: [],
          enAttente: [],
          typeBtn: 'false',
        );
      }
    } catch (e) {
      print('EXCEPTION');
      return CommandList(
        delivered: [],
        annule: [],
        enAttente: [],
        typeBtn: 'false',
      );
    }
  }

  Future traiterCommand(String idCmd, String statut) async {
    try {
      String? token = await getCurrentToken();
      String urlChangeStatus =
          '${hostDynamique}api/livreur/changeStatutCommande/$idCmd';
      Map<String, dynamic> data = {
        "extraPayload": {
          "statut": statut,
        }
      };
      var response = await http.post(
        Uri.parse(urlChangeStatus),
        headers: {
          "Content-Type": "application/json",
          "authorization": "Bearer " + token!,
        },
        body: jsonEncode(data),
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

  Future<bool> changeStatutCommande(String statut, String? idCmd, context,
      String? idStation, String? idTrajet, String? name) async {
    try {
      String? token = await getCurrentToken();
      print(token);
      String urlChangeStatus =
          '${hostDynamique}api/livreur/changeStatutCommande/$idCmd';
      Map<String, dynamic> data = {
        "extraPayload": {
          "statut": statut,
        }
      };
      var response = await http.post(
        Uri.parse(urlChangeStatus),
        headers: {
          "Content-Type": "application/json",
          "authorization": "Bearer " + token!,
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CommandListScreen(
              idStation: idStation,
              idTrajet: idTrajet,
              title: name,
            ),
          ),
        );
        return true;
      } else {
        print(response.statusCode);
        return false;
      }
    } catch (e) {
      print('EXCEPTION');
      return false;
    }
  }

  Future<Map<String, dynamic>> getSpeceficCommand(String idCmd) async {
    try {
      print('HIIIIII');
      String? token = await getCurrentToken();
      String urlSpeceficCmd = '${hostDynamique}api/livreur/read/$idCmd';
      var response = await http.get(Uri.parse(urlSpeceficCmd), headers: {
        "authorization": "Bearer " + token!,
      });
      if (response.statusCode == 200) {
        print('SUCESSFULLY');
        var body = jsonDecode(response.body);
        print(body);
        return {
          'result': true,
          'numeroCommande': body[0]['numeroCommande'],
          'ttc': body[0]['totalTTC'],
          'quantite': body[0]['quantite'],
          'idStation': body[0]['station'],
          'idTrajet': body[0]['trajetCamion'],
          'statut': body[0]['statut'],
        };
      } else {
        return {'result': false, 'message': erreurUlterieur};
      }
    } on SocketException {
      return {'result': false, 'message': erreurCnx};
    } catch (e) {
      return {'result': false, 'message': 'ce code QR est invalide'};
    }
  }

  Future<Map<String, dynamic>> changeEtatCommande(
      String statut, String idStation, String idTrajetCamion) async {
    try {
      String? token = await getCurrentToken();
      String? idLivreur = await getCurrentId();
      String urlChangeEtatCommand =
          '${hostDynamique}api/livreur/actionMap?livreur=$idLivreur&idStation=$idStation&idTrajetCamion=$idTrajetCamion&statut=$statut';

      var response = await http.get(
        Uri.parse(urlChangeEtatCommand),
        headers: {
          "authorization": "Bearer " + token!,
        },
      );
      if (response.statusCode == 200) {
        print('Yesss');
        return {'result': true};
      } else {
        print('Noo');
        return {'result': false, 'message': erreurUlterieur};
      }
    } catch (e) {
      return {'result': false, 'message': erreurCnx};
    }
  }

  Future<Map<String, dynamic>> getDetailCommand(String idCmd) async {
    try {
      String? id = await getCurrentId();
      String? token = await getCurrentToken();
      String urlDetailCommand =
          '${hostDynamique}api/livreur/detailsCommande/$idCmd';
      var response = await http.get(
        Uri.parse(urlDetailCommand),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print('${hostDynamique}api/livreur/detailsCommande/$idCmd');
      if (response.statusCode == 200) {
        print(response.body);
        CommandeMenu commandeMenu = CommandeMenu.fromJson(
          jsonDecode(response.body),
        );
        return {'result': true, 'data': commandeMenu};
      } else {
        print(response.statusCode);
        return {'result': false, 'message': erreurUlterieur};
      }
    } catch (e) {
      return {'result': false, 'message': erreurCnx};
    }
  }
}
