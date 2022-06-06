// To parse this JSON data, do
//
//     final station = stationFromJson(jsonString);

import 'dart:convert';

Station stationFromJson(String str) => Station.fromJson(json.decode(str));

String stationToJson(Station data) => json.encode(data.toJson());

class Station {
  Station({
    this.idStation,
    this.name,
    this.position,
    this.distance,
    this.heureArrive,
    this.heureDepart,
    this.nbreCmd,
    this.idTrajetCamion,
  });

  String? idStation;
  String? name;
  List<double>? position;
  double? distance;
  String? heureArrive;
  String? heureDepart;
  int? nbreCmd;
  String? idTrajetCamion;

  factory Station.fromJson(Map<String, dynamic> json) => Station(
        idStation: json["idStation"],
        name: json["name"],
        position: List<double>.from(json["position"].map((x) => x.toDouble())),
        distance: json["distance"].toDouble(),
        heureArrive: json["heureArrive"],
        heureDepart: json["heureDepart"],
        nbreCmd: json["nbreCmd"],
        idTrajetCamion: json["idTrajetCamion"],
      );

  Map<String, dynamic> toJson() => {
        "idStation": idStation,
        "name": name,
        "position": List<dynamic>.from(
          position!.map((x) => x),
        ),
        "distance": distance,
        "heureArrive": heureArrive,
        "heureDepart": heureDepart,
        "nbreCmd": nbreCmd,
        "idTrajetCamion": idTrajetCamion,
      };
}
