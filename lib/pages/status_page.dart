import 'package:appli_hest/local/sqflite_services.dart';
import 'package:appli_hest/pages/accueil_admin.dart';
import 'package:appli_hest/pages/home_page.dart';
import 'package:appli_hest/pages/qr_code_page.dart';
import 'package:flutter/material.dart';

import '../api/VisiteurServices.dart';
import '../constants.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Status?>(
      future: DatabaseHelper().getStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.hasError ||
            snapshot.data!.toMap().isEmpty) {
          return const HomePage();
        } else {
          if (snapshot.data!.status == 'Professeur' ||
              snapshot.data!.status == 'Etudiant') {
            return QRCodePage(
              status: snapshot.data!.status,
              code: snapshot.data!.code,
            );
          } else if (snapshot.data!.status == 'Admin') {
            return const AccueilAdmin();
          }
        }
        return const HomePage();
      },
    );
  }
}
