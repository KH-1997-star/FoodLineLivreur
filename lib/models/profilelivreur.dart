// To parse this JSON data, do
//
//     final ProfileLivreur = ProfileLivreurFromJson(jsonString);

import 'dart:convert';

ProfileLivreur profileLivreurFromJson(String str) =>
    ProfileLivreur.fromJson(json.decode(str));

String rofileLivreurToJson(ProfileLivreur data) => json.encode(data.toJson());

class ProfileLivreur {
  ProfileLivreur({
    this.identifiant = 'inconnu',
    this.nom = 'inconnu',
    this.prenom = 'inconnu',
    this.email = 'inconnu',
    this.phone = 'inconnu',
    this.aPropos,
    this.photoProfil,
    this.addresse = 'inconnu',
    this.ville = 'inconnu',
    this.pays = 'inconnu',
    this.codePostal,
    this.position,
    this.tempsLivraison,
    this.isActive,
    this.role,
    this.disponible,
  });

  String? identifiant;
  String? nom;
  String? prenom;
  String? email;
  String? phone;
  String? aPropos;
  String? photoProfil;
  String? addresse;
  String? ville;
  String? pays;
  int? codePostal;
  dynamic position;
  String? tempsLivraison;
  String? isActive;
  String? role;
  String? disponible;

  factory ProfileLivreur.fromJson(Map<String, dynamic> json) => ProfileLivreur(
        identifiant: json["Identifiant"],
        nom: json["nom"],
        prenom: json["prenom"],
        email: json["email"],
        phone: json["phone"],
        aPropos: json["aPropos"],
        photoProfil: json["photoProfil"],
        addresse: json["addresse"],
        ville: json["ville"],
        pays: json["pays"],
        codePostal: json["codePostal"],
        position: json["position"],
        tempsLivraison: json["tempsLivraison"],
        isActive: json["isActive"],
        role: json["role"],
        disponible: json["disponible"],
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "nom": nom,
        "prenom": prenom,
        "email": email,
        "phone": phone,
        "aPropos": aPropos,
        "photoProfil": photoProfil,
        "addresse": addresse,
        "ville": ville,
        "pays": pays,
        "codePostal": codePostal,
        "position": position,
        "tempsLivraison": tempsLivraison,
        "isActive": isActive,
        "role": role,
        "disponible": disponible,
      };
}
