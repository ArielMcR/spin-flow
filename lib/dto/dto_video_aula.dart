import 'package:spin_flow/dto/dto.dart';

class DTOVideoAula extends DTO{
  final String? linkVideo;
  final bool ativo;

  DTOVideoAula({
    super.id,
    required super.nome,
    this.linkVideo,
    this.ativo = true,
  });
}