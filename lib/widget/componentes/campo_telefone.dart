import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:spin_flow/configuracoes/erro.dart';

class CampoTelefone extends StatelessWidget {
  final TextEditingController controle;
  final String rotulo;
  final String dica;
  final String? Function(String?)? validator;
  final bool eObrigatorio;

  CampoTelefone({
    Key? key,
    required this.controle,
    this.rotulo = 'Telefone',
    this.dica = '(00) 00000-0000',
    this.validator,
    this.eObrigatorio = true,
  }) : super(key: key);

  final _mascara = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  String? _validarTelefone(String? value) {
    if (value == null || value.trim().isEmpty) {
      if (eObrigatorio) return 'Informe o telefone';
    } else {
      if (!_mascara.isFill()) return Erro.telefoneInvalido;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controle,
      keyboardType: TextInputType.phone,
      inputFormatters: [_mascara],
      decoration: InputDecoration(
        labelText: rotulo,
        hintText: dica,
        prefixIcon: const Icon(Icons.phone),
      ),
      validator: validator ?? _validarTelefone,
      autofillHints: const [AutofillHints.telephoneNumber],
    );
  }
}
