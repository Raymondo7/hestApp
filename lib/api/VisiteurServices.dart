import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

import '../local/sqflite_services.dart';

class VisiteurServices{
  static const String baseUrl = 'http://10.0.2.2:8000/api';
  final DatabaseHelper dbHelper = DatabaseHelper();

  Future<bool> arriveeVisiteur(Visiteur visiteur) async{
      final response = await http.post(
        Uri.parse('$baseUrl/ajouter-visiteur'),
        body: {
          'nom' : visiteur.nom,
          'numero' : visiteur.numero.toString(),
          'motif' : visiteur.motif,
          'arrivee' : visiteur.arrivee,
        }
      );
      if(response.statusCode == 200){
        Map<String, dynamic> responseData = jsonDecode(response.body);
        Visiteur generatedVisiteur = Visiteur(
            id: responseData['id'],
            nom: responseData['nom'],
            numero: int.parse(responseData['numero']),
          motif: responseData['motif'],
          arrivee: responseData['arrivee'],
          depart: responseData['depart'],
        );
        dbHelper.addVisiteur(generatedVisiteur);
        return true;
      }else{
        return false;
      }
  }
  Future<bool> departVisiteur(Visiteur visiteur) async{
      final response = await http.post(
        Uri.parse('$baseUrl/ajouter-visiteur'),
        body: {
          'nom' : visiteur.nom,
          'numero' : visiteur.numero.toString(),
          'motif' : visiteur.motif,
          'depart' : DateTime.now().toString(),
        }
      );
      if(response.statusCode == 200){
        await dbHelper.deleteVisiteur(int.parse(visiteur.id.toString()));
        return true;
      }else{
        return false;
      }
  }
}
class Visiteur{
  int? id;
  String nom;
  int numero;
  String motif;
  String? arrivee;
  String? depart;

  Visiteur({this.id, required this.nom, required this.numero, required this.motif, this.arrivee, this.depart});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'numero': numero,
      'motif': motif,
      'arrivee': arrivee,
      'depart': depart,
    };
  }
  factory Visiteur.fromMap(Map<String, dynamic> map) {
    return Visiteur(
      id: map['id'],
      nom: map['nom'],
      numero: map['numero'],
      motif: map['motif'],
      arrivee: map['arrivee'],
      depart: map['depart'],
    );
  }

}

class Status{
  int? id;
  String status;
  String code;

  Status({this.id, required this.status, required this.code});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status' : status,
      'code' : code,
    };
  }
  factory Status.fromMap(Map<String, dynamic> map) {
    return Status(
      id: map['id'],
     status: map['status'],
      code: map['code']
    );
  }
}