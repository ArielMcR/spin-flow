import 'package:spin_flow/dto/dto.dart';

class DTOCategoriaMusica extends DTO{
  final String? nomeCategoria;
  final String? descricao;
  final bool ativo;

  DTOCategoriaMusica({
    super.id,
    required super.nome,
    this.nomeCategoria,
    this.descricao,
    this.ativo = true,
  });
}