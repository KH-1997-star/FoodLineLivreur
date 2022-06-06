import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:food_line_livreur/screens/command_list_screen.dart';
import 'package:food_line_livreur/services/station_repo.dart';
import 'package:food_line_livreur/utils/colors.dart';
import 'package:food_line_livreur/utils/consts.dart';
import 'package:food_line_livreur/utils/functions.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanScreen extends StatefulWidget {
  final String? idTrajet, idStation, title;
  const ScanScreen({Key? key, this.idTrajet, this.idStation, this.title})
      : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  StationNotifier stationNotifier = StationNotifier();

  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool? isScanned;
  scan(String id) async {
    var result = await stationNotifier.getSpeceficCommand(id);
    setState(() {
      isScanned = result['result'];
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Barcode? myBarCode;
  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
    print('disposed');
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CommandListScreen(
              idStation: widget.idStation,
              idTrajet: widget.idTrajet,
              title: widget.title,
            ),
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CommandListScreen(
                  idStation: widget.idStation,
                  idTrajet: widget.idTrajet,
                  title: widget.title,
                ),
              ),
            ),
            icon: const Icon(Icons.arrow_back),
          ),
          backgroundColor: Colors.black,
          title: const Text(
            'FoodLine',
            style: TextStyle(
              color: myGreen,
            ),
          ),
        ),
        body: Stack(
          children: [
            buildQrView(context),
          ],
        ),
      ),
    );
  }

  Widget buildQrView(context) => QRView(
        key: qrKey,
        onQRViewCreated: onQrViewCreated,
        overlay: QrScannerOverlayShape(
          cutOutSize: getWidth(context) * 0.8,
          borderWidth: 10,
          borderLength: 20,
          borderRadius: 10,
          borderColor: myGreen,
        ),
      );
  onQrViewCreated(QRViewController qrViewController) {
    setState(() {
      controller = qrViewController;
    });
    qrViewController.scannedDataStream.listen(
      (barCode) async {
        await controller?.stopCamera();
        myBarCode = barCode;
        var result =
            await stationNotifier.getSpeceficCommand(myBarCode?.code ?? '');

        isScanned = result['result'];
        isScanned!
            ? showDialog(
                barrierDismissible: false,
                context: context,
                builder: (
                  context,
                ) {
                  return AlertDialog(
                    title: Text('Commande n° ${result['numeroCommande']}'),
                    content: result['statut'] == 'delivered'
                        ? const Text('commande déjà livrée')
                        : Text(
                            result['statut'] == 'canceled'
                                ? 'cette commande a été annulé êtes-vous sûr de la valider'
                                : 'prix totale: ${result['ttc']}€',
                            textAlign: TextAlign.center,
                          ),
                    actions: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            myGreen,
                          ),
                        ),
                        onPressed: () async {
                          if (result['statut'] == 'delivered') {
                            await controller?.resumeCamera();
                            Navigator.pop(context);
                          } else {
                            showLoader(context);
                            bool r = await stationNotifier.traiterCommand(
                                myBarCode?.code ?? '', 'delivered');
                            hideLoader(context);
                            if (r == false) {
                              showToast(erreurUlterieur);
                            } else {
                              Navigator.pop(context);
                              await controller?.resumeCamera();
                              showToast(
                                  'commande n°${result['numeroCommande']} est valider avec succée');
                            }
                          }
                        },
                        child: result['statut'] != 'delivered'
                            ? Text(result['statut'] == 'canceled'
                                ? 'oui'
                                : 'valider')
                            : const Text('retour'),
                      ),
                      result['statut'] == 'delivered'
                          ? const SizedBox()
                          : ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  myblack,
                                ),
                              ),
                              onPressed: () async {
                                Navigator.pop(context);
                                await controller?.resumeCamera();
                              },
                              child: const Text('annuler'),
                            ),
                    ],
                  );
                })
            : showToast(result['message']);

        //print('haaaany nkhdeeem');
      },
    );
  }
}
