import 'package:flutter/material.dart';
import 'package:spin_flow/dao/Manutecao.dart';
import 'package:spin_flow/dto/ManutencaoDTO.dart';
import 'package:spin_flow/widget/componentes/campo_texto.dart';

class FormTipoManutencaoTela extends StatefulWidget {
  const FormTipoManutencaoTela({super.key});

  @override
  State<FormTipoManutencaoTela> createState() => _FormTipoManutencaoTelaState();
}

class _FormTipoManutencaoTelaState extends State<FormTipoManutencaoTela> {
  final _formKey = GlobalKey<FormState>();
  final _descricaoControle = TextEditingController();
  bool _ativa = true;

  @override
  void dispose() {
    _descricaoControle.dispose();
    super.dispose();
  }

  void _salvar() async {
    if (_formKey.currentState!.validate()) {
      final dto = DTOManutencao(
        nome: _descricaoControle.text,
        ativo: _ativa,
      );

      try {
        await DAOManutencao().salvar(dto);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Salvo com sucesso!')),
        );

        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro - Tipo de Manutenção')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CampoTexto(
                controle: _descricaoControle,
                rotulo: 'Descrição',
                dica: 'pedal esquerdo, regulagem quebrada, pé-de-vela',
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Ativa'),
                value: _ativa,
                onChanged: (valor) {
                  setState(() => _ativa = valor);
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _salvar,
                child: const Text('Salvar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
