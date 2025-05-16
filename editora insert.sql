/*Comando INSERT*/
-- Funcionario
INSERT INTO Funcionarios (CPF_Func, NomeFunc, sexo, dataNasc, ch, salario, dataAdm) VALUES
('12345678901', 'Ana Lima', 'F', '1985-06-12', 40, 3200.00, '2010-01-15'),
('23456789012', 'Carlos Souza', 'M', '1979-08-23', 40, 4500.00, '2005-03-20'),
('34567890123', 'João Pedro', 'M', '1990-05-10', 40, 2800.00, '2018-07-01'),
('45678901234', 'Maria Rosa', 'F', '1982-12-30', 40, 3900.00, '2012-11-02'),
('56789012345', 'Lucas Braga', 'M', '1995-09-15', 40, 2500.00, '2020-06-17'),
('67890123456', 'Fernanda Lopes', 'F', '1988-03-05', 40, 4200.00, '2015-04-12'),
('78901234567', 'Roberto Dias', 'M', '1975-07-20', 40, 5000.00, '2001-09-09'),
('89012345678', 'Paula Castro', 'F', '1993-01-25', 40, 3000.00, '2017-01-05'),
('90123456789', 'André Moura', 'M', '1998-04-16', 40, 2700.00, '2021-05-20'),
('01234567890', 'Juliana Alves', 'F', '1987-11-14', 40, 3800.00, '2013-08-25');

-- EnderecoFunc
INSERT INTO EnderecoFunc (Funcionarios_CPF_Func, uf, cidade, bairro, rua, numero, comp, cep) VALUES
('12345678901', 'PE', 'Recife', 'Boa Vista', 'Rua A', 123, "casa", '50000-000'),
('23456789012', 'PE', 'Recife', 'Madalena', 'Rua B', 234, "casa", '50010-000'),
('34567890123', 'PE', 'Recife', 'Casa Forte', 'Rua C', 345, "casa", '50020-000'),
('45678901234', 'PE', 'Recife', 'Derby', 'Rua D', 456, "apartamento", '50030-000'),
('56789012345', 'PE', 'Recife', 'Pina', 'Rua E', 567, "apartamento", '50040-000'),
('67890123456', 'PE', 'Recife', 'Espinheiro', 'Rua F', 678, "casa", '50050-000'),
('78901234567', 'PE', 'Recife', 'Tamarineira', 'Rua G', 789, "apartamento", '50060-000'),
('89012345678', 'PE', 'Recife', 'Graças', 'Rua H', 890, "apartamento", '50070-000'),
('90123456789', 'PE', 'Recife', 'Rosarinho', 'Rua I', 901, "casa", '50080-000'),
('01234567890', 'PE', 'Recife', 'Torre', 'Rua J', 101, "casa", '50090-000');

-- Departamento
INSERT INTO Departamento (ID_Departamento, NomeDepartamento, Descricao_Departamento) VALUES
(1, 'Editorial', 'aran beber'),      
(2, 'Produção', 'aran beber'),       
(3, 'Vendas', 'aran beber'),        
(4, 'Marketing', 'aran beber'),    
(5, 'TI', 'aran beber'),          
(6, 'RH', 'aran beber'),            
(7, 'Financeiro', 'aran beber'),     
(8, 'Atendimento', 'aran beber'),    
(9, 'Distribuição', 'aran beber'),   
(10, 'Logística', 'aran beber');     

-- Clientes
INSERT INTO clientes (CPF, Nome, Sexo) VALUES
('12345678901', 'Marina Diamandis', 'F'),
('23456789012', 'Anitta Deposy', 'F'),
('34567890123', 'Lady Gaga', 'F'),
('45678901234', 'Lorde', 'M'),
('56789012345', 'Afonsa Rocha', 'F'),
('67890123456', 'Lulu do Lol', 'M'),
('78901234567', 'Charli', 'F'),
('89012345678', 'Renato Glasc', 'M'),
('90123456789', 'Lux Rata', 'F'),
('01234567890', 'Daniela Infeliz', 'F');

-- EnderecoCli
INSERT INTO enderecocli (Clientes_CPF, UF, Cidade, Bairro, Rua, Numero, Comp, CEP) VALUES
('12345678901', 'PE', 'Recife', 'Boa Viagem', 'Av. Recife', 1, 'casa', '51461-093'),
('23456789012', 'PE', 'Recife', 'Imbiribeira', 'Rua Recife', 2, 'casa', '56591-020'),
('34567890123', 'PE', 'Recife', 'Piedade', 'Rua Piedade', 3, 'casa', '51220-546'),
('45678901234', 'PE', 'Recife', 'Ibura', 'Rua Ibura', 4, 'apartamento', '51063-250'),
('56789012345', 'PE', 'Recife', 'Areias', 'Rua Areias', 5, 'casa', '51040-090'),
('67890123456', 'PE', 'Recife', 'Afogados', 'Rua Afogados', 6, 'apartamento', '50970-070'),
('78901234567', 'PE', 'Recife', 'Cordeiro', 'Rua Cordeiro', 7, 'apartamento', '51060-020'),
('89012345678', 'PE', 'Recife', 'Torre', 'Rua Torre', 8, 'casa', '51070-050'),
('90123456789', 'PE', 'Recife', 'Tamarineira', 'Rua Tam', 9, 'casa', '59630-060'),
('01234567890', 'PE', 'Recife', 'Derby', 'Rua Derby', 10, 'apartamento', '54560-000');

-- Contato
INSERT INTO contato (idContato, Email, Telefone, Departamento_ID_Departamento, Funcionarios_CPF_Func, Clientes_CPF) VALUES
(1, 'juju@editora.com', '8199990001', 1, '12345678901', '87293048193'),
(2, 'carlotta@editora.com', '8199990002', 1, '23456789012', '98743587132'),
(3, 'joao@editora.com', '8199990003', 2, '34567890123', '12341238743'),
(4, 'muzy@editora.com', '8199990004', 2, '45678901234', '12983476234'),
(5, 'juliana@editora.com', '8199990005', 3, '56789012345', '98098743254'),
(6, 'isa@editora.com', '8199990006', 3, '67890123456', '23789234214'),
(7, 'fulano@email.com', '8199990010', 2, '98098789123', '12345678901'),
(8, 'anne@email.com', '8199990011', 1, '12873245123', '23456789012'),
(9, 'juliette@email.com', '8199990012', 2, '12873241987', '34567890123'),
(10, 'karol@email.com', '8199990013', 1, '12312345123', '45678901234');

-- AreasConhecimento
INSERT INTO areasconhecimento (idAreaConhecimento, Descricao) VALUES
(1, 'Estudo da literatura e cultura brasileira'),
(2, 'Programação, IA e sistemas computacionais'),
(3, 'Gestão, finanças e marketing organizacional'),
(4, 'Comportamento humano e mente em foco'),
(5, 'Ensino, pedagogia e políticas educacionais'),
(6, 'Matemática aplicada e estruturas abstratas'),
(7, 'Filosofia: ética, lógica e existência'),
(8, 'História das sociedades e transformações'),
(9, 'Biologia: vida, ecossistemas e evolução'),
(10, 'Química: matéria e suas transformações');

-- Livros
INSERT INTO livros (ISBN, Titulo, DataPublicacao, Genero, Numero_Paginas, Descricao, AreaConhecimento, AreasConhecimento_idAreaConhecimento) VALUES
('9780000000011', 'Dom Casmurro', '1899-01-01', 'Romance', 256, 'Clássico da literatura brasileira.', 1, 2),
('9780000000012', 'O Cortiço', '1890-08-15', 'Naturalismo', 304, 'Romance que retrata o cotidiano.', 1, 3),
('9780000000013', 'Lógica de Programação', '2016-05-20', 'Tecnologia', 420, 'Aprenda lógica de programação com exercícios.', 2, 4),
('9780000000014', 'Banco de Dados para Iniciantes', '2018-02-10', 'Tecnologia', 350, 'Conceitos básicos de bdd relacionais.', 2, 2),
('9780000000015', 'Introdução à Administração', '2020-01-05', 'Negócios', 298, 'Conceitos de administração.', 3, 2),
('9780000000016', 'Marketing Digital na Prática', '2021-09-10', 'Negócios', 270, 'Ferramentas e estratégias de mkt.', 3, 3),
('9780000000017', 'Teorias da Aprendizagem', '2017-08-15', 'Educação', 310, 'Estudos sobre como aprendemos.', 4, 3),
('9780000000018', 'Didática Moderna', '2022-01-20', 'Educação', 260, 'Técnicas de ensino para o século XXI.', 4, 1),
('9780000000019', 'Fundamentos da Psicologia', '2019-04-11', 'Psicologia', 400, 'Principais abordagens e teorias.', 5, 1),
('9780000000020', 'Psicologia do Desenvolvimento', '2020-06-30', 'Psicologia', 390, 'Fases do desenvolvimento humano.', 5, 2);


-- Exemplares
INSERT INTO exemplares (NumeroSerie, Estado, Localizacao, Livros_ISBN1) VALUES
(1, 'novo', 'Estante A1', '9780000000011'),
(2, 'usado', 'Estante A1', '9780000000011'),
(3, 'novo', 'Estante A2', '9780000000012'),
(4, 'novo', 'Estante B1', '9780000000013'),
(5, 'novo', 'Estante B1', '9780000000013'),
(6, 'usado', 'Estante C3', '9780000000014'),
(7, 'novo', 'Estante D2', '9780000000015'),
(8, 'novo', 'Estante D2', '9780000000015'),
(9, 'novo', 'Estante D2', '9780000000015'),
(10, 'novo', 'Estante E1', '9780000000016'),
(11, 'usado', 'Estante F3', '9780000000017'),
(12, 'novo', 'Estante G1', '9780000000018'),
(13, 'novo', 'Estante G1', '9780000000018'),
(14, 'novo', 'Estante G1', '9780000000018'),
(15, 'usado', 'Estante H4', '9780000000019'),
(16, 'novo', 'Estante I2', '9780000000020'),
(17, 'novo', 'Estante I2', '9780000000020'),
(18, 'novo', 'Estante J1', '9780000000011'),
(19, 'novo', 'Estante J1', '9780000000011'),
(20, 'novo', 'Estante J1', '9780000000011'),
(21, 'novo', 'Estante K3', '9780000000012'),
(22, 'novo', 'Estante L1', '9780000000013'),
(23, 'novo', 'Estante L1', '9780000000013'),
(24, 'novo', 'Estante L1', '9780000000013'),
(25, 'usado', 'Estante M2', '9780000000014'),
(26, 'novo', 'Estante N1', '9780000000015'),
(27, 'novo', 'Estante N1', '9780000000015'),
(28, 'novo', 'Estante O3', '9780000000016'),
(29, 'novo', 'Estante P2', '9780000000017'),
(30, 'usado', 'Estante P2', '9780000000017'),
(31, 'novo', 'Estante Q1', '9780000000018'),
(32, 'novo', 'Estante Q1', '9780000000018'),
(33, 'usado', 'Estante Q1', '9780000000018'),
(34, 'novo', 'Estante R4', '9780000000019'),
(35, 'novo', 'Estante S1', '9780000000020'),
(36, 'usado', 'Estante S1', '9780000000020'),
(37, 'novo', 'Estante S1', '9780000000020');

-- Pedidos
INSERT INTO pedidos (idPedidos, DataPedido, `Status`, Clientes_CPF) VALUES
(1, '2022-01-15', 'concluído', 10187342131),
(2, '2023-03-25', 'pendente', 10298734921),
(3, '2014-05-29', 'cancelado', 10198347823),
(4, '2019-02-25', 'concluído', 10218934714),
(5, '2022-02-05', 'pendente', 10598478312),
(6, '2024-02-23', 'concluído', 10989462346),
(7, '2025-02-27', 'concluído', 10278374917),
(8, '2023-02-26', 'cancelado', 10198398248),
(9, '2025-02-13', 'pendente', 10939840122),
(10, '2022-03-11', 'concluído', 11049832415);

-- Vendas
INSERT INTO Vendas (idVendas, DataVenda, Valor, Desconto, Funcionarios_CPF_Func, Pedidos_idPedidos1) VALUES
(1, '2024-01-16', 45.90, 5.00, '56789012345', 1),
(2, '2024-01-21', 89.90, 0.00, '67890123456', 2),
(3, '2024-01-26', 65.00, 3.00, '56789012345', 3),
(4, '2024-02-02', 72.50, 2.50, '67890123456', 4),
(5, '2024-02-06', 59.90, 0.00, '56789012345', 5),
(6, '2024-02-11', 78.00, 4.00, '67890123456', 6),
(7, '2024-02-16', 38.00, 1.00, '56789012345', 7),
(8, '2024-02-21', 49.90, 0.00, '67890123456', 8),
(9, '2024-02-26', 88.80, 8.80, '56789012345', 9),
(10, '2024-03-02', 92.00, 7.00, '67890123456', 10),
(11, '2024-03-10', 55.20, 3.00, '56789012345', 11),
(12, '2024-03-12', 120.00, 10.00, '67890123456', 12),
(13, '2024-03-15', 75.50, 5.50, '56789012345', 13),
(14, '2024-03-18', 90.00, 0.00, '67890123456', 14),
(15, '2024-03-20', 60.00, 4.00, '56789012345', 15),
(16, '2024-03-22', 82.30, 2.30, '67890123456', 16),
(17, '2024-03-25', 49.00, 0.00, '56789012345', 17),
(18, '2024-03-28', 105.00, 7.00, '67890123456', 18),
(19, '2024-03-30', 115.50, 5.50, '56789012345', 19),
(20, '2024-04-01', 70.00, 3.50, '67890123456', 20);

-- FormaPag
INSERT INTO FormaPag (idFormaPag, Tipo, ValorPago, Vendas_idVendas) VALUES
(1, 'Crédito', 20.00, 1),
(2, 'Débito', 15.50, 2),
(3, 'Boleto', 150.00, 3),
(4, 'Pix', 450.00, 4),
(5, 'Crédito', 330.00, 5),
(6, 'Pix', 1.50, 6),
(7, 'Crédito', 220.00, 7),
(8, 'Débito', 15.00, 8),
(9, 'Boleto', 18.90, 9),
(10, 'Crédito', 1.47, 10);

-- Autor
INSERT INTO autores (CPF_Autor, Nome, Biografia, Nacionalidade, DataNasc) VALUES
('111.222.333-44', 'Luis Fernando', 'Escritor brasileiro renomado', 'Brasileiro', '1970-05-15'),
('222.333.444-55', 'Marina Torres', 'Especialista em computação', 'Brasileira', '1982-08-30'),
('333.444.555-66', 'Roberta Dias', 'Consultora em administração', 'Brasileira', '1975-11-20'),
('444.555.666-77', 'Paulo Mendes', 'Psicólogo clínico', 'Brasileiro', '1968-01-05'),
('555.666.777-88', 'Jéssica Ramos', 'Pedagoga e educadora', 'Brasileira', '1985-03-12'),
('666.777.888-99', 'André Lima', 'Professor de matemática', 'Brasileiro', '1972-09-17'),
('777.888.999-00', 'Bianca Souza', 'Filósofa e escritora', 'Brasileira', '1980-12-25'),
('888.999.000-11', 'Carlos Braga', 'Historiador e pesquisador', 'Brasileiro', '1965-07-08'),
('999.000.111-22', 'Luciana Rocha', 'Bióloga marinha', 'Brasileira', '1978-04-22'),
('000.111.222-33', 'Henrique Farias', 'Químico especializado em materiais', 'Brasileiro', '1969-10-11');

-- LivroAutores
INSERT INTO livroautores (Livros_ISBN, Autores_CPF_Autor) VALUES
('9780000000011', '111.222.333-44'),
('9780000000012', '222.333.444-55'),
('9780000000013', '333.444.555-66'),
('9780000000014', '444.555.666-77'),
('9780000000015', '555.666.777-88'),
('9780000000016', '666.777.888-99'),
('9780000000017', '777.888.999-00'),
('9780000000018', '888.999.000-11'),
('9780000000019', '999.000.111-22'),
('9780000000020', '000.111.222-33');

-- PalavraChave
INSERT INTO palavrachave (idPalavraChave, Palavra, Significado) VALUES
(1, 'literatura', 'Conjunto de poesias e ensaios'),
(2, 'algoritmo', 'Conjunto de passos para realizar uma tarefa'),
(3, 'gestão', 'Processo de planejar, e controlar recursos'),
(4, 'psicologia', 'Estudo científico de processos mentais'),
(5, 'educação', 'Processo de aprender habilidades e valores'),
(6, 'cálculo', 'Ramo que estuda taxas de variaçãoo'),
(7, 'ética', 'Ramo que analisa os princípios morais'),
(8, 'história', 'Estudo dos eventos passados'),
(9, 'genética', 'Ramo da biologia que estuda a hereditariedade'),
(10, 'química', 'Ciência que estuda a composição da matéria');

-- LivroPalavras (exemplo com palavras-chave)
INSERT INTO LivroPalavras (Livros_ISBN1, PalavraChave_idPalavraChave) VALUES
('9780000000011', 1),
('9780000000012', 2),
('9780000000013', 3),
('9780000000014', 4),
('9780000000015', 5),
('9780000000016', 6),
('9780000000017', 7),
('9780000000018', 8),
('9780000000019', 9),
('9780000000020', 10);