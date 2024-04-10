import 'dart:developer';
import 'dart:io';

import 'package:appli_hest/api/Services.dart';
import 'package:appli_hest/constants.dart';
import 'package:appli_hest/pages/accueil_admin.dart';
import 'package:fk_toggle/fk_toggle.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<StatefulWidget> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String type = 'etudiant';

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    if(result!= null) {

      Future.delayed(const Duration(microseconds: 0),() async{
        await controller?.pauseCamera();
      });
      print(result!.code);
      Future.delayed(const Duration(seconds: 1),() {
        loading(context, "Verification...");
      });
      Future.delayed(const Duration(seconds: 3),() async{
        final String response = await Services().verification(result!.code.toString(), type);
          Navigator.pop(context);
          showDialog(
            barrierDismissible: false,
            barrierColor: Colors.black.withOpacity(0.5),
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: secColor,
              elevation: 20.0,
              content: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //TODO:: package
                    FaIcon(response != '' ? FontAwesomeIcons.check : FontAwesomeIcons.ban, size: 75, color: response != '' ? Colors.green : Colors.red,),
                    Text(
                      response != '' ? response : 'Aucune correspondance !',
                      textAlign: TextAlign.center,
                      style: stylish(25, primColor, isBold: true),
                    ),
                    TextButton(
                        onPressed: (){
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const ScannerPage()), (route) => false);
                        },
                        child: Text('OK',style: stylish(25, primColor, isBold: true)))
                  ],
                ),
              ),
            ),
          );
        });
    }else{
      Future.delayed(const Duration(seconds: 15), () async{
        await controller?.pauseCamera();
      });
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primColor,
        centerTitle: true,
        title: Text('Scanner', style: stylish(25, secColor,isBold: true),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: secColor,
          onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const AccueilAdmin()), (route) => false);
          },
        ),
      ),
      body: InkWell(
        onTap: () async{
          await controller?.resumeCamera();
        },
        child: Column(
          children: <Widget>[
            Expanded(flex: 4,child: _buildQrView(context)),
            Expanded(child: Center(
              child: FkToggle(
                  width: 120,
                  height: 50,
                  labels: const ['Etudiant', 'Professeur'],
                  selectedColor: primColor,
                  backgroundColor: Colors.grey,
                  onSelected: (idx, instance) {
                    if(idx==0){
                      setState(() {
                        type = 'etudiant';
                      });
                    }else{
                      setState(() {
                        type = 'prof';
                      });
                    }
                  },
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}