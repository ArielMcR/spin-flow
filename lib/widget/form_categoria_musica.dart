import 'package:flutter/material.dart';
import 'package:spin_flow/widget/componentes/campo_texto.dart';

class FormCategoriaMusica extends StatefulWidget {
  const FormCategoriaMusica({super.key});

  @override
  State<FormCategoriaMusica> createState() => _FormCategoriaMusicaState();
}

class _FormCategoriaMusicaState extends State<FormCategoriaMusica> {
  final _formKey = GlobalKey<FormState>();
  final _nomeControle = TextEditingController();
  final _descricaoControle = TextEditingController();
  bool _ativa = true;

  @override
  void dispose() {
    _nomeControle.dispose();
    _descricaoControle.dispose();
    super.dispose();
  }

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      // Aqui entraria a lógica de salvar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Categoria salva com sucesso!')),
      );
      Navigator.of(context).pop(); // Volta à tela anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Categoria de Música')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CampoTexto(    
                controle: _nomeControle,
                rotulo: 'Nome',
                dica: 'cadência, ritmo, coreografia, força, relaxamento, aquecimento',
              ),
              const SizedBox(height: 16),
              CampoTexto(
                controle: _descricaoControle,
                rotulo: 'Descrição',
                dica: 'Descrição da coreografia\nExemplo para "Coreografia" → músicas que exigem coordenação motora e passos específicos',
                maxLinhas: 3,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
 
}

 /*
Categorias para músicas (nomes sugestivos):
Cadência — músicas que definem ritmo e velocidade do treino
Coreografia — músicas que exigem coordenação motora e passos específicos
Força — músicas para exercícios que trabalham força e resistência
Perna — músicas focadas em exercícios para membros inferiores
Braço — músicas para exercícios focados em membros superiores
Ritmo — músicas com batidas envolventes para manter a energia
Relaxamento — músicas suaves para alongamento, descanso e desaceleração
Animação — músicas alegres e motivadoras para divertir e estimular
Intervalo — músicas para momentos de pausa ativa, recuperação rápida
Aquecimento — músicas para preparar o corpo no início da aula
Desaquecimento — músicas para finalização, relaxar e diminuir o esforço
Explosão — músicas com batidas fortes para picos de esforço e sprint
Core — músicas para exercícios focados na região do abdômen e tronco
  */
