import 'package:flutter/material.dart';

class AppBarSalvar extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;
  final VoidCallback aoSalvar;
  final String dicaAcao;

  const AppBarSalvar({
    Key? key,
    required this.titulo,
    required this.aoSalvar,
    this.dicaAcao = 'Salvar',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // A seta de voltar aparece automaticamente se houver rota anterior
      title: Text(titulo),
      actions: [
        IconButton(
          onPressed: aoSalvar,
          icon: const Icon(Icons.add),
          tooltip: dicaAcao,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
