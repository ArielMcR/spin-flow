import 'package:flutter/material.dart';
import 'package:spin_flow/configuracoes/erro.dart';

class CampoTexto extends StatelessWidget{
  final TextEditingController controle;
  final String rotulo;
  final String dica;
  final String mensagemErro;
  final int maxLinhas;
  final String? valorInicial;
  final bool eObrigatorio;

  const CampoTexto({super.key, required this.controle, this.valorInicial, required this.rotulo, required this.dica, this.mensagemErro = Erro.obrigatorio, this.maxLinhas = 1, this.eObrigatorio = true});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controle,
      maxLines: maxLinhas,
      initialValue: valorInicial,
      decoration: InputDecoration(
        labelText: rotulo,
        hintText: dica,
      ),
      validator: (value) {
        if(eObrigatorio){
          if(value == null || value.isEmpty){
            return mensagemErro;
          }
        } else {
          return null;
        }
      }
    );
  }

}