import 'package:spin_flow/dto/dto.dart';

class DTOSala extends DTO {
  final String? nomeSala;
  final String? numeroBike;
  final String? numeroFila;
  final String? bikeFila;

  DTOSala({
    super.id,
    required super.nome,
    this.nomeSala,
    this.numeroBike,
    this.numeroFila,
    this.bikeFila,
  });
}
