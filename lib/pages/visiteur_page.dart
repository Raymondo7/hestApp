import 'package:appli_hest/local/sqflite_services.dart';
import 'package:appli_hest/pages/accueil_admin.dart';
import 'package:appli_hest/pages/ajouter_visiteur.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../api/VisiteurServices.dart';
import '../constants.dart';

class VisiteurPage extends StatefulWidget {
  const VisiteurPage({super.key});

  @override
  State<VisiteurPage> createState() => _VisiteurPageState();
}


class _VisiteurPageState extends State<VisiteurPage> {
  DatabaseHelper dbHelper = DatabaseHelper();

  //Suppression
  void supprimer(BuildContext context, Visiteur visiteur) {
    VisiteurServices visiteurServices = VisiteurServices();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Voulez-vous vraiment supprimer ?',
            style: stylish(25, primColor, isBold: true)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Ferme la boîte de dialogue
            },
            child: Text('Annuler',
                style: stylish(20, primColor, isBold: true)),
          ),
          TextButton(
            onPressed: () async{
              loading(context, 'Suppression en cours');
              await visiteurServices.departVisiteur(visiteur);
              setState(() {

              });
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.pop(context);
                Navigator.pop(context);
              });
            },
            child: Text('Confirmer',
                style: stylish(20, Colors.red, isBold: true)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      
    });
    return Scaffold(
        appBar: AppBar(
        backgroundColor: primColor,
        centerTitle: true,
        title: Text('Visiteurs', style: stylish(25, secColor,isBold: true),),
    leading: IconButton(
      icon: const FaIcon(FontAwesomeIcons.arrowLeft),
      color: secColor,
      onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AccueilAdmin()));
      },
    ),
          actions: [
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.plus),
              color: secColor,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AjouterVisiteur()));
              },
            ),
          ],
    ),
      body: FutureBuilder<List<Visiteur>>(
        future: dbHelper.fetchVisiteurs(), // Future qui renvoie la liste de visiteurs
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Pendant que les données sont en cours de chargement
            return const Center(child: CircularProgressIndicator()); // Vous pouvez utiliser un indicateur de chargement
          } else if (snapshot.hasError) {
            // Si une erreur s'est produite pendant le chargement des données
            print('lerreur : ${snapshot.error}');
            return Text('Erreur: ${snapshot.error}');
          } else{
            // Si les données ont été chargées avec succès
            final visiteurs = snapshot.data!; // Liste des visiteurs récupérée

            if(visiteurs.isEmpty){
              return Center(child: Text('Liste de visiteurs vide !',style: stylish(20, Colors.black),));
            }else{
              return ListView.builder(
                itemCount: visiteurs.length,
                itemBuilder: (context, index) {
                  final visiteur = visiteurs[index];
                  return ListTile(
                    tileColor: (index+1)%2 == 1 ? Colors.blueGrey[100] : Colors.white,
                    leading: Text((index + 1).toString(), style: TextStyle(fontSize: 15, color: Colors.black)),
                    title: Text(visiteur.nom, style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
                    subtitle: Text(visiteur.numero.toString(), style: TextStyle(fontSize: 18, color: Colors.black)),
                    trailing: Card(
                      margin: EdgeInsets.zero,
                      shape: const CircleBorder(),
                      color: Colors.red,
                      child: IconButton(
                        icon: const FaIcon(
                          FontAwesomeIcons.xmark,
                          color: secColor,
                          size: 20,
                        ),
                        onPressed: () {
                            supprimer(context, visiteur);
                        },
                      ),
                    ),
                  );
                },
              );
            }
            // Construire la liste de ListTile à partir de la liste des visiteurs

          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: secColor,
        backgroundColor: primColor,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AjouterVisiteur()));
        },
        elevation: 15.0,
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }
}
