import 'package:flutter/material.dart';
import 'package:spin_flow/widget/componentes/app_bar_salvar.dart';
import 'package:spin_flow/widget/componentes/campo_data.dart';
import 'package:spin_flow/widget/componentes/campo_email.dart';
import 'package:spin_flow/widget/componentes/campo_telefone.dart';
import 'package:spin_flow/widget/componentes/campo_texto.dart';
import 'package:spin_flow/widget/componentes/campo_url.dart';

class FormAluno extends StatefulWidget {
  const FormAluno({Key? key}) : super(key: key);

  @override
  State<FormAluno> createState() => _FormAlunoState();
}

class _FormAlunoState extends State<FormAluno> {
  final _formKey = GlobalKey<FormState>();

  // Controllers para campos de texto
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  DateTime? _dataNascimento;
  String? _genero;
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _urlFotoController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _tiktokController = TextEditingController();
  final TextEditingController _observacoesController = TextEditingController();
  bool _ativo = true;

  // Ícones sociais
  final Icon _iconInstagram = const Icon(Icons.camera_alt_outlined, color: Colors.purple);
  final Icon _iconFacebook = const Icon(Icons.facebook, color: Colors.blue);
  final Icon _iconTikTok = const Icon(Icons.music_note, color: Colors.black);

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _urlFotoController.dispose();
    _instagramController.dispose();
    _facebookController.dispose();
    _tiktokController.dispose();
    _observacoesController.dispose();
    super.dispose();
  }

  // Validação simples para URLs de redes sociais (exemplo)
  String? _validarUrlRedeSocial(String? value, String rede) {
    if (value == null || value.trim().isEmpty) return null; // opcional
    final url = value.trim();
    // Simples regex para URL (pode ser melhorada)
    final urlRegex = RegExp(r"^(https?:\/\/)?([\w\-]+\.)+[\w\-]+(\/[\w\-._~:/?#[\]@!$&'()*+,;=]*)?$");
    if (!urlRegex.hasMatch(url)) {
      return 'Informe uma URL válida para $rede';
    }
    return null;
  }

  void _salvar() {
    if (_formKey.currentState?.validate() ?? false) {
      // Formulário válido, pode prosseguir com cadastro ou salvar os dados
      final alunoData = {
        'nome': _nomeController.text.trim(),
        'email': _emailController.text.trim(),
        'dataNascimento': _dataNascimento?.toIso8601String(),
        'genero': _genero,
        'telefone': _telefoneController.text.trim(),
        'urlFoto': _urlFotoController.text.trim(),
        'instagram': _instagramController.text.trim(),
        'facebook': _facebookController.text.trim(),
        'tiktok': _tiktokController.text.trim(),
        'observacoes': _observacoesController.text.trim(),
        'ativo': _ativo,
      };

      // Aqui você pode fazer o que quiser com os dados: enviar para backend, salvar localmente etc.
      print('Aluno salvo: $alunoData');

      // Exemplo: exibir snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aluno salvo com sucesso!')),
      );

      // Opcional: limpar o formulário ou voltar
      // Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSalvar(
        titulo: 'Cadastro do Aluno',
        aoSalvar: _salvar,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CampoTexto(
                controle: _nomeController,
                rotulo: 'Nome',
                dica: 'Nome completo',
                eObrigatorio: true,
              ),
              const SizedBox(height: 12),
              CampoEmail(
                controle: _emailController,
                rotulo: 'E-mail',
                eObrigatorio: true,
              ),
              const SizedBox(height: 12),
              CampoData(
                label: 'Data de nascimento',
                valor: _dataNascimento,
                eObrigatorio: true,
                onChanged: (data) => setState(() => _dataNascimento = data),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Gênero',
                  border: OutlineInputBorder(),
                ),
                value: _genero,
                items: const [
                  DropdownMenuItem(value: 'masculino', child: Text('Masculino')),
                  DropdownMenuItem(value: 'feminino', child: Text('Feminino')),
                  DropdownMenuItem(value: 'outros', child: Text('Outros')),
                ],
                onChanged: (val) => setState(() => _genero = val),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Selecione o gênero';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              CampoTelefone(
                controle: _telefoneController,
                rotulo: 'Telefone',
                eObrigatorio: true,
              ),
              const SizedBox(height: 12),
              CampoUrl(
                controle: _urlFotoController,
                rotulo: 'URL da foto de perfil (opcional)',
                eObrigatorio: false,
              ),
              const SizedBox(height: 12),
              // Campos de redes sociais com ícones e validação condicional
              TextFormField(
                controller: _instagramController,
                decoration: InputDecoration(
                  labelText: 'Instagram (opcional)',
                  prefixIcon: _iconInstagram,
                  border: const OutlineInputBorder(),
                  hintText: 'https://instagram.com/usuario',
                ),
                keyboardType: TextInputType.url,
                validator: (value) => _validarUrlRedeSocial(value, 'Instagram'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _facebookController,
                decoration: InputDecoration(
                  labelText: 'Facebook (opcional)',
                  prefixIcon: _iconFacebook,
                  border: const OutlineInputBorder(),
                  hintText: 'https://facebook.com/usuario',
                ),
                keyboardType: TextInputType.url,
                validator: (value) => _validarUrlRedeSocial(value, 'Facebook'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _tiktokController,
                decoration: InputDecoration(
                  labelText: 'TikTok (opcional)',
                  prefixIcon: _iconTikTok,
                  border: const OutlineInputBorder(),
                  hintText: 'https://tiktok.com/@usuario',
                ),
                keyboardType: TextInputType.url,
                validator: (value) => _validarUrlRedeSocial(value, 'TikTok'),
              ),
              const SizedBox(height: 12),
              CampoTexto(
                controle: _observacoesController,
                rotulo: 'Observações',
                dica:  'opcional',
                maxLinhas: 4,
                eObrigatorio: false,
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Ativo'),
                value: _ativo,
                onChanged: (val) => setState(() => _ativo = val),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
