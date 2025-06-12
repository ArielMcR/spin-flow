import 'package:flutter/material.dart';
import 'package:spin_flow/dto/dto.dart';
import 'package:spin_flow/configuracoes/rotas.dart';
import 'package:spin_flow/widget/componentes/campo_data.dart';
import 'package:spin_flow/widget/componentes/campo_opcoes.dart';
import 'package:spin_flow/widget/componentes/campo_texto.dart';

// Classe temporária Fabricante
class Fabricante extends DTO{
  Fabricante({required super.id,required super.nome});
}
// Lista fixa com fabricantes contextualizados para spinning
List<Fabricante> consultaBD = [
    Fabricante(id: 1, nome: 'Movement'),
    Fabricante(id: 2, nome: 'Kikos'),
    Fabricante(id: 3, nome: 'Dream Fitness'),
    Fabricante(id: 4, nome: 'O’Neal'),
    Fabricante(id: 5, nome: 'Acte Sports'),
    Fabricante(id: 6, nome: 'Speedo Fitness'),
  ];

class FormBike extends StatefulWidget {
  const FormBike({Key? key}) : super(key: key);

  @override
  _FormBikeState createState() => _FormBikeState();
}

class _FormBikeState extends State<FormBike> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeControle = TextEditingController();
  final TextEditingController _numeroSerieControle = TextEditingController();
  final List<Fabricante> _fabricantes = consultaBD;

  Fabricante? _fabricanteSelecionado;
  DateTime? _dataCadastro;
  bool _ativa = true;

  @override
  void dispose() {
    _nomeControle.dispose();
    _numeroSerieControle.dispose();
    super.dispose();
  }

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      if (_fabricanteSelecionado == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selecione um fabricante')),
        );
        return;
      }

      if (_dataCadastro == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Informe a data de cadastro')),
        );
        return;
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Bike')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CampoTexto(
                controle: _nomeControle,
                rotulo: 'Nome',
                dica: 'Identificador da bike - número ou nome',
              ),

              CampoTexto(
                controle: _numeroSerieControle,
                rotulo: 'Número de Série',
                dica: 'é opcional',
                eObrigatorio: false,
              ),
              const SizedBox(height: 16),
              CampoOpcoes<Fabricante>(
                opcoes: _fabricantes,
                rotulo: 'Fabricante',
                textoPadrao: 'Selecione um fabricante',
                rotaCadastro: Rotas.cadastroFabricante,
              ),
              const SizedBox(height: 16),
              CampoData(
                label: 'Data de Cadastro',
                valor: _dataCadastro,
                eObrigatorio: true,
                onChanged: (data) {
                  setState(() {
                    _dataCadastro = data;
                  });
                },
              ),
              const SizedBox(height: 16),

              SwitchListTile(
                title: const Text('Ativa'),
                value: _ativa,
                onChanged: (valor) {
                  setState(() {
                    _ativa = valor;
                  });
                },
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _salvar,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
