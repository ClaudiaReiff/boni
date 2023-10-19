import 'dart:convert';
import 'dart:io';
import 'package:boni/trail/model/checkpoint.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:boni/api/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<StatefulWidget> createState() => _QRScanState();
}

class _QRScanState extends State<QRScanner> {
  final qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? controller;
  Barcode? barcode;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      _checkTrail(scanData.code ?? "");
    });
  }

  void _checkTrail(String data) async {
    if (data.isNotEmpty) {
      List<String> parts = data.split('#');

      Checkpoint checkpoint = Checkpoint(0, int.parse(parts[0]),
          double.parse(parts[1]), double.parse(parts[2]), DateTime.now());

      try {
        var response =
            await http.post(Uri.parse(API.checkIn), body: checkpoint.toJson());
        if (response.statusCode == 200) {
          var resBody = jsonDecode(response.body);
          if (resBody['success']) {
            Fluttertoast.showToast(msg: "Checked-in successfully.");
          } else {
            Fluttertoast.showToast(msg: "Error occured. Please try again.");
          }
        }
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) => SafeArea(
          child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            buildQrView(context),
            const Positioned(
                bottom: 10,
                child: Text(
                  'Scan a code',
                  maxLines: 3,
                ))
          ],
        ),
      ));

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderColor: Colors.blue,
            borderRadius: 10,
            borderLength: 20,
            borderWidth: 10,
            cutOutSize: MediaQuery.of(context).size.width * 0.8),
      );
}
