import 'package:flutter/material.dart';
import 'package:spin_flow/dto/dto.dart';
import 'package:spin_flow/configuracoes/rotas.dart';
import 'package:spin_flow/widget/componentes/campo_hora.dart';
import 'package:spin_flow/widget/componentes/campo_numero.dart';
import 'package:spin_flow/widget/componentes/campo_opcoes.dart';
import 'package:spin_flow/widget/componentes/campo_texto.dart';

import 'componentes/campo_dias_semana.dart';

class SalaDTO extends DTO {

  SalaDTO({required super.id, required super.nome});
}

// Mock das salas
final List<SalaDTO> salasMock = [
  SalaDTO(id: 1, nome: 'Sala Spinning 1'),
  SalaDTO(id: 2, nome: 'Sala Spinning 2'),
  SalaDTO(id: 3, nome: 'Sala Principal'),
];

class FormTurma extends StatefulWidget {
  const FormTurma({Key? key}) : super(key: key);

  @override
  State<FormTurma> createState() => _FormTurmaState();
}

class _FormTurmaState extends State<FormTurma> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _duracaoController = TextEditingController();

  // Campos selecionados
  List<String> _diasSelecionados = [];
  TimeOfDay? _horarioInicio;
  SalaDTO? _salaSelecionada;
  bool _ativo = true;

  @override
  void dispose() {
    _nomeController.dispose();
    _descricaoController.dispose();
    _duracaoController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      // Validação extra: dias selecionados e horário
      if (_diasSelecionados.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selecione ao menos um dia da semana')),
        );
        return;
      }
      if (_horarioInicio == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selecione o horário de início')),
        );
        return;
      }
      if (_salaSelecionada == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selecione a sala')),
        );
        return;
      }

      // Todos os dados válidos
      print('Nome da turma: ${_nomeController.text}');
      print('Descrição: ${_descricaoController.text}');
      print('Dias: $_diasSelecionados');
      print('Horário: ${_horarioInicio!.format(context)}');
      print('Duração (min): ${_duracaoController.text}');
      print('Sala: ${_salaSelecionada!.nome}');
      print('Ativo: $_ativo');

      // Aqui você pode criar o objeto turma e salvar no banco etc.

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Turma salva com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Turma')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CampoTexto(
                controle: _nomeController,
                rotulo: 'Nome da turma',
                dica: 'Ex: Spinning Avançado 18h',
                mensagemErro: 'Informe o nome da turma',
              ),
              const SizedBox(height: 16),
              CampoTexto(
                controle: _descricaoController,
                rotulo: 'Descrição (opcional)',
                dica: 'Nível, foco, observações',
                eObrigatorio: false,
              ),
              const SizedBox(height: 16),
              CampoDiasSemana(
                diasSelecionados: _diasSelecionados,
                onChanged: (List<String> novosDias) {
                  setState(() {
                    _diasSelecionados = novosDias;
                  });
                },
              ),
              const SizedBox(height: 16),
              CampoHora(
                rotulo: 'Hora Inicial',
                horaInicial: _horarioInicio,
                onChanged: (novoHorario) {
                  setState(() {
                    _horarioInicio = novoHorario;
                  });
                },
              ),
              const SizedBox(height: 16),
              CampoNumero(
                controle: _duracaoController,
                rotulo: 'Duração da aula (minutos)',
                dica: 'Ex: 45',
                eObrigatorio: true,
                limiteMinimo: 1,
                limiteMaximo: 180,
              ),
              const SizedBox(height: 16),
              CampoOpcoes<SalaDTO>(
                opcoes: salasMock,
                valorSelecionado: _salaSelecionada,
                rotulo: 'Sala / Local da aula',
                rotaCadastro: Rotas.cadastroSala,
                onChanged: (SalaDTO? novaSala) {
                  setState(() {
                    _salaSelecionada = novaSala;
                  });
                },
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: const Text('Ativo'),
                value: _ativo,
                onChanged: (bool? valor) {
                  setState(() {
                    _ativo = valor ?? true;
                  });
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Salvar turma'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
