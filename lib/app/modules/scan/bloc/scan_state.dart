part of 'scan_bloc.dart';

class ScanState extends Equatable {
  final Barcode? barcode;

  const ScanState({
    this.barcode,
  });

  @override
  List<Object?> get props => [barcode];
}
