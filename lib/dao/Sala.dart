import 'package:sqflite/sqflite.dart';
import '../conexao.dart';
import '/../dto/dto_sala.dart';

class DAOSala {
  final String tabela = 'Sala';

  final String sqlCriarTabela = '''
    CREATE TABLE Sala (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      nome TEXT NOT NULL UNIQUE, 
      nome_sala TEXT, 
      numero_bike TEXT, 
      numero_fila TEXT, 
      bike_fila TEXT, 
      ativo INTEGER NOT NULL DEFAULT 1
    )
  ''';

  final String sqlInserir = '''
    INSERT INTO Sala (nome, nome_sala, numero_bike, numero_fila, bike_fila, ativo)
    VALUES (?, ?, ?, ?, ?, ?)
  ''';

  final String sqlAlterar = '''
    UPDATE Sala 
    SET nome = ?, nome_sala = ?, numero_bike = ?, numero_fila = ?, bike_fila = ?, ativo = ?
    WHERE id = ?
  ''';

  final String sqlConsultarTodos = '''
    SELECT * FROM Sala
  ''';

  final String sqlConsultarPorId = '''
    SELECT * FROM Sala WHERE id = ?
  ''';

  final String sqlExcluir = '''
    DELETE FROM Sala WHERE id = ?
  ''';

  Future<int> salvar(DTOSala dto) async {
    final db = await Conexao.get();
    try {
      if (dto.id == null) {
        return await db.insert(
          tabela,
          _toMap(dto),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      } else {
        return await db.update(
          tabela,
          _toMap(dto),
          where: 'id = ?',
          whereArgs: [dto.id],
        );
      }
    } catch (e) {
      throw Exception('Erro ao salvar ou alterar a sala: $e');
    }
  }

  Future<List<DTOSala>> consultarTodos() async {
    final db = await Conexao.get();
    try {
      final List<Map<String, dynamic>> resultado =
          await db.rawQuery(sqlConsultarTodos);
      return resultado.map((map) => _fromMap(map)).toList();
    } catch (e) {
      throw Exception('Erro ao consultar salas: $e');
    }
  }

  Future<DTOSala?> consultarPorId(int id) async {
    final db = await Conexao.get();
    try {
      final List<Map<String, dynamic>> resultado =
          await db.rawQuery(sqlConsultarPorId, [id]);
      if (resultado.isNotEmpty) {
        return _fromMap(resultado.first);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Erro ao consultar sala por ID: $e');
    }
  }

  Future<int> excluir(int id) async {
    final db = await Conexao.get();
    try {
      return await db.rawDelete(sqlExcluir, [id]);
    } catch (e) {
      throw Exception('Erro ao excluir sala: $e');
    }
  }

  Map<String, dynamic> _toMap(DTOSala dto) {
    return {
      'id': dto.id,
      'nome': dto.nome,
      'nome_sala': dto.nomeSala,
      'numero_bike': dto.numeroBike,
      'numero_fila': dto.numeroFila,
      'bike_fila': dto.bikeFila,
    };
  }

  DTOSala _fromMap(Map<String, dynamic> map) {
    return DTOSala(
      id: map['id'],
      nome: map['nome'],
      nomeSala: map['nome_sala'],
      numeroBike: map['numero_bike'],
      numeroFila: map['numero_fila'],
      bikeFila: map['bike_fila'],
    );
  }
}
