import 'package:flutter/material.dart';
import 'package:spin_flow/dto/dto_fabricante.dart';
import 'package:spin_flow/widget/componentes/borda_com_titulo.dart';
import 'package:spin_flow/widget/componentes/campo_email.dart';
import 'package:spin_flow/widget/componentes/campo_telefone.dart';
import 'package:spin_flow/widget/componentes/campo_texto.dart';

class FormFabricante extends StatefulWidget {
  const FormFabricante({super.key});

  @override
  State<FormFabricante> createState() => _FormFabricanteState();
}

class _FormFabricanteState extends State<FormFabricante> {
  final _formKey = GlobalKey<FormState>();
  int? id;

  final TextEditingController _nomeControle = TextEditingController();
  final TextEditingController _descricaoControle = TextEditingController();
  final TextEditingController _responsavelControle = TextEditingController();
  final TextEditingController _emailControle = TextEditingController();
  final TextEditingController _telefoneControle = TextEditingController();
  bool _ativo = true;

  @override
  void dispose() {
    _nomeControle.dispose();
    _descricaoControle.dispose();
    _responsavelControle.dispose();
    _emailControle.dispose();
    _telefoneControle.dispose();
    super.dispose();
  }

  void _salvar() async {
    if (_formKey.currentState!.validate()) {
      // Aqui você pega os valores e salva no banco ou estado
      var dto = DTOFabricante(  
        id: id,
        nome:  _nomeControle.text.trim(),
        descricao:  _descricaoControle.text.trim(),
        nomeContatoPrincipal: _responsavelControle.text.trim(),
        emailContato:  _emailControle.text.trim(),
        telefoneContato: _telefoneControle.text.trim(),
        ativo: _ativo
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fabricante salvo com sucesso! ${dto.nome}')),
      );
      _formKey.currentState!.reset();
    }
  }

  Widget _fabricante (){
    return BordaComTitulo(
      titulo: 'Fabricante',
      filhos: [
        CampoTexto(
          controle: _nomeControle,
          rotulo: 'Nome*',
          dica: 'Nome do fabricante',
        ),
        const SizedBox(height: 12),
        CampoTexto(
          controle: _descricaoControle,
          rotulo: 'Descrição',
          dica: 'Descrição opcional',
          //valorInicial: dto.descricao ?? '',
          eObrigatorio: false,
        ),
        const SizedBox(height: 24),
        SwitchListTile(
          title: const Text('Ativo'),
          value: _ativo,
          onChanged: (valor) {
            setState(() => _ativo = valor);
          },
        ),
      ],
    );
  }

  Widget _contato (){
    return BordaComTitulo(
      titulo: 'Contato',
      filhos: [
        CampoTexto(
          controle: _responsavelControle,
          rotulo: 'Responsável',
          dica: 'Nome do responsável',
          eObrigatorio: false,
        ),
        const SizedBox(height: 16),
        CampoEmail(controle: _emailControle, eObrigatorio: false),
        const SizedBox(height: 16),
        CampoTelefone(controle: _telefoneControle, eObrigatorio: false),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Fabricante'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _fabricante(),
              _contato(),
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
