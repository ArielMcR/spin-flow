final _fabricante = '''
 CREATE TABLE fabricante (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT NOT NULL,
  descricao TEXT,
  nome_contato_principal TEXT,
  email_contato TEXT,
  telefone_contato TEXT,
  ativo INTEGER NOT NULL DEFAULT 1
);

''';
final _manutencao = '''

CREATE TABLE manutencao (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT NOT NULL UNIQUE,
  descricao TEXT,
  ativo INTEGER NOT NULL DEFAULT 1
);

''';

final criarTabelas = [_fabricante, _manutencao];

final insertFabricante = [
  '''
INSERT INTO fabricante (nome, descricao, nome_contato_principal, email_contato, telefone_contato, ativo)
VALUES (
  'Shimano',
  'Fabricante japonês de equipamentos de pesca de alta performance',
  'Kenji Nakamura',
  'kenji.n@shimano.jp',
  '(11) 99888-1122',
  1
);

INSERT INTO fabricante (nome, descricao, nome_contato_principal, email_contato, telefone_contato, ativo)
VALUES (
  'Daiwa',
  'Especialista em molinetes e varas de spinning',
  'Yuki Sato',
  'yuki.sato@daiwa.co.jp',
  '(21) 98877-3344',
  1
);

INSERT INTO fabricante (nome, descricao, nome_contato_principal, email_contato, telefone_contato, ativo)
VALUES (
  'Abu Garcia',
  'Marca sueca reconhecida por seu design e resistência',
  'Erik Jonsson',
  'erik.j@abugarcia.se',
  '(41) 97766-4455',
  1
);

INSERT INTO fabricante (nome, descricao, nome_contato_principal, email_contato, telefone_contato, ativo)
VALUES (
  'Okuma',
  'Fabricante de carretilhas e molinetes de alta qualidade',
  'Liu Zhang',
  'liu.z@okuma.com.tw',
  '(31) 96655-7788',
  1
);

INSERT INTO fabricante (nome, descricao, nome_contato_principal, email_contato, telefone_contato, ativo)
VALUES (
  'Penn',
  'Empresa americana com tradição em equipamentos para pesca pesada e spinning oceânico',
  'John Carter',
  'john.c@pennfishing.com',
  '(51) 95544-2233',
  1
);

'''
];
