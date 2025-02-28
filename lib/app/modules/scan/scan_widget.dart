import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'bloc/scan_bloc.dart';

class ScanWidget extends StatefulWidget {
  const ScanWidget({super.key});
  static String route = '/';

  @override
  State<ScanWidget> createState() => _ScanWidgetState();
}

class _ScanWidgetState extends State<ScanWidget> with WidgetsBindingObserver {
  final MobileScannerController controller = MobileScannerController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    unawaited(controller.start());
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    await controller.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!controller.value.hasCameraPermission) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        unawaited(controller.start());
      case AppLifecycleState.inactive:
        unawaited(controller.stop());
    }
  }

  @override
  Widget build(BuildContext context) {
    final scanBloc = Modular.get<ScanBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
        leading: IconButton(
          onPressed: () => Modular.to.pop(),
          icon: const Icon(Icons.close),
        ),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            onDetect: (value) =>
                scanBloc.add(ScanBarcodeEvent(value.barcodes.first)),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 100,
              color: const Color.fromRGBO(0, 0, 0, 0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Center(
                      child: BlocBuilder<ScanBloc, ScanState>(
                        bloc: scanBloc,
                        builder: (context, state) {
                          if (state.barcode == null) {
                            return const Text(
                              'Scan something!',
                              overflow: TextOverflow.fade,
                              style: TextStyle(color: Colors.white),
                            );
                          }

                          return Text(
                            state.barcode!.displayValue ?? 'No display value.',
                            overflow: TextOverflow.fade,
                            style: const TextStyle(color: Colors.white),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
