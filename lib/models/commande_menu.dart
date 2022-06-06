// To parse this JSON data, do
//
//     final commandeMenu = commandeMenuFromJson(jsonString);

import 'dart:convert';

CommandeMenu commandeMenuFromJson(String str) =>
    CommandeMenu.fromJson(json.decode(str));

String commandeMenuToJson(CommandeMenu data) => json.encode(data.toJson());

class CommandeMenu {
  CommandeMenu({
    this.detailsCommande,
  });

  DetailsCommande? detailsCommande;

  factory CommandeMenu.fromJson(Map<String, dynamic> json) => CommandeMenu(
        detailsCommande: DetailsCommande.fromJson(json["detailsCommande"]),
      );

  Map<String, dynamic> toJson() => {
        "detailsCommande": detailsCommande!.toJson(),
      };
}

class DetailsCommande {
  DetailsCommande({
    this.identifiant,
    this.numeroCommande,
    this.numeroFacture,
    this.client,
    this.livreur,
    this.station,
    this.listeMenusCommande,
    this.dateCreation,
    this.statut,
    this.etatCommande,
    this.quantite,
    this.totalTtc,
    this.idPaiement,
    this.modePaiement,
    this.statutPaiement,
  });

  String? identifiant;
  int? numeroCommande;
  String? numeroFacture;
  Client? client;
  Client? livreur;
  MyStation? station;
  List<ListeMenusCommande>? listeMenusCommande;
  DateTime? dateCreation;
  String? statut;
  String? etatCommande;
  int? quantite;
  double? totalTtc;
  String? idPaiement;
  String? modePaiement;
  String? statutPaiement;

  factory DetailsCommande.fromJson(Map<String, dynamic> json) =>
      DetailsCommande(
        identifiant: json["Identifiant"],
        numeroCommande: json["numeroCommande"],
        numeroFacture: json["numeroFacture"],
        client: Client.fromJson(json["client"]),
        livreur: Client.fromJson(json["livreur"]),
        station: MyStation.fromJson(json["station"]),
        listeMenusCommande: List<ListeMenusCommande>.from(
            json["listeMenusCommande"]
                .map((x) => ListeMenusCommande.fromJson(x))),
        dateCreation: DateTime.parse(json["dateCreation"]),
        statut: json["statut"],
        etatCommande: json["etatCommande"],
        quantite: json["quantite"],
        totalTtc: json["totalTTC"].toDouble(),
        idPaiement: json["idPaiement"],
        modePaiement: json["modePaiement"],
        statutPaiement: json["statutPaiement"],
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "numeroCommande": numeroCommande,
        "numeroFacture": numeroFacture,
        "client": client!.toJson(),
        "livreur": livreur!.toJson(),
        "station": station!.toJson(),
        "listeMenusCommande":
            List<dynamic>.from(listeMenusCommande!.map((x) => x.toJson())),
        "dateCreation": dateCreation!.toIso8601String(),
        "statut": statut,
        "etatCommande": etatCommande,
        "quantite": quantite,
        "totalTTC": totalTtc,
        "idPaiement": idPaiement,
        "modePaiement": modePaiement,
        "statutPaiement": statutPaiement,
      };
}

class Client {
  Client({
    this.id,
    this.nom,
    this.prenom,
    this.email,
    this.tel,
  });

  String? id;
  String? nom;
  String? prenom;
  String? email;
  String? tel;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        nom: json["nom"],
        prenom: json["prenom"],
        email: json["email"],
        tel: json["tel"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nom": nom,
        "prenom": prenom,
        "email": email,
        "tel": tel,
      };
}

class ListeMenusCommande {
  ListeMenusCommande({
    this.identifiant,
    this.linkedCommande,
    this.linkedMenu,
    this.tailles,
    this.sauces,
    this.viandes,
    this.garnitures,
    this.boisons,
    this.autres,
    this.quantite,
    this.prixHt,
    this.prixTtc,
    this.remise,
    this.statut,
    this.description,
    this.dateCreation,
    this.dateLastModif,
    this.logoResto,
  });

  String? identifiant;
  String? linkedCommande;
  List<LinkedMenu>? linkedMenu;
  List<ListeMenusCommandeTaille>? tailles;
  List<ListeMenusCommandeBoison>? sauces;
  List<dynamic>? viandes;
  List<ListeMenusCommandeBoison>? garnitures;
  List<ListeMenusCommandeBoison>? boisons;
  List<dynamic>? autres;
  int? quantite;
  String? prixHt;
  double? prixTtc;
  String? remise;
  String? statut;
  String? description;
  DateTime? dateCreation;
  DateTime? dateLastModif;
  String? logoResto;

  factory ListeMenusCommande.fromJson(Map<String, dynamic> json) =>
      ListeMenusCommande(
        identifiant: json["Identifiant"],
        linkedCommande: json["linkedCommande"],
        linkedMenu: List<LinkedMenu>.from(
            json["linkedMenu"].map((x) => LinkedMenu.fromJson(x))),
        tailles: List<ListeMenusCommandeTaille>.from(
            json["tailles"].map((x) => ListeMenusCommandeTaille.fromJson(x))),
        sauces: List<ListeMenusCommandeBoison>.from(
            json["sauces"].map((x) => ListeMenusCommandeBoison.fromJson(x))),
        viandes: List<dynamic>.from(json["viandes"].map((x) => x)),
        garnitures: List<ListeMenusCommandeBoison>.from(json["garnitures"]
            .map((x) => ListeMenusCommandeBoison.fromJson(x))),
        boisons: List<ListeMenusCommandeBoison>.from(
            json["boisons"].map((x) => ListeMenusCommandeBoison.fromJson(x))),
        autres: List<dynamic>.from(json["autres"].map((x) => x)),
        quantite: json["quantite"],
        prixHt: json["prixHT"],
        prixTtc: json["prixTTC"].toDouble(),
        remise: json["remise"],
        statut: json["statut"],
        description: json["description"],
        dateCreation: DateTime.parse(json["dateCreation"]),
        dateLastModif: DateTime.parse(json["dateLastModif"]),
        logoResto: json["logoResto"],
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "linkedCommande": linkedCommande,
        "linkedMenu": List<dynamic>.from(linkedMenu!.map((x) => x.toJson())),
        "tailles": List<dynamic>.from(tailles!.map((x) => x.toJson())),
        "sauces": List<dynamic>.from(sauces!.map((x) => x.toJson())),
        "viandes": List<dynamic>.from(viandes!.map((x) => x)),
        "garnitures": List<dynamic>.from(garnitures!.map((x) => x.toJson())),
        "boisons": List<dynamic>.from(boisons!.map((x) => x.toJson())),
        "autres": List<dynamic>.from(autres!.map((x) => x)),
        "quantite": quantite,
        "prixHT": prixHt,
        "prixTTC": prixTtc,
        "remise": remise,
        "statut": statut,
        "description": description,
        "dateCreation": dateCreation!.toIso8601String(),
        "dateLastModif": dateLastModif!.toIso8601String(),
        "logoResto": logoResto,
      };
}

class ListeMenusCommandeBoison {
  ListeMenusCommandeBoison({
    this.qte,
    this.prixFacculatitf,
    this.id,
    this.name,
  });

  int? qte;
  int? prixFacculatitf;
  String? id;
  String? name;

  factory ListeMenusCommandeBoison.fromJson(Map<String, dynamic> json) =>
      ListeMenusCommandeBoison(
        qte: json["qte"],
        prixFacculatitf: json["prixFacculatitf"],
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "qte": qte,
        "prixFacculatitf": prixFacculatitf,
        "id": id,
        "name": name,
      };
}

class LinkedMenu {
  LinkedMenu({
    this.identifiant,
    this.titre,
    this.description,
    this.statut,
    this.linkedRestaurant,
    this.prix,
    this.image,
    this.tags,
    this.tailles,
    this.sauces,
    this.viandes,
    this.garnitures,
    this.boisons,
    this.autres,
    this.categorie,
  });

  String? identifiant;
  String? titre;
  String? description;
  String? statut;
  String? linkedRestaurant;
  double? prix;
  String? image;
  List<dynamic>? tags;
  List<LinkedMenuTaille>? tailles;
  List<ViandeElement>? sauces;
  List<ViandeElement>? viandes;
  List<ViandeElement>? garnitures;
  List<ViandeElement>? boisons;
  List<dynamic>? autres;
  List<String>? categorie;

  factory LinkedMenu.fromJson(Map<String, dynamic> json) => LinkedMenu(
        identifiant: json["Identifiant"],
        titre: json["titre"],
        description: json["description"],
        statut: json["statut"],
        linkedRestaurant: json["linkedRestaurant"],
        prix: json["prix"].toDouble(),
        image: json["image"],
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        tailles: List<LinkedMenuTaille>.from(
            json["tailles"].map((x) => LinkedMenuTaille.fromJson(x))),
        sauces: List<ViandeElement>.from(
            json["sauces"].map((x) => ViandeElement.fromJson(x))),
        viandes: List<ViandeElement>.from(
            json["viandes"].map((x) => ViandeElement.fromJson(x))),
        garnitures: List<ViandeElement>.from(
            json["garnitures"].map((x) => ViandeElement.fromJson(x))),
        boisons: List<ViandeElement>.from(
            json["boisons"].map((x) => ViandeElement.fromJson(x))),
        autres: List<dynamic>.from(json["autres"].map((x) => x)),
        categorie: List<String>.from(json["categorie"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "titre": titre,
        "description": description,
        "statut": statut,
        "linkedRestaurant": linkedRestaurant,
        "prix": prix,
        "image": image,
        "tags": List<dynamic>.from(tags!.map((x) => x)),
        "tailles": List<dynamic>.from(tailles!.map((x) => x.toJson())),
        "sauces": List<dynamic>.from(sauces!.map((x) => x.toJson())),
        "viandes": List<dynamic>.from(viandes!.map((x) => x.toJson())),
        "garnitures": List<dynamic>.from(garnitures!.map((x) => x.toJson())),
        "boisons": List<dynamic>.from(boisons!.map((x) => x.toJson())),
        "autres": List<dynamic>.from(autres!.map((x) => x)),
        "categorie": List<dynamic>.from(categorie!.map((x) => x)),
      };
}

class ViandeElement {
  ViandeElement({
    this.qteMax,
    this.qteMin,
    this.produits,
  });

  int? qteMax;
  int? qteMin;
  List<Produit>? produits;

  factory ViandeElement.fromJson(Map<String, dynamic> json) => ViandeElement(
        qteMax: json["qteMax"],
        qteMin: json["qteMin"],
        produits: List<Produit>.from(
            json["produits"].map((x) => Produit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "qteMax": qteMax,
        "qteMin": qteMin,
        "produits": List<dynamic>.from(produits!.map((x) => x.toJson())),
      };
}

class Produit {
  Produit({
    this.id,
    this.prixFacculatitf,
  });

  String? id;
  int? prixFacculatitf;

  factory Produit.fromJson(Map<String, dynamic> json) => Produit(
        id: json["id"],
        prixFacculatitf: json["prixFacculatitf"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "prixFacculatitf": prixFacculatitf,
      };
}

class LinkedMenuTaille {
  LinkedMenuTaille({
    this.id,
    this.prix,
  });

  String? id;
  int? prix;

  factory LinkedMenuTaille.fromJson(Map<String, dynamic> json) =>
      LinkedMenuTaille(
        id: json["id"],
        prix: json["prix"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "prix": prix,
      };
}

class ListeMenusCommandeTaille {
  ListeMenusCommandeTaille({
    this.id,
    this.prix,
    this.name,
  });

  String? id;
  int? prix;
  String? name;

  factory ListeMenusCommandeTaille.fromJson(Map<String, dynamic> json) =>
      ListeMenusCommandeTaille(
        id: json["id"],
        prix: json["prix"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "prix": prix,
        "name": name,
      };
}

class MyStation {
  MyStation({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory MyStation.fromJson(Map<String, dynamic> json) => MyStation(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
