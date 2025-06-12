import 'package:flutter/material.dart';
import 'package:spin_flow/widget/componentes/app_bar_salvar.dart';
import 'package:spin_flow/widget/componentes/campo_texto.dart';
import 'package:spin_flow/widget/componentes/campo_url.dart';

class FormArtistaBanda extends StatefulWidget {
  const FormArtistaBanda({super.key});

  @override
  State<FormArtistaBanda> createState() => _FormArtistaBandaState();
}

class _FormArtistaBandaState extends State<FormArtistaBanda> {
  final _formKey = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _descricao = TextEditingController();
  final _link = TextEditingController();
  final _foto = TextEditingController();
  bool _ativo = true;

  @override
  void dispose() {
    _nome.dispose();
    _descricao.dispose();
    _link.dispose();
    _foto.dispose();
    super.dispose();
  }

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      // TODO: salvar artista/banda
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSalvar(  
        titulo: 'Cadastro de Artista/Banda',
        aoSalvar: _salvar,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CampoTexto(
                controle: _nome,
                rotulo: 'Nome',
                dica: 'Artista ou Banda',
              ),
              CampoTexto(
                controle: _descricao,
                rotulo: 'Descrição',
                dica: 'Informações adicionais sobre o artista ou banda',
                maxLinhas: 4,
                eObrigatorio: false,
              ),
              CampoUrl(
                controle: _link,
                rotulo: 'Link relacionado',
                dica: 'Página oficial, bibliografia, playlist etc.',
                eObrigatorio: false,
              ),
              CampoUrl(
                controle: _foto,
                rotulo: 'URL da foto',
                dica: 'Imagem representativa da banda ou artista',
                eObrigatorio: false,
              ),
              SwitchListTile(
                value: _ativo,
                onChanged: (valor) => setState(() => _ativo = valor),
                title: const Text('Ativo'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
