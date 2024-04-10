import 'package:appli_hest/api/EtudiantServices.dart';
import 'package:appli_hest/pages/home_page.dart';
import 'package:appli_hest/pages/qr_code_page.dart';
import 'package:appli_hest/pages/validation_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_bar_code/qr/src/mask_pattern.dart';
import '../constants.dart';

class LoginStudent extends StatefulWidget {
  const LoginStudent({super.key});

  @override
  State<LoginStudent> createState() => _LoginStudentState();
}

class _LoginStudentState extends State<LoginStudent> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nomController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  String selectedNiveau = '';
  String selectedDomaine = '';

  @override
  void dispose() {
    nomController.dispose();
    numeroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primColor,
        elevation: 0,
        centerTitle: true,
        title: Text('Etudiant', style: stylish(25, secColor,isBold: true),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: secColor,
          onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
          },
        ),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.arrowRightToBracket),
            color: secColor,
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ValidationPage(status: 'Etudiant',nouveau: false,)));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'S\'enrégistrer :',
                      style: stylish(25, primColor, isBold: true),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: nomController,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Saisissez votre nom complet !";
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
                          return "Saisissez votre numéro de téléphone !";
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
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: selectedNiveau,
              
                      onChanged: (value) {
                        setState(() {
                          selectedNiveau = value!;
                        });
                      },
                      validator: (value){
                        if(value == null || value == ''){
                          return "Sélectionnez votre parcours !";
                        }
                        return null;
                      },
                      style: stylish(18, primColor),
                      items: const [
                        DropdownMenuItem(
                          enabled: false,
                          value: '',
                          child: Text('Parcours'),
                        ),
                        DropdownMenuItem(
                          value: 'Licence',
                          child: Text('Licence'),
                        ),
                        DropdownMenuItem(
                          value: 'Master',
                          child: Text('Master'),
                        ),
                      ],
                      decoration: InputDecoration(
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
                    DropdownButtonFormField<String>(
                      value: selectedDomaine,
                      onChanged: (value) {
                        setState(() {
                          selectedDomaine = value!;
                        });
                      },
                      style: stylish(18, primColor),
                      validator: (value){
                        if(value == null || value == ''){
                          return "Sélectionnez votre domaine !";
                        }
                        return null;
                      },
                      items: const [
                        DropdownMenuItem(
                          value: '',
                          child: Text('Domaine'),
                        ),
                        DropdownMenuItem(
                          value: 'Commerce et Marketing',
                          child: Text('Commerce et Marketing'),
                        ),
                        DropdownMenuItem(
                          value: 'Communication',
                          child: Text('Communication'),
                        ),
                        DropdownMenuItem(
                          value: 'Droit et Management',
                          child: Text('Droit et Management'),
                        ),
                        DropdownMenuItem(
                          value: 'Informatique',
                          child: Text('Informatique'),
                        ),
                      ],
                      decoration: InputDecoration(
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
                    SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () async{
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate()) {
                            final String heure = DateTime.now().hour.toString();
                            final String minute = DateTime.now().minute.toString();
                            final String seconde = DateTime.now().second.toString();
                            final String mat = '${selectedNiveau.trim().substring(0,2)}${nomController.text.split(' ')[0].substring(0,3)}${numeroController.text.substring(0,2)}${nomController.text.split(' ')[1].substring(0,2)}$heure$minute${seconde}HEST'.toUpperCase();
                            Etudiant etudiant = Etudiant(nom: nomController.text.trim(), matricule: mat, numero: int.parse(numeroController.text.trim()), parcours: selectedNiveau, domaine: selectedDomaine);
                            setState(() {
                              nomController.text = '';
                              numeroController.text = '';
                              selectedNiveau = '';
                              selectedDomaine = '';
                            });
                            loading(context, "En Cours...");
                            final result = await EtudiantServices().inscription(etudiant);
                            Future.delayed(const Duration(seconds: 2),(){
                              //Navigator.pop(context);
                              if(result){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ValidationPage(status: 'Etudiant',nouveau: true,identifiant: mat,)));
                              }else{
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('L\'Enrégistrement a échoué, veuillez patienter un moment avant de reprendre ',
                                        style: stylish(25, primColor, isBold: true)),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context); // Ferme la boîte de dialogue
                                        },
                                        child: Text('Ok',
                                            style: stylish(20, primColor, isBold: true)),
                                      ),
                                    ],
                                  ),
                                );
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
