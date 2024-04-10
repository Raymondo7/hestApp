import 'package:appli_hest/constants.dart';
import 'package:appli_hest/pages/admin_page.dart';
import 'package:appli_hest/pages/validation_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'login_student.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: screenWidth(context),
        height: screenHeight(context),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                width: screenWidth(context),
                height: screenHeight(context)*0.25,
                decoration: const BoxDecoration(
                  color: primColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(70)
                  )
                ),
              ),
            ),
            Positioned(
              top: (screenHeight(context) * 0.28) / 2,
              right: 0,
              left: 0,
              child: Container(
                width: screenWidth(context),
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth(context) * 0.1),
                height: screenHeight(context) * 0.20,
                decoration: const BoxDecoration(
                  //borderRadius: BorderRadius.circular(35),
                ),
                child: Card(
                  elevation: 12.0,
                  child: Image.asset(
                    'images/hest.png',
                    width: screenWidth(context) * 0.4,
                  ),
                ),
              ),
            ),
            Positioned(
                top: (screenHeight(context)*0.3)/2 + screenHeight(context)*0.20,
                left: 0,
                right: 0,
                bottom: 0,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Vous êtes :', style: stylish(25, primColor, isBold: true),),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text('Veuillez sélectionnez votre status pour continuer :', style: stylish(18, primColor),textAlign: TextAlign.center,),
                      ),
                      SizedBox(
                        width: screenWidth(context)*0.9,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginStudent()));
                                },
                                child: Container(
                                  height: screenWidth(context)*0.45,
                                  //margin: const EdgeInsets.symmetric(horizontal: 5),
                                  width: screenWidth(context)*0.40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: primColor)
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const FaIcon(FontAwesomeIcons.userGraduate, color: primColor, size: 75,),
                                      Text('Etudiant', textAlign: TextAlign.center, style: stylish(20, primColor, isBold: true),)
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ValidationPage(status: 'Professeur',nouveau: false,)));
                                },
                                child: Container(
                                  height: screenWidth(context)*0.45,
                                  //margin: const EdgeInsets.symmetric(horizontal: 5),
                                  width: screenWidth(context)*0.40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: primColor)
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const FaIcon(FontAwesomeIcons.userTie, color: primColor, size: 75,),
                                      Text('Professeur', textAlign: TextAlign.center, style: stylish(20, primColor, isBold: true),)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth(context)*0.08),
                          child: Container(
                            height: screenWidth(context)*0.40,
                            margin: const EdgeInsets.all(5),
                            width: screenWidth(context),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: primColor)
                            ),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminLogin()));
                              },
                              child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Icon(Icons.document_scanner_sharp, color: primColor, size: 60,),
                                ),
                                Text('Admins', textAlign: TextAlign.center, style: stylish(20, primColor, isBold: true),),
                                Container(
                                  width: 75,
                                  height: screenHeight(context),
                                  decoration: const BoxDecoration(
                                    color: primColor,
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.lock_outline, color: secColor,size: 75,),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
