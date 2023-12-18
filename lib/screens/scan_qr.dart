import 'package:festum_app/screens/event_attend.dart';
import 'package:festum_app/screens/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:whip_smart/screen/found_code_screen.dart';
import 'package:festum_app/qr_overlay.dart';


class ScanQR extends StatefulWidget {
  final int type;
  const ScanQR({Key? key, required this.type}) : super(key: key);

  @override
  _ScanQRState createState() =>
      _ScanQRState();
}

class _ScanQRState
    extends State<ScanQR>
    with SingleTickerProviderStateMixin {
  BarcodeCapture? barcodeCapture;

  final MobileScannerController controller = MobileScannerController(
    torchEnabled: false,
    formats: [BarcodeFormat.qrCode ,BarcodeFormat.code128],
    // facing: CameraFacing.front,
    // detectionSpeed: DetectionSpeed.normal
    detectionTimeoutMs: 1000,
    // returnImage: false,
  );

  bool isStarted = true;

  void _startOrStop() {
    try {
      if (isStarted) {
        controller.stop();
      } else {
        controller.start();
      }
      setState(() {
        isStarted = !isStarted;
      });
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Something went wrong! $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Festum"),
      ),
      backgroundColor: Colors.black,
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              MobileScanner(
                controller: controller,
                errorBuilder: (context, error, child) {
                  return Text("Error");
                },
                fit: BoxFit.contain,
                onDetect: (barcodeCapture) {
                  setState(() {
                    this.barcodeCapture = barcodeCapture;
                  });
                  if(widget.type == 1){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext builder)=> InfoScreen(id: (barcodeCapture.barcodes[0].rawValue.toString()))));

                  }
                  else if(widget.type == 2){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext builder)=> EventAttend(id: (barcodeCapture.barcodes[0].rawValue.toString()))));

                  }
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext builder)=> FoundCodeScreen(value: (barcodeCapture.barcodes[0].rawValue.toString()))));
                  //  Navigator.popAndPushNamed(context, "/CartPage");
                },
                onScannerStarted: (arguments) {
                  // Do something with arguments.
                },
              ),

              QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)),

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  alignment: Alignment.bottomCenter,
                  height: 100,
                  color: Colors.black.withOpacity(0.4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        color: Colors.white,
                        icon: ValueListenableBuilder(
                          valueListenable: controller.torchState,
                          builder: (context, state, child) {
                            if (state == null) {
                              return const Icon(
                                Icons.flash_off,
                                color: Colors.grey,
                              );
                            }
                            switch (state as TorchState) {
                              case TorchState.off:
                                return const Icon(
                                  Icons.flash_off,
                                  color: Colors.grey,
                                );
                              case TorchState.on:
                                return const Icon(
                                  Icons.flash_on,
                                  color: Colors.yellow,
                                );
                            }
                          },
                        ),
                        iconSize: 32.0,
                        onPressed: () => controller.toggleTorch(),
                      ),
                      IconButton(
                        color: Colors.white,
                        icon: isStarted
                            ? const Icon(Icons.stop)
                            : const Icon(Icons.play_arrow),
                        iconSize: 32.0,
                        onPressed: _startOrStop,
                      ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 200,
                          height: 50,
                          child: FittedBox(
                            child: Text(
                              '${barcodeCapture?.barcodes.map((e) => e.rawValue) ?? 'Scan QR Code!'}',
                              overflow: TextOverflow.fade,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        color: Colors.white,
                        icon: ValueListenableBuilder(
                          valueListenable: controller.cameraFacingState,
                          builder: (context, state, child) {
                            if (state == null) {
                              return const Icon(Icons.camera_front);
                            }
                            switch (state as CameraFacing) {
                              case CameraFacing.front:
                                return const Icon(Icons.camera_front);
                              case CameraFacing.back:
                                return const Icon(Icons.camera_rear);
                            }
                          },
                        ),
                        iconSize: 32.0,
                        onPressed: () => controller.switchCamera(),
                      ),
                      IconButton(
                        color: Colors.white,
                        icon: const Icon(Icons.image),
                        iconSize: 32.0,
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
                          // Pick an image
                          final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery,
                          );
                          if (image != null) {
                            if (await controller.analyzeImage(image.path)) {
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Barcode found!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } else {
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('No barcode found!'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}