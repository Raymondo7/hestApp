import 'package:appli_hest/pages/home_page.dart';
import 'package:appli_hest/pages/scanner_page.dart';
import 'package:appli_hest/pages/visiteur_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';
import '../local/sqflite_services.dart';

class AccueilAdmin extends StatelessWidget {
  const AccueilAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primColor,
        centerTitle: true,
        title: Text('Accueil', style: stylish(25, secColor,isBold: true),),
        leading: Container(),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.rightFromBracket),
            color: secColor,
            onPressed: () {
              DatabaseHelper().updateStatus('null', 'null');
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage()),(route) => false,);
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: screenWidth(context),
            height: screenWidth(context)*0.5,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: const CircleBorder()
              ),
                onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ScannerPage()));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Scanner', style: stylish(25, secColor, isBold: true),),
                    const FaIcon(FontAwesomeIcons.print, size: 40,color: secColor,)
                  ],
                )),
          ),
          const SizedBox(height: 50,),
          SizedBox(
            width: screenWidth(context),
            height: screenWidth(context)*0.5,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primColor,
                    shape: const CircleBorder()
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const VisiteurPage()));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Visiteur', style: stylish(25, secColor, isBold: true),),
                    const FaIcon(FontAwesomeIcons.personWalking, size: 40,color: secColor,)
                  ],
                )),
          )
        ],
      ),
    );
  }
}
