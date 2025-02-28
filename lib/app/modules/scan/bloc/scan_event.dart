part of 'scan_bloc.dart';

abstract class ScanEvent extends Equatable {
  const ScanEvent();

  @override
  List<Object> get props => [];
}

class ScanBarcodeEvent extends ScanEvent {
  final Barcode barcode;
  const ScanBarcodeEvent(this.barcode);
}
