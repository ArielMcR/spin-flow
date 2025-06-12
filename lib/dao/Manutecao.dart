import 'package:spin_flow/banco/sqlite/conexao.dart';
import 'package:spin_flow/dto/ManutencaoDTO.dart';
import 'package:sqflite/sqflite.dart';
import 'package:spin_flow/dto/dto.dart';

class DAOManutencao {
  final String sqlInserir = '''
    INSERT INTO manutencao (nome, descricao, ativo)
    VALUES (?, ?, ?)
  ''';

  final String sqlAlterar = '''
    UPDATE manutencao
    SET nome = ?, descricao = ?, ativo = ?
    WHERE id = ?
  ''';

  final String sqlConsultarTodos = '''
    SELECT * FROM manutencao
  ''';

  final String sqlConsultarPorId = '''
    SELECT * FROM manutencao WHERE id = ?
  ''';

  final String sqlExcluir = '''
    DELETE FROM manutencao WHERE id = ?
  ''';

  Future<void> salvar(DTOManutencao manutencao) async {
    final db = await Conexao.get();
    if (manutencao.id == null) {
      await db.rawInsert(sqlInserir,
          [manutencao.nome, manutencao.descricao, manutencao.ativo ? 1 : 0]);
    } else {
      await db.rawUpdate(sqlAlterar, [
        manutencao.nome,
        manutencao.descricao,
        manutencao.ativo ? 1 : 0,
        manutencao.id
      ]);
    }
  }

  Future<List<DTOManutencao>> consultarTodos() async {
    final db = await Conexao.get();
    final resultado = await db.rawQuery(sqlConsultarTodos);
    return resultado.map((map) => mapToDTO(map)).toList();
  }

  Future<DTOManutencao?> consultarPorId(int id) async {
    final db = await Conexao.get();
    final resultado = await db.rawQuery(sqlConsultarPorId, [id]);
    if (resultado.isEmpty) return null;
    return mapToDTO(resultado.first);
  }

  Future<void> excluir(int id) async {
    final db = await Conexao.get();
    await db.rawDelete(sqlExcluir, [id]);
  }

  DTOManutencao mapToDTO(Map<String, dynamic> map) {
    return DTOManutencao(
      id: map['id'] as int?,
      nome: map['nome'] as String,
      descricao: map['descricao'] as String?,
      ativo: (map['ativo'] ?? 1) == 1,
    );
  }

  Map<String, dynamic> dtoToMap(DTOManutencao dto) {
    return {
      'id': dto.id,
      'nome': dto.nome,
      'descricao': dto.descricao,
      'ativo': dto.ativo ? 1 : 0
    };
  }
}
