// To parse this JSON data, do
//
//     final commandStatus = commandStatusFromJson(jsonString);

import 'dart:convert';

CommandStatus commandStatusFromJson(String str) =>
    CommandStatus.fromJson(json.decode(str));

String commandStatusToJson(CommandStatus data) => json.encode(data.toJson());

class CommandStatus {
  CommandStatus({
    this.nbreCommandesdelivered,
    this.nbreCommandeEnAttente,
    this.nbreCommandesAnnule,
  });

  int? nbreCommandesdelivered;
  int? nbreCommandeEnAttente;
  int? nbreCommandesAnnule;

  factory CommandStatus.fromJson(Map<String, dynamic> json) => CommandStatus(
        nbreCommandesdelivered: json["nbreCommandesdelivered"],
        nbreCommandeEnAttente: json["nbreCommandeEnAttente"],
        nbreCommandesAnnule: json["nbreCommandesAnnule"],
      );

  Map<String, dynamic> toJson() => {
        "nbreCommandesdelivered": nbreCommandesdelivered,
        "nbreCommandeEnAttente": nbreCommandeEnAttente,
        "nbreCommandesAnnule": nbreCommandesAnnule,
      };
}
