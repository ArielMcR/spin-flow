import 'package:spin_flow/dto/dto.dart';

class SalaPosicionamentoDTO extends DTO{
  int numeroBikes;
  int numeroFilas;
  int limiteBikesPorFila;
  int posicaoBikeProfessora; // índice da coluna da bike da professora na fila 0
  List<List<int>> posicoes; // grade das bikes

  SalaPosicionamentoDTO({
    required super.id,
    required super.nome,
    required this.numeroBikes,
    required this.numeroFilas,
    required this.limiteBikesPorFila,
    required this.posicaoBikeProfessora,
    required this.posicoes,
  });
}
