import 'dart:async';

import 'package:custom_dialog/custom_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mongo_flutter/dbHelper/mongodb.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'dart:io' show Platform;

import '../extenstion.dart';
import '../mongo_model.dart';
import 'resulta_page.dart';
import 'scanner_widget.dart';

List<MongoDbModel> data = [];

class QRScanner extends StatefulWidget {
  const QRScanner({Key? key}) : super(key: key);

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool _animationStopped = true;
  bool flach = false;
  String scanText = "Scan";
  bool scanning = true;
  final qrkey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;

  @override
  void dispose() {
    controller?.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Future<void> reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    } else if (Platform.isIOS) {
      await controller!.resumeCamera();
    }
  }

  @override
  void initState() {
    _animationController = new AnimationController(
        duration: new Duration(seconds: 1), vsync: this);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animateScanAnimation(true);
      } else if (status == AnimationStatus.dismissed) {
        animateScanAnimation(false);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      animateScanAnimation(false);
    });
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor.fromHex("#FFFFFF"),
            actions: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.qr_code_sharp,
                            color: HexColor.fromHex("#09B5F0"),
                            size: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Capturer",
                            style:
                                TextStyle(color: HexColor.fromHex("#04526D")),
                          )
                        ],
                      ),
                      Icon(
                        Icons.clear,
                        color: HexColor.fromHex("#09B5F0"),
                        size: 30,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.black,
          body: Stack(
            alignment: Alignment.center,
            children: [
              QRView(
                overlayMargin: EdgeInsets.zero,
                key: qrkey,
                onQRViewCreated: onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderWidth: 2.5,
                  cutOutBottomOffset: 0,
                  borderColor: Theme.of(context).accentColor,
                  //borderRadius: 10,
                  borderLength: 100,
                  cutOutSize: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
              ScannerAnimation(
                false,
                MediaQuery.of(context).size.width * 0.8,
                animation: _animationController as Animation<double>,
              ),
              GetBuilder<HomeController>(
                builder: (controller) => Positioned(
                  bottom: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () async {
                            setState(() {
                              flach = !flach;
                            });

                            // await controller?.toggleFlash();
                          },
                          icon: Icon(
                            flach ? Icons.flash_auto : Icons.flash_off,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () async {
                            // await controller?.flipCamera();
                          },
                          icon: Icon(
                            Icons.switch_camera,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  void animateScanAnimation(bool reverse) {
    if (reverse) {
      _animationController.reverse(from: 1.0);
    } else {
      _animationController.forward(from: 0.0);
    }
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((barcode) => setState(() {
          this.barcode = barcode;
          if (this.barcode != null) {
            for (int i = 0; i < data.length; i++) {
              if (this.barcode!.code.toString() == data[i].firstName) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ResultaPage(
                    message: data[i],
                  );
                }));

                controller.dispose();
              }
            }
            //https://qrco.de/bcjZe2
            print(
                'is not exite bbbbbbbbbbbbbbbbbbbbbbbbbbbb ${this.barcode!.code.toString()}');
          }
        }));
  }
}

class HomeController extends GetxController {
  HomeController() {
    getData();
  }

  getData() async {
    var helpear = (await MongoDatabase.getData());
    for (int i = 0; i < helpear.length; i++) {
      data.add(MongoDbModel.fromJson(helpear[i]));
      print(data[i].lastname);
    }
  }
}
