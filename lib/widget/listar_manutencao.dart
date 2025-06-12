import 'package:flutter/material.dart';
import 'package:spin_flow/dao/Manutecao.dart';
import 'package:spin_flow/dto/ManutencaoDTO.dart';

class ListarManutencao extends StatefulWidget {
  const ListarManutencao({Key? key}) : super(key: key);

  @override
  State<ListarManutencao> createState() => _ListarManutencaoState();
}

class _ListarManutencaoState extends State<ListarManutencao> {
  final DAOManutencao dao = DAOManutencao();
  List<DTOManutencao> lista = [];

  @override
  void initState() {
    super.initState();
    carregarLista();
  }

  Future<void> carregarLista() async {
    final dados = await dao.consultarTodos();
    setState(() => lista = dados);
  }

  void alterar(DTOManutencao dto) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Alterar: ${dto.nome}')),
    );
  }

  void excluir(DTOManutencao dto) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Excluir: ${dto.nome}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Manutenções')),
      body: ListView.builder(
        itemCount: lista.length,
        itemBuilder: (context, index) {
          final dto = lista[index];
          return ListTile(
            title: Text(dto.nome),
            subtitle: Text(dto.descricao ?? 'Sem descrição'),
            trailing: Wrap(
              spacing: 8,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.orange),
                  onPressed: () => alterar(dto),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => excluir(dto),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
