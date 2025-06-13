import 'package:spin_flow/banco/sqlite/conexao.dart';
import 'package:spin_flow/dto/dto_categoria_musica.dart';
import 'package:sqflite/sqflite.dart';

class DAOCategoriaMusica {
  final String sqlInserir = '''
    INSERT INTO categoria_musica (
    nome, nomeCategoria, descricao, ativo)
    VALUES (?, ?, ?, ?)
  ''';

  final String sqlAlterar = '''
    UPDATE categoria_musica
    SET nome = ?, nomeCategoria = ?, descricao = ?, ativo = ?
    WHERE id = ?
  ''';

  final String sqlConsultarTodos = '''
    SELECT * FROM categoria_musica
  ''';

  final String sqlConsultarPorId = '''
    SELECT * FROM categoria_musica WHERE id = ?
  ''';

  final String sqlExcluir = '''
    DELETE FROM categoria_musica WHERE id = ?
  ''';

  Future<void> salvar(DTOCategoriaMusica categoria) async {
    final db = await Conexao.get();
    if (categoria.id == null) {
      await db.rawInsert(sqlInserir, [
        categoria.nome,
        categoria.nomeCategoria,
        categoria.descricao,
        categoria.ativo ? 1 : 0
      ]);
    } else {
      await db.rawUpdate(sqlAlterar, [
        categoria.nome,
        categoria.nomeCategoria,
        categoria.descricao,
        categoria.ativo ? 1 : 0,
        categoria.id
      ]);
    }
  }

  Future<List<DTOCategoriaMusica>> consultarTodos() async {
    final db = await Conexao.get();
    final resultado = await db.rawQuery(sqlConsultarTodos);
    return resultado.map(mapToDTO).toList();
  }

  Future<DTOCategoriaMusica?> consultarPorId(int id) async {
    final db = await Conexao.get();
    final resultado = await db.rawQuery(sqlConsultarPorId, [id]);
    if (resultado.isEmpty) return null;
    return mapToDTO(resultado.first);
  }

  Future<void> excluir(int id) async {
    final db = await Conexao.get();
    await db.rawDelete(sqlExcluir, [id]);
  }

  DTOCategoriaMusica mapToDTO(Map<String, dynamic> map) {
    return DTOCategoriaMusica(
      id: map['id'] as int?,
      nome: map['nome'] as String,
      nomeCategoria: map['nomeCategoria'] as String?,
      descricao: map['descricao'] as String?,
      ativo: (map['ativo'] ?? 1) == 1,
    );
  }

  Map<String, dynamic> dtoToMap(DTOCategoriaMusica dto) {
    return {
      'id': dto.id,
      'nome': dto.nome,
      'nomeCategoria': dto.nomeCategoria,
      'descricao': dto.descricao,
      'ativo': dto.ativo ? 1 : 0
    };
  }
}
