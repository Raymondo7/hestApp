import 'package:flutter/material.dart';
import 'package:qr_bar_code/qr/qr.dart';

import '../constants.dart';
import 'home_page.dart';

class QRCodePage extends StatefulWidget {
  QRCodePage({super.key, required this.status, required this.code});
  String status;
  String code;

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primColor,
        centerTitle: true,
        title: Text('Mon Code', style: stylish(25, secColor,isBold: true),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: secColor,
          onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
          },
        ),
      ),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: QRCode(
                  data: widget.code,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}