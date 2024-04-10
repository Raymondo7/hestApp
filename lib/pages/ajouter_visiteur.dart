import 'package:appli_hest/api/VisiteurServices.dart';
import 'package:appli_hest/pages/visiteur_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants.dart';

class AjouterVisiteur extends StatefulWidget {
  const AjouterVisiteur({super.key});

  @override
  State<AjouterVisiteur> createState() => _AjouterVisiteurState();
}

class _AjouterVisiteurState extends State<AjouterVisiteur> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nomController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController motifController = TextEditingController();

  @override
  void dispose() {
    nomController.dispose();
    numeroController.dispose();
    motifController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primColor,
        elevation: 0,
        centerTitle: true,
        title: Text('Nouveau Visiteur', style: stylish(25, secColor,isBold: true),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: secColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      const SizedBox(height: 20),
                      TextFormField(
                        controller: nomController,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Saisissez son nom complet !";
                          }
                          return null;
                        },
                        style: stylish(20, primColor),
                        decoration: InputDecoration(
                          hintText: 'Nom Complet...',
                          hintStyle: stylish(18, primColor),
                          errorStyle: stylish(18, Colors.red),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: primColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: primColor, width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: numeroController,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Saisissez son numéro de téléphone !";
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          PhoneNumberFormatter(),
                        ],
                        keyboardType: TextInputType.number,
                        style: stylish(20, primColor),
                        decoration: InputDecoration(
                          hintText: 'Numéro de téléphone...',
                          hintStyle: stylish(18, primColor),
                          errorStyle: stylish(18, Colors.red),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: primColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: primColor, width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: motifController,
                        minLines: 5,
                        maxLines: 5,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Saisissez le motif de la visite !";
                          }
                          return null;
                        },
                        style: stylish(20, primColor),
                        decoration: InputDecoration(
                          hintText: 'Motif de la visite...',
                          hintStyle: stylish(18, primColor),
                          errorStyle: stylish(18, Colors.red),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: primColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: primColor, width: 2),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: SizedBox(
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () async{
                              if (_formKey.currentState != null &&
                                  _formKey.currentState!.validate()) {
                                loading(context, "En Cours...");
                                Visiteur visiteur = Visiteur(nom: nomController.text.trim(), numero: int.parse(numeroController.text), motif: motifController.text.trim(), arrivee: DateTime.now().toString());
                                final bool response = await VisiteurServices().arriveeVisiteur(visiteur);
                                Future.delayed(const Duration(seconds: 2),(){
                                  Navigator.pop(context);
                                  if(response){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const VisiteurPage()));
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
