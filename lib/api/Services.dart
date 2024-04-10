import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

import '../local/sqflite_services.dart';

class Services{
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  Future<bool> loginScanner(String name, String password) async{
    final response = await http.post(Uri.parse('$baseUrl/connexion'),
    body: {
      'name' : name,
      'password' : password
    });
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }
  Future<bool> validerEtudiant(String matricule) async {
    final response = await http.post(
      Uri.parse('$baseUrl/etudiant/code'),
      body: {
        'matricule' : matricule
      }
    );

    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }
  Future<bool> validerProfesseur(String matricule)async {
    final response = await http.post(
      Uri.parse('$baseUrl/prof/code'),
      body: {
        'matricule' : matricule
      }
    );

    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

  Future<String> verification(String matricule, String type) async{
    final response = await http.post(
        Uri.parse('$baseUrl/$type/presence'),
        body: {
          'matricule' : matricule
        }
    );

    if(response.statusCode == 200){
      Map<String, dynamic> responseData = jsonDecode(response.body);
      final String nom = responseData['nom'];
      return nom;
    }else{
      return '';
    }
  }

}