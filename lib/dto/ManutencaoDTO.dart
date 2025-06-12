import 'package:spin_flow/dto/dto.dart';

class DTOManutencao extends DTO {
  final String? descricao;
  final bool ativo;

  DTOManutencao({
    super.id,
    required super.nome,
    this.descricao,
    this.ativo = true,
  });
}
