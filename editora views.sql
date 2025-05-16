-- VIEW 1: Funcionários e seus departamentos
CREATE VIEW vw_funcionarios_departamentos AS
SELECT f.NomeFunc, d.NomeDepartamento
FROM Funcionarios f
JOIN contato c ON f.CPF_Func = c.Funcionarios_CPF_Func
JOIN Departamento d ON c.Departamento_ID_Departamento = d.ID_Departamento;

SELECT * FROM vw_funcionarios_departamentos;

-- VIEW 2: Clientes de PE e seus bairros
CREATE VIEW vw_clientes_pe_bairros AS
SELECT c.Nome, e.Bairro
FROM clientes c
JOIN enderecocli e ON c.CPF = e.Clientes_CPF
WHERE e.UF = 'PE';

SELECT * FROM vw_clientes_pe_bairros;

-- VIEW 3: Livros e áreas do conhecimento
CREATE VIEW vw_livros_areas AS
SELECT l.Titulo, a.Descricao
FROM livros l
JOIN areasconhecimento a ON l.AreasConhecimento_idAreaConhecimento = a.idAreaConhecimento;

SELECT * FROM vw_livros_areas;

-- VIEW 4: Funcionários com salário acima da média
CREATE VIEW vw_funcionarios_acima_media AS
SELECT f.NomeFunc, f.salario
FROM Funcionarios f
WHERE f.salario > (SELECT AVG(salario) FROM Funcionarios);

SELECT * FROM vw_funcionarios_acima_media;

-- VIEW 5: Total de pedidos por cliente
CREATE VIEW vw_total_pedidos_clientes AS
SELECT c.Nome, COUNT(p.idPedidos) AS TotalPedidos
FROM clientes c
JOIN pedidos p ON c.CPF = p.Clientes_CPF
GROUP BY c.Nome;

SELECT * FROM vw_total_pedidos_clientes;

-- VIEW 6: Total de vendas por funcionário
CREATE VIEW vw_total_vendas_funcionarios AS
SELECT f.NomeFunc, COUNT(v.idVendas) AS TotalVendas
FROM Funcionarios f
JOIN Vendas v ON f.CPF_Func = v.Funcionarios_CPF_Func
GROUP BY f.NomeFunc;

SELECT * FROM vw_total_vendas_funcionarios;

-- VIEW 7: Quantidade de exemplares por livro
CREATE VIEW vw_exemplares_por_livro AS
SELECT l.Titulo, COUNT(e.NumeroSerie) AS ExemplaresDisponiveis
FROM livros l
JOIN exemplares e ON l.ISBN = e.Livros_ISBN1
GROUP BY l.Titulo;

SELECT * FROM vw_exemplares_por_livro;

-- VIEW 8: Funcionárias com carga horária > 35h
CREATE VIEW vw_funcionarias_ch_maior_35 AS
SELECT f.NomeFunc
FROM Funcionarios f
WHERE f.ch > 35 AND f.sexo = 'F';

SELECT * FROM vw_funcionarias_ch_maior_35;

-- VIEW 9: Localização de exemplares novos
CREATE VIEW vw_localizacao_exemplares_novos AS
SELECT l.Titulo, e.Localizacao
FROM livros l
JOIN exemplares e ON l.ISBN = e.Livros_ISBN1
WHERE e.Estado = 'novo';

SELECT * FROM vw_localizacao_exemplares_novos;

-- VIEW 10: Quantidade de livros por área do conhecimento
CREATE VIEW vw_qtd_livros_por_area AS
SELECT a.Descricao, COUNT(l.ISBN) AS TotalLivros
FROM areasconhecimento a
JOIN livros l ON a.idAreaConhecimento = l.AreasConhecimento_idAreaConhecimento
GROUP BY a.Descricao;

SELECT * FROM vw_qtd_livros_por_area;
