import 'package:spin_flow/banco/sqlite/conexao.dart';
import 'package:spin_flow/dto/dto_fabricante.dart';
import 'package:sqflite/sqflite.dart';

class DAOFabricante {
  final String sqlInserir = '''
    INSERT INTO Fabricante (
      nome, descricao, nome_contato_principal,
      email_contato, telefone_contato, ativo
    ) VALUES (?, ?, ?, ?, ?, ?)
  ''';

  final String sqlAlterar = '''
    UPDATE Fabricante SET
      nome = ?, descricao = ?, nome_contato_principal = ?,
      email_contato = ?, telefone_contato = ?, ativo = ?
    WHERE id = ?
  ''';

  final String sqlConsultarTodos = '''
    SELECT * FROM Fabricante
  ''';

  final String sqlConsultarPorId = '''
    SELECT * FROM Fabricante WHERE id = ?
  ''';

  final String sqlExcluir = '''
    DELETE FROM Fabricante WHERE id = ?
  ''';

  Future<void> salvar(DTOFabricante fabricante) async {
    final db = await Conexao.get();
    if (fabricante.id == null) {
      await db.rawInsert(sqlInserir, [
        fabricante.nome,
        fabricante.descricao,
        fabricante.nomeContatoPrincipal,
        fabricante.emailContato,
        fabricante.telefoneContato,
        fabricante.ativo ? 1 : 0
      ]);
    } else {
      await db.rawUpdate(sqlAlterar, [
        fabricante.nome,
        fabricante.descricao,
        fabricante.nomeContatoPrincipal,
        fabricante.emailContato,
        fabricante.telefoneContato,
        fabricante.ativo ? 1 : 0,
        fabricante.id
      ]);
    }
  }

  Future<List<DTOFabricante>> consultarTodos() async {
    final db = await Conexao.get();
    final resultado = await db.rawQuery(sqlConsultarTodos);
    return resultado.map((map) => mapToDTO(map)).toList();
  }

  Future<DTOFabricante?> consultarPorId(int id) async {
    final db = await Conexao.get();
    final resultado = await db.rawQuery(sqlConsultarPorId, [id]);
    if (resultado.isEmpty) return null;
    return mapToDTO(resultado.first);
  }

  Future<void> excluir(int id) async {
    final db = await Conexao.get();
    await db.rawDelete(sqlExcluir, [id]);
  }

  DTOFabricante mapToDTO(Map<String, dynamic> map) {
    return DTOFabricante(
        id: map['id'] as int?,
        nome: map['nome'] as String,
        descricao: map['descricao'] as String?,
        nomeContatoPrincipal: map['nome_contato_principal'] as String?,
        emailContato: map['email_contato'] as String?,
        telefoneContato: map['telefone_contato'] as String?,
        ativo: (map['ativo'] ?? 1) == 1);
  }

  Map<String, dynamic> dtoToMap(DTOFabricante dto) {
    return {
      'id': dto.id,
      'nome': dto.nome,
      'descricao': dto.descricao,
      'nome_contato_principal': dto.nomeContatoPrincipal,
      'email_contato': dto.emailContato,
      'telefone_contato': dto.telefoneContato,
      'ativo': dto.ativo ? 1 : 0
    };
  }
}
