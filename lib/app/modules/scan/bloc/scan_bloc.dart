import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:mobile_scanner/mobile_scanner.dart';

part 'scan_event.dart';
part 'scan_state.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {

  ScanBloc() : super(const ScanState()) {
    on<ScanBarcodeEvent>((event, emit) {
      emit(ScanState(barcode: event.barcode));
    });
  }
}
