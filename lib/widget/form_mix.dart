import 'package:flutter/material.dart';
import 'package:spin_flow/dto/dto.dart';
import 'package:spin_flow/widget/componentes/campo_texto.dart';
import 'package:spin_flow/widget/componentes/campo_data.dart';
import 'package:spin_flow/widget/componentes/campo_busca_opcoes.dart';
import 'package:spin_flow/configuracoes/rotas.dart';

class FormMix extends StatefulWidget {
  const FormMix({super.key});

  @override
  State<FormMix> createState() => _FormMixState();
}

class _FormMixState extends State<FormMix> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeMixController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  DateTime? _dataInicio;
  DateTime? _dataFim;
  bool _ativo = true;
  List<MusicaDTO> _musicasSelecionadas = [];

  void _adicionarMusica(MusicaDTO? musica) {
    if (musica != null && !_musicasSelecionadas.any((m) => m.id == musica.id)) {
      setState(() => _musicasSelecionadas.add(musica));
    }
  }

  void _removerMusica(MusicaDTO musica) {
    setState(() => _musicasSelecionadas.removeWhere((m) => m.id == musica.id));
  }

  @override
  void dispose() {
    _nomeMixController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Mix')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            CampoTexto(
              controle: _nomeMixController,
              rotulo: 'Nome do Mix',
              dica: 'Ex: Mix Power Março 2025',
            ),
            const SizedBox(height: 16),
            CampoData(
              label: 'Data de início de uso',
              eObrigatorio: true,
              valor: _dataInicio,
              onChanged: (data) => setState(() => _dataInicio = data),
            ),
            const SizedBox(height: 16),
            CampoData(
              label: 'Data de encerramento (opcional)',
              eObrigatorio: false,
              valor: _dataFim,
              onChanged: (data) => setState(() => _dataFim = data),
            ),
            const SizedBox(height: 16),
            CampoBuscaOpcoes<MusicaDTO>(
              opcoes: listaMusicas,
              rotulo: 'Música',
              eObrigatorio: false,
              textoPadrao: 'Selecione as músicas do mix',
              rotaCadastro: Rotas.cadastroMusica,
              onChanged: _adicionarMusica,
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Adicionar música ao mix'),
            ),
            const SizedBox(height: 8),
            const Text('Músicas no mix:', style: TextStyle(fontWeight: FontWeight.bold)),
            ..._musicasSelecionadas.map(
              (musica) => ListTile(
                title: Text('${musica.nome} - ${musica.artista}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _removerMusica(musica),
                ),
              ),
            ),
            const SizedBox(height: 16),
            CampoTexto(
              controle: _descricaoController,
              rotulo: 'Descrição / Observações',
              dica: 'Ex: Mix voltado para treinos intensos...',
              maxLinhas: 4,
              eObrigatorio: false,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              value: _ativo,
              onChanged: (valor) => setState(() => _ativo = valor),
              title: const Text('Ativo'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate() && _musicasSelecionadas.isNotEmpty) {
                  // Processar dados
                  // Ex: salvar mix no banco
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Preencha todos os campos obrigatórios.')),
                  );
                }
              },
              child: const Text('Salvar Mix'),
            ),
          ],
        ),
      ),
    );
  }
}

class MusicaDTO extends DTO {
  final String artista;

  MusicaDTO({
    required int id,
    required String nome,
    required this.artista,
  }) : super(id: id, nome: nome);
}

List<MusicaDTO> listaMusicas = [
  MusicaDTO(id: 1, nome: 'Eye of the Tiger', artista: 'Survivor'),
  MusicaDTO(id: 2, nome: 'Strong Beat', artista: 'Pulse Rock'),
  MusicaDTO(id: 3, nome: 'Lose Yourself', artista: 'Eminem'),
  MusicaDTO(id: 4, nome: 'Stronger', artista: 'Kanye West'),
  MusicaDTO(id: 5, nome: 'Can’t Hold Us', artista: 'Macklemore & Ryan Lewis'),
  MusicaDTO(id: 6, nome: 'Remember the Name', artista: 'Fort Minor'),
  MusicaDTO(id: 7, nome: 'Till I Collapse', artista: 'Eminem'),
  MusicaDTO(id: 8, nome: 'Born to Run', artista: 'Bruce Springsteen'),
  MusicaDTO(id: 9, nome: 'Jump', artista: 'Van Halen'),
  MusicaDTO(id: 10, nome: 'Believer', artista: 'Imagine Dragons'),
  MusicaDTO(id: 11, nome: 'Thunderstruck', artista: 'AC/DC'),
  MusicaDTO(id: 12, nome: 'We Will Rock You', artista: 'Queen'),
  MusicaDTO(id: 13, nome: 'Seven Nation Army', artista: 'The White Stripes'),
  MusicaDTO(id: 14, nome: 'Welcome to the Jungle', artista: 'Guns N’ Roses'),
  MusicaDTO(id: 15, nome: 'Don’t Stop Me Now', artista: 'Queen'),
  MusicaDTO(id: 16, nome: 'Let’s Go', artista: 'Calvin Harris'),
  MusicaDTO(id: 17, nome: 'Titanium', artista: 'David Guetta feat. Sia'),
  MusicaDTO(id: 18, nome: 'Power', artista: 'Kanye West'),
  MusicaDTO(id: 19, nome: 'Run This Town', artista: 'Jay-Z feat. Rihanna & Kanye West'),
  MusicaDTO(id: 20, nome: 'Feel It Still', artista: 'Portugal. The Man'),
  MusicaDTO(id: 21, nome: 'Uptown Funk', artista: 'Mark Ronson feat. Bruno Mars'),
  MusicaDTO(id: 22, nome: 'Bangarang', artista: 'Skrillex'),
  MusicaDTO(id: 23, nome: 'Radioactive', artista: 'Imagine Dragons'),
  MusicaDTO(id: 24, nome: 'Can’t Stop', artista: 'Red Hot Chili Peppers'),
  MusicaDTO(id: 25, nome: 'My Songs Know What You Did in the Dark', artista: 'Fall Out Boy'),
  MusicaDTO(id: 26, nome: 'The Greatest', artista: 'Sia'),
  MusicaDTO(id: 27, nome: 'Born This Way', artista: 'Lady Gaga'),
  MusicaDTO(id: 28, nome: 'Fight Song', artista: 'Rachel Platten'),
  MusicaDTO(id: 29, nome: 'This Is Me', artista: 'Keala Settle'),
  MusicaDTO(id: 30, nome: 'High Hopes', artista: 'Panic! At The Disco'),
  MusicaDTO(id: 31, nome: 'On Top of the World', artista: 'Imagine Dragons'),
  MusicaDTO(id: 32, nome: 'Stronger Than You', artista: 'Estelle (feat. Garnet)'),
  MusicaDTO(id: 33, nome: 'Glorious', artista: 'Macklemore feat. Skylar Grey'),
  MusicaDTO(id: 34, nome: 'Whatever It Takes', artista: 'Imagine Dragons'),
  MusicaDTO(id: 35, nome: 'Rise', artista: 'Katy Perry'),
  MusicaDTO(id: 36, nome: 'Hall of Fame', artista: 'The Script feat. will.i.am'),
  MusicaDTO(id: 37, nome: 'We Are the Champions', artista: 'Queen'),
  MusicaDTO(id: 38, nome: 'The Man', artista: 'Aloe Blacc'),
  MusicaDTO(id: 39, nome: 'Pump It', artista: 'Black Eyed Peas'),
  MusicaDTO(id: 40, nome: 'Let It Rock', artista: 'Kevin Rudolf feat. Lil Wayne'),
  MusicaDTO(id: 41, nome: 'All I Do Is Win', artista: 'DJ Khaled'),
  MusicaDTO(id: 42, nome: 'Warriors', artista: 'Imagine Dragons'),
  MusicaDTO(id: 43, nome: 'Black Skinhead', artista: 'Kanye West'),
  MusicaDTO(id: 44, nome: 'DNA.', artista: 'Kendrick Lamar'),
  MusicaDTO(id: 45, nome: 'Firestarter', artista: 'The Prodigy'),
  MusicaDTO(id: 46, nome: 'Heads Will Roll (A-Trak Remix)', artista: 'Yeah Yeah Yeahs'),
  MusicaDTO(id: 47, nome: 'Run Boy Run', artista: 'Woodkid'),
  MusicaDTO(id: 48, nome: 'Sail', artista: 'AWOLNATION'),
  MusicaDTO(id: 49, nome: 'Invincible', artista: 'Two Steps From Hell'),
  MusicaDTO(id: 50, nome: 'Centuries', artista: 'Fall Out Boy'),
];
