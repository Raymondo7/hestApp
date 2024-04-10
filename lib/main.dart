import 'package:appli_hest/pages/home_page.dart';
import 'package:appli_hest/pages/status_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(
      DevicePreview(builder: (context) => const MyApp(),
        enabled: kDebugMode,
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StatusPage(),
    );
  }
}
