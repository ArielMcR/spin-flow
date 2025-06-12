import 'package:flutter/material.dart';
import 'package:spin_flow/configuracoes/erro.dart';

class CampoNumero extends StatelessWidget {
  final TextEditingController controle;
  final String rotulo;
  final String dica;
  final String mensagemErro;
  final bool eObrigatorio;
  final bool aceitaNegativo;
  final int? limiteMaximo;
  final int limiteMinimo;
  final void Function(String)? onChanged;

  const CampoNumero({
    Key? key,
    required this.controle,
    required this.rotulo,
    this.dica = '',
    this.mensagemErro = Erro.obrigatorio,
    this.eObrigatorio = true,
    this.aceitaNegativo = false,
    this.limiteMaximo,
    this.limiteMinimo = 0,
    this.onChanged,
  }) : super(key: key);

  String? _validar(String? value) {
    if (eObrigatorio && (value == null || value.isEmpty)) {
      return mensagemErro;
    }

    if (value != null && value.isNotEmpty) {
      final numero = int.tryParse(value);
      if (numero == null) {
        return 'Informe um número válido';
      }
      if (!aceitaNegativo && numero < 0) {
        return 'Não pode ser número negativo';
      }
      if (numero < limiteMinimo) {
        return 'Valor deve ser ≥ $limiteMinimo';
      }
      if (limiteMaximo != null && numero > limiteMaximo!) {
        return 'Valor deve ser ≤ $limiteMaximo';
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controle,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: rotulo,
        hintText: dica,
        border: const OutlineInputBorder(),
      ),
      validator: _validar,
      onChanged: onChanged,
    );
  }
}
