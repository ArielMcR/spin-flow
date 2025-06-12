import 'package:flutter/material.dart';

class CampoSenha extends StatelessWidget{
  final TextEditingController controle;
  final String rotulo;
  final String dica;
  final String mensagemErro;

  const CampoSenha({super.key, required this.controle, required this.rotulo, required this.dica, required this.mensagemErro});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controle,
      obscureText: true,
      decoration: InputDecoration(
        labelText: rotulo,
        //border: const OutlineInputBorder(),
        hintText: dica,
      ),
      validator: (value) =>
          value == null || value.isEmpty ? mensagemErro : null,
    );
  }

}