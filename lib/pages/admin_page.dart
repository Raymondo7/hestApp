import 'package:appli_hest/api/Services.dart';
import 'package:appli_hest/local/sqflite_services.dart';
import 'package:appli_hest/pages/accueil_admin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController identifiantController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool restOn = false;
  bool visible = false;

  @override
  void dispose() {
    super.dispose();
    identifiantController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primColor,
        leading: BackButton(
          color: secColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              width: screenWidth(context),
              height: screenHeight(context),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const FaIcon(FontAwesomeIcons.lock, size: 100,color: primColor,),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Se Connecter',
                          style: stylish(25, primColor, isBold: true),
                        ),
                      ),
                      Text(
                        'Veuillez sélectionnez votre status pour continuer :',
                        style: stylish(18, primColor),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: identifiantController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Saisissez l'identifiant !";
                          }
                          return null;
                        },
                        style: stylish(20, primColor),
                        decoration: InputDecoration(
                          hintText: 'Identifiant d\'administrateur...',
                          hintStyle: stylish(18, primColor),
                          errorStyle: stylish(18, Colors.red),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: primColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: primColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: primColor, width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Saisissez votre mot de passe !";
                          }
                          return null;
                        },
                        style: stylish(20, primColor),
                        obscureText: visible,
                        decoration: InputDecoration(
                          hintText: 'Mot de passe d\'administrateur...',
                          hintStyle: stylish(18, primColor),
                          errorStyle: stylish(18, Colors.red),
                          isDense: true,
                          suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                visible = !visible;
                              });
                            },
                            icon: const Icon(
                              CupertinoIcons.eye_slash,
                              color: primColor,
                              size: 18,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: primColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: primColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: primColor, width: 2),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: CheckboxListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 0),
                          dense: true,
                          controlAffinity: ListTileControlAffinity
                              .leading, // Case à gauche
                          value: restOn,
                          checkColor: primColor,
                          fillColor: MaterialStateProperty.resolveWith(
                              (states) => secColor),
                          title: Text(
                            'Rester connecté sur cet appareil ',
                            style: stylish(18, primColor),
                          ),
                          onChanged: (value) {
                            setState(() {
                              restOn = !restOn;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: SizedBox(
                          width: screenWidth(context),
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () async{
                              if (_formKey.currentState != null &&
                                  _formKey.currentState!.validate()) {
                                loading(context, 'Authentification...');
                                  final bool response = await Services().loginScanner(identifiantController.text.trim(), passwordController.text.trim());
                                identifiantController.text = '';
                                passwordController.text = '';
                                Future.delayed(const Duration(seconds: 2),() {
                                  if(response){
                                    if(restOn){
                                      DatabaseHelper().updateStatus('Admin', 'null');
                                    }
                                    Navigator.pop(context);
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AccueilAdmin()));
                                  }else{
                                    Navigator.pop(context);
                                    // Afficher une notification ou un toast pour indiquer que le texte a été copié
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      elevation: 15.0,
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 5),
                                      content: Text(
                                        'Identifiant / Mot de passe incorrect(s) !',
                                        style: TextStyle(color:secColor),
                                      ),
                                    ));
                                  }
                                });

                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primColor,
                              padding: const EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Valider',
                              style: stylish(25, secColor, isBold: true),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
