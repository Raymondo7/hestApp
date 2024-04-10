import 'package:appli_hest/local/sqflite_services.dart';
import 'package:appli_hest/pages/login_student.dart';
import 'package:appli_hest/pages/qr_code_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../api/Services.dart';
import '../constants.dart';
import 'home_page.dart';

class ValidationPage extends StatefulWidget {
  ValidationPage(
      {super.key,
      required this.status,
      required this.nouveau,
      this.identifiant});
  String status;
  bool nouveau;
  String? identifiant;

  @override
  State<ValidationPage> createState() => _ValidationPageState();
}

class _ValidationPageState extends State<ValidationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nomController = TextEditingController();
  final TextEditingController matriculeController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  bool nomSaisi = false;

  Services services = Services();

  void _copyTextToClipboard(BuildContext context) {
    String text = idController.text;

    // Copier le texte dans le presse-papier
    Clipboard.setData(ClipboardData(text: text));

    // Afficher une notification ou un toast pour indiquer que le texte a été copié
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      elevation: 15.0,
      backgroundColor: Colors.amber,
      duration: Duration(seconds: 3),
      content: Text(
        'Identifiant copié dans le presse-papier',
        style: TextStyle(color: secColor),
      ),
    ));
  }

  @override
  void dispose() {
    nomController.dispose();
    matriculeController.dispose();
    idController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    idController.text = widget.identifiant ?? 'null';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Votre code ici sera exécuté après que la page ait été construite
      // et que le premier build ait été effectué
      if (widget.nouveau) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Voici votre identifiant',
                style: TextStyle(
                    fontSize: 20,
                    color: primColor,
                    fontWeight: FontWeight.bold)),
            content: IntrinsicHeight(
              child: Column(
                children: [
                  TextFormField(
                    controller: idController,
                    enabled: false,
                    style: stylish(18, Colors.black),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.grey,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal:
                              5), // Ajustez la valeur de la marge interne ici
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Patientez le temps que vos informations soit vérifiées au niveau de l\'administration',
                    style: stylish(15, Colors.amber),
                  )
                ],
              ),
            ),
            actions: [
              Card(
                elevation: 10.0,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Ferme la boîte de dialogue
                    _copyTextToClipboard(context);
                  },
                  child: const Text('Copier et quiter',
                      style: TextStyle(
                          fontSize: 20,
                          color: primColor,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primColor,
        centerTitle: true,
        title: Text(
          widget.status,
          style: stylish(25, secColor, isBold: true),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: secColor,
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false);
          },
        ),
        actions: [
          widget.status == 'Etudiant'
              ? IconButton(
                  icon: const FaIcon(FontAwesomeIcons.plus),
                  color: secColor,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginStudent()));
                  },
                )
              : Container()
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              //height: screenHeight(context),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Validation',
                      style: stylish(25, primColor, isBold: true),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: nomController,
                      onChanged: (value) {
                        setState(() {
                          nomSaisi = value.isNotEmpty;
                        });
                      },
                      style: stylish(20, primColor),
                      decoration: InputDecoration(
                        hintText: 'Nom (Optionel)...',
                        hintStyle: stylish(18, primColor),
                        errorStyle: stylish(18, Colors.red),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: primColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: primColor, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: matriculeController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Saisissez votre identifiant unique !";
                        }
                        return null;
                      },
                      style: stylish(20, primColor),
                      decoration: InputDecoration(
                        hintText: 'Identifiant Unique...',
                        hintStyle: stylish(18, primColor),
                        errorStyle: stylish(18, Colors.red),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: primColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: primColor, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: screenWidth(context),
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate()) {
                            loading(context, "Patientez...");
                            final bool response = widget.status == "Etudiant"
                                ? await services.validerEtudiant(
                                    matriculeController.text.trim())
                                : await services.validerProfesseur(
                                    matriculeController.text.trim());

                            if (response) {
                              DatabaseHelper().updateStatus(widget.status, matriculeController.text.trim());
                              Future.delayed(const Duration(seconds: 3), () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => QRCodePage(
                                              status: widget.status, code: matriculeController.text.trim(),
                                            )));
                              });
                            } else {
                              Future.delayed(const Duration(seconds: 3), () {
                                Navigator.pop(context);
                                // Afficher une notification ou un toast pour indiquer que le texte a été copié
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  elevation: 15.0,
                                  backgroundColor: Colors.amber,
                                  duration: Duration(seconds: 3),
                                  content: Text(
                                    'Votre matricule ne correspond à aucune donnée',
                                    style: TextStyle(color: secColor),
                                  ),
                                ));
                              });
                            }
                            nomController.text = '';
                            matriculeController.text = '';
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
        ],
      ),
    );
  }
}
