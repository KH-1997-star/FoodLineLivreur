// To parse this JSON data, do
//
//     final commandList = commandListFromJson(jsonString);

import 'dart:convert';

CommandList commandListFromJson(String str) =>
    CommandList.fromJson(json.decode(str));

String commandListToJson(CommandList data) => json.encode(data.toJson());

class CommandList {
  CommandList({
    this.delivered,
    this.enAttente,
    this.annule,
    this.typeBtn,
  });

  List<Annule>? delivered;
  List<Annule>? enAttente;
  List<Annule>? annule;
  String? typeBtn;

  factory CommandList.fromJson(Map<String, dynamic> json) => CommandList(
        delivered:
            List<Annule>.from(json["delivered"].map((x) => Annule.fromJson(x))),
        enAttente:
            List<Annule>.from(json["enAttente"].map((x) => Annule.fromJson(x))),
        annule:
            List<Annule>.from(json["annule"].map((x) => Annule.fromJson(x))),
        typeBtn: json["typeBtn"],
      );

  Map<String, dynamic> toJson() => {
        "delivered": List<dynamic>.from(delivered!.map((x) => x.toJson())),
        "enAttente": List<dynamic>.from(enAttente!.map((x) => x.toJson())),
        "annule": List<dynamic>.from(annule!.map((x) => x.toJson())),
        "typeBtn": typeBtn,
      };
}

class Annule {
  Annule({
    this.numeroCommande,
    this.idCommande,
    this.totalTtc,
    this.quantite,
    this.statut,
    this.date,
  });

  int? numeroCommande;
  String? idCommande;
  dynamic totalTtc;
  int? quantite;
  String? statut;
  String? date;

  factory Annule.fromJson(Map<String, dynamic> json) => Annule(
        numeroCommande: json["numeroCommande"],
        idCommande: json["idCommande"],
        totalTtc: json["totalTTC"],
        quantite: json["quantite"],
        statut: json["statut"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "numeroCommande": numeroCommande,
        "idCommande": idCommande,
        "totalTTC": totalTtc,
        "quantite": quantite,
        "statut": statut,
        "date": date,
      };
}
