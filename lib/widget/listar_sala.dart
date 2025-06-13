import 'package:flutter/material.dart';
import 'package:spin_flow/dto/dto.dart';

// Mock de dados para DTOSala
List<DTOSala> mockSalas = [
  DTOSala(
      id: 1,
      nome: "Sala A",
      nomeSala: "Sala 1",
      numeroBike: "B1",
      numeroFila: "F1",
      bikeFila: "BF1"),
  DTOSala(
      id: 2,
      nome: "Sala B",
      nomeSala: "Sala 2",
      numeroBike: "B2",
      numeroFila: "F2",
      bikeFila: "BF2"),
  DTOSala(
      id: 3,
      nome: "Sala C",
      nomeSala: "Sala 3",
      numeroBike: "B3",
      numeroFila: "F3",
      bikeFila: "BF3"),
];

// Widget ListaSala
class ListaSala extends StatelessWidget {
  const ListaSala({Key? key}) : super(key: key);

  // Método para alterar, que exibe o DTO no ScaffoldMessenger
  void alterar(BuildContext context, DTOSala dto) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Alterando ${dto.nomeSala}')),
    );
  }

  // Método para excluir, que exibe o DTO no ScaffoldMessenger
  void excluir(BuildContext context, DTOSala dto) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Excluindo ${dto.nomeSala}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Salas')),
      body: FutureBuilder<List<DTOSala>>(
        // Aqui você pode substituir o mockSalas por uma consulta ao banco de dados
        future: Future.delayed(Duration(seconds: 2),
            () => mockSalas), // Simulando um futuro com delay
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar dados.'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhuma sala disponível.'));
          }

          final salas = snapshot.data!;

          return ListView.builder(
            itemCount: salas.length,
            itemBuilder: (context, index) {
              final sala = salas[index];
              return ListTile(
                title: Text(sala.nomeSala ?? 'Sem nome'),
                subtitle:
                    Text('Bike: ${sala.numeroBike}, Fila: ${sala.numeroFila}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.orange),
                      onPressed: () => alterar(context, sala),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => excluir(context, sala),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ListaSala(),
  ));
}
