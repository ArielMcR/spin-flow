import 'package:flutter/material.dart';
import 'package:spin_flow/dto/dto.dart';
import 'package:spin_flow/configuracoes/rotas.dart';
import 'package:spin_flow/widget/componentes/campo_busca_multipla.dart';
import 'package:spin_flow/widget/componentes/campo_busca_opcoes.dart';
import 'package:spin_flow/widget/componentes/campo_texto.dart';

class AlunoDTO extends DTO{
  AlunoDTO({required super.id, required super.nome});
}

final List<AlunoDTO> mockAlunos = [
  AlunoDTO(id: 1, nome: 'Maria Oliveira'),
  AlunoDTO(id: 2, nome: 'Joaquim Santos'),
  AlunoDTO(id: 3, nome: 'Joana Costa'),
  AlunoDTO(id: 4, nome: 'Lucas Pereira'),
  AlunoDTO(id: 5, nome: 'Ana Bezerra'),
  AlunoDTO(id: 6, nome: 'Carlos Silva'),
  AlunoDTO(id: 7, nome: 'Fernanda Lima'),
  AlunoDTO(id: 8, nome: 'Marcos Moreira'),
  AlunoDTO(id: 9, nome: 'Patrícia Rocha'),
  AlunoDTO(id: 10, nome: 'Diego Matos'),
  AlunoDTO(id: 11, nome: 'Bruna Andrade'),
  AlunoDTO(id: 12, nome: 'Rafael Monteiro'),
  AlunoDTO(id: 13, nome: 'Camila Teixeira'),
  AlunoDTO(id: 14, nome: 'André Barbosa'),
  AlunoDTO(id: 15, nome: 'Larissa Melo'),
  AlunoDTO(id: 16, nome: 'Vinícius Carvalho'),
  AlunoDTO(id: 17, nome: 'Juliana Batista'),
  AlunoDTO(id: 18, nome: 'Rodrigo Azevedo'),
  AlunoDTO(id: 19, nome: 'Aline Torres'),
  AlunoDTO(id: 20, nome: 'Fábio Ramos'),
  AlunoDTO(id: 21, nome: 'Renata Borges'),
  AlunoDTO(id: 22, nome: 'Thiago Martins'),
  AlunoDTO(id: 23, nome: 'Paula Almeida'),
  AlunoDTO(id: 24, nome: 'Bruno Freitas'),
  AlunoDTO(id: 25, nome: 'Natália Cunha'),
  AlunoDTO(id: 26, nome: 'Eduardo Farias'),
  AlunoDTO(id: 27, nome: 'Sabrina Duarte'),
  AlunoDTO(id: 28, nome: 'Gustavo Nogueira'),
  AlunoDTO(id: 29, nome: 'Elaine Cardoso'),
  AlunoDTO(id: 30, nome: 'Igor Pacheco'),
];

class FormGrupoAlunos extends StatefulWidget {
  const FormGrupoAlunos({Key? key}) : super(key: key);

  @override
  State<FormGrupoAlunos> createState() => _FormGrupoAlunosState();
}

class _FormGrupoAlunosState extends State<FormGrupoAlunos> {
  final _formKey = GlobalKey<FormState>();

  // Controllers para CampoTexto
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  // Lista para armazenar os alunos selecionados
  final List<AlunoDTO> _alunosSelecionados = [];

  // Função para validar que há pelo menos 1 aluno selecionado
  String? _validaAlunosSelecionados() {
    if (_alunosSelecionados.isEmpty) {
      return 'Selecione pelo menos um aluno';
    }
    return null;
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  void _salvar() {
    final formValido = _formKey.currentState?.validate() ?? false;
    final alunosValidos = _validaAlunosSelecionados() == null;

    if (formValido && alunosValidos) {
      // Aqui poderia salvar os dados no backend ou local

      final nome = _nomeController.text.trim();
      final descricao = _descricaoController.text.trim();
      final alunos = _alunosSelecionados;

      // Apenas print para demonstrar
      print('Nome do grupo: $nome');
      print('Descrição: $descricao');
      print('Alunos selecionados: ${alunos.map((a) => a.nome).join(', ')}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Grupo salvo com sucesso!')),
      );
    } else {
      if (!alunosValidos) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_validaAlunosSelecionados()!)),
        );
      }
    }
  }

  

  void _removerMusica(AlunoDTO musica) {
    setState(() => _alunosSelecionados.removeWhere((m) => m.id == musica.id));
  }

  Widget _campoBuscaMultipla(){
    return Column(
      children: [
        CampoBuscaOpcoes<AlunoDTO>(
                    opcoes: mockAlunos,
                    rotulo: 'Buscar e adicionar aluno',
                    textoPadrao: 'Digite para buscar alunos...',
                    eObrigatorio: false, // a validação é feita manual
                    onChanged: (aluno) {
                      if (aluno != null && !_alunosSelecionados.contains(aluno)) {
                        setState(() {
                          _alunosSelecionados.add(aluno);
                        });
                      }
                    },
                    // Exemplo de rota para cadastro (não implementada aqui)
                    rotaCadastro: Rotas.cadastroAluno,
                  ),
     
              const SizedBox(height: 8),
              const Text('Alunos Grupo:', style: TextStyle(fontWeight: FontWeight.bold)),
              ..._alunosSelecionados.map(
                (aluno) => ListTile(
                  title: Text(aluno.nome),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removerMusica(aluno),
                  ),
                ),
              )
               ],
    );
              
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Grupo de Alunos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CampoTexto(
                controle: _nomeController,
                rotulo: 'Nome',
                dica: 'Digite o nome do grupo',
                eObrigatorio: true,
                mensagemErro: 'Nome é obrigatório',
              ),
              const SizedBox(height: 16),
              CampoTexto(
                controle: _descricaoController,
                rotulo: 'Descrição',
                dica: 'Descrição do grupo (opcional)',
                eObrigatorio: false,
                maxLinhas: 3,
              ),
              const SizedBox(height: 16),

              // CampoBuscaOpcoes para seleção de múltiplos alunos
              Text(
                'Alunos',
              ),
              const SizedBox(height: 8),

              // Como CampoBuscaOpcoes é para um item, vamos simular
              // um campo para adicionar múltiplos alunos, com chips abaixo
              //_campoBuscaMultipla(),
              CampoBuscaMultipla<AlunoDTO>(
                opcoes: mockAlunos,
                rotulo: 'Alunos do Grupo',
                textoPadrao: 'Digite para buscar alunos...',
                rotaCadastro: Rotas.cadastroAluno,
                onChanged: (lista) {
                  _alunosSelecionados
                    ..clear()
                    ..addAll(lista);
                },
              ),
              
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _salvar,
                  child: const Text('Salvar'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
