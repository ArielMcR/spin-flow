import 'package:flutter/material.dart';
import 'package:spin_flow/dto/dto.dart';
import 'package:spin_flow/configuracoes/rotas.dart';
import 'package:spin_flow/widget/componentes/campo_multi_selecao.dart';
import 'package:spin_flow/widget/componentes/campo_texto.dart';
import 'package:spin_flow/widget/componentes/campo_opcoes.dart';
import 'package:spin_flow/widget/componentes/campo_url.dart';

class CategoriaMusicaDTO extends DTO {
  CategoriaMusicaDTO({required super.id, required super.nome});
}

class ArtistaDTO extends DTO {
  ArtistaDTO({required super.id, required super.nome});
}

class LinkVideoDTO {
  String url;
  String descricao;

  LinkVideoDTO({required this.url, required this.descricao});
}

class MusicaDTO extends DTO {
  final ArtistaDTO artista;
  final List<CategoriaMusicaDTO> categorias;
  final List<LinkVideoDTO> linksVideoAula;
  final String descricao;

  MusicaDTO({
    required int id,
    required String nome,
    required this.artista,
    required this.categorias,
    required this.linksVideoAula,
    required this.descricao,
  }) : super(id: id, nome: nome);
}

class FormMusica extends StatefulWidget {
  const FormMusica({super.key});

  @override
  State<FormMusica> createState() => _FormMusicaState();
}

class _FormMusicaState extends State<FormMusica> {
  final _formKey = GlobalKey<FormState>();

  final _nomeControle = TextEditingController();
  ArtistaDTO? _artistaSelecionado;

  // Dados fictícios para artistas (simula campo CampoOpcoes)
  final List<ArtistaDTO> _artistasMock = [
    ArtistaDTO(id: 1, nome: 'Survivor'),
    ArtistaDTO(id: 2, nome: 'Queen'),
    ArtistaDTO(id: 3, nome: 'Metallica'),
  ];

  // Dados fictícios para categorias (simula CampoMultiSelecao)
  final List<CategoriaMusicaDTO> _categoriasMock = [
    CategoriaMusicaDTO(id: 1, nome: 'Cadência'),
    CategoriaMusicaDTO(id: 2, nome: 'Coreografia'),
    CategoriaMusicaDTO(id: 3, nome: 'Força'),
    CategoriaMusicaDTO(id: 4, nome: 'Relaxamento'),
  ];

  final List<CategoriaMusicaDTO> _categoriasSelecionadas = [];

  // Links vídeo aula
  final List<Map<String, TextEditingController>> _linksControllers = [];

  final _descricaoControle = TextEditingController();

  @override
  void dispose() {
    _nomeControle.dispose();
    _descricaoControle.dispose();
    for (var link in _linksControllers) {
      link['url']!.dispose();
      link['descricao']!.dispose();
    }
    super.dispose();
  }

  void _adicionarLink() {
    setState(() {
      _linksControllers.add({
        'url': TextEditingController(),
        'descricao': TextEditingController(),
      });
    });
  }

  void _removerLink(int index) {
    setState(() {
      _linksControllers[index]['url']!.dispose();
      _linksControllers[index]['descricao']!.dispose();
      _linksControllers.removeAt(index);
    });
  }

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      if (_artistaSelecionado == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selecione o artista/banda')),
        );
        return;
      }
      if (_categoriasSelecionadas.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selecione pelo menos uma categoria')),
        );
        return;
      }

      final nome = _nomeControle.text.trim();
      final descricao = _descricaoControle.text.trim();

      final links = _linksControllers
          .map((map) => LinkVideoDTO(
                url: map['url']!.text.trim(),
                descricao: map['descricao']!.text.trim(),
              ))
          .where((link) => link.url.isNotEmpty)
          .toList();

      final musica = MusicaDTO(
        id: 0,
        nome: nome,
        artista: _artistaSelecionado!,
        categorias: List.from(_categoriasSelecionadas),
        linksVideoAula: links,
        descricao: descricao,
      );

      // Salvar no banco de dados aqui

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Música "${musica.nome}" salva com sucesso!')),
      );

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Música'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            tooltip: 'Salvar',
            onPressed: _salvar,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CampoTexto(
                controle: _nomeControle,
                rotulo: 'Nome da Música',
                dica: 'Nome da música',
                eObrigatorio: true,
              ),
              const SizedBox(height: 16),
              CampoOpcoes<ArtistaDTO>(
                opcoes: _artistasMock,
                valorSelecionado: _artistaSelecionado,
                rotulo: 'Artista/Banda',
                textoPadrao: 'Selecione o artista/banda',
                eObrigatorio: true,
                rotaCadastro: Rotas.cadastroArtistaBanda,
                onChanged: (artista) {
                  setState(() {
                    _artistaSelecionado = artista;
                  });
                },
                // rotaCadastro pode ser adicionada se houver tela para cadastrar artista
              ),
              const SizedBox(height: 16),
              CampoMultiSelecao<CategoriaMusicaDTO>(
                opcoes: _categoriasMock,
                rotaCadastro: Rotas.cadastroCategoriaMusica,
                valoresSelecionados: _categoriasSelecionadas,
                rotulo: 'Categorias de Música',
                textoPadrao: 'Selecione categorias',
                eObrigatorio: true,
                onChanged: (selecionados) {
                  setState(() {
                    _categoriasSelecionadas
                      ..clear()
                      ..addAll(selecionados);
                  });
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Links de Vídeo Aula (opcional)',
              ),
              const SizedBox(height: 8),
              ..._linksControllers.asMap().entries.map((entry) {
                int index = entry.key;
                var controllers = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: CampoUrl(
                          controle: controllers['url']!,
                          rotulo: 'Link do Vídeo Aula ${index + 1}',
                          dica: 'https://...',
                          eObrigatorio: false,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 2,
                        child: CampoTexto(
                          controle: controllers['descricao']!,
                          rotulo: 'Descrição',
                          dica: 'Ex: Playlist oficial',
                          eObrigatorio: false,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        tooltip: 'Remover link',
                        onPressed: () => _removerLink(index),
                      ),
                    ],
                  ),
                );
              }).toList(),
              TextButton.icon(
                onPressed: _adicionarLink,
                icon: const Icon(Icons.add),
                label: const Text('Adicionar Link de Vídeo Aula'),
              ),
              const SizedBox(height: 24),
              CampoTexto(
                controle: _descricaoControle,
                rotulo: 'Descrição / Observações (opcional)',
                dica: 'Detalhes extras sobre a música',
                eObrigatorio: false,
                maxLinhas: 4,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _salvar,
                child: const Text('Salvar Música'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
