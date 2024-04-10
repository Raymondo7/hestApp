import 'dart:convert';
import 'package:device_preview/device_preview.dart';
import 'package:http/http.dart' as http;

class EtudiantServices{

  static const String baseUrl = 'http://10.0.2.2:8000/api';

  Future<bool> inscription(Etudiant etudiant) async{
    final response = await http.post(
      Uri.parse('$baseUrl/create'),
      body: {
        'matricule' : etudiant.matricule,
        'nom' : etudiant.nom,
        'numero' : etudiant.numero.toString(),
        'parcours' : etudiant.parcours,
        'domaine' : etudiant.domaine
      },
    );
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }
}

class Etudiant {
  int? id;
  String matricule;
  String nom;
  int numero;
  String parcours;
  String domaine;

  Etudiant({
    this.id,
    required this.matricule,
    required this.nom,
    required this.numero,
    required this.parcours,
    required this.domaine,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'matricule': matricule,
      'nom': nom,
      'numero': numero,
      'parcours': parcours,
      'domaine': domaine
    };
  }

  factory Etudiant.fromJson(Map<String, dynamic> json) {
    return Etudiant(
      id: json['id'],
      matricule: json['matricule'],
      nom: json['nom'],
      numero: json['numero'], // Convertir en String
      parcours: json['parcours'],
      domaine: json['domaine'].toString(),
    );
  }
}
