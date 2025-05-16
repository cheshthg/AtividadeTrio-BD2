-- CONSULTAS DO PROJETO --

-- Consulta 1
SELECT f.NomeFunc, d.NomeDepartamento
FROM Funcionarios f
JOIN contato c ON f.CPF_Func = c.Funcionarios_CPF_Func
JOIN Departamento d ON c.Departamento_ID_Departamento = d.ID_Departamento;

-- Consulta 2
SELECT c.Nome, e.Bairro
FROM clientes c
JOIN enderecocli e ON c.CPF = e.Clientes_CPF
WHERE e.UF = 'PE';

-- Consulta 3
SELECT l.Titulo, a.Descricao
FROM livros l
JOIN areasconhecimento a ON l.AreasConhecimento_idAreaConhecimento = a.idAreaConhecimento;

-- Consulta 4
SELECT f.NomeFunc, f.salario
FROM Funcionarios f
WHERE f.salario > (SELECT AVG(salario) FROM Funcionarios);

-- Consulta 5
SELECT c.Nome, COUNT(p.idPedidos) AS TotalPedidos
FROM clientes c
JOIN pedidos p ON c.CPF = p.Clientes_CPF
GROUP BY c.Nome;

-- Consulta 6
SELECT f.NomeFunc, COUNT(v.idVendas) AS TotalVendas
FROM Funcionarios f
JOIN Vendas v ON f.CPF_Func = v.Funcionarios_CPF_Func
GROUP BY f.NomeFunc;

-- Consulta 7
SELECT l.Titulo, COUNT(e.NumeroSerie) AS ExemplaresDisponiveis
FROM livros l
JOIN exemplares e ON l.ISBN = e.Livros_ISBN1
GROUP BY l.Titulo;

-- Consulta 8
SELECT f.NomeFunc, e.cidade
FROM Funcionarios f
JOIN EnderecoFunc e ON f.CPF_Func = e.Funcionarios_CPF_Func
WHERE e.Bairro = 'Boa Vista';

-- Consulta 9
SELECT c.Nome, p.DataPedido
FROM clientes c
JOIN pedidos p ON c.CPF = p.Clientes_CPF
WHERE p.Status = 'concluído';

-- Consulta 10
SELECT l.Titulo
FROM livros l
WHERE l.Numero_Paginas = (SELECT MAX(Numero_Paginas) FROM livros);

-- Consulta 11
SELECT d.NomeDepartamento, COUNT(f.CPF_Func) AS TotalFuncionarios
FROM Departamento d
JOIN contato c ON d.ID_Departamento = c.Departamento_ID_Departamento
JOIN Funcionarios f ON c.Funcionarios_CPF_Func = f.CPF_Func
GROUP BY d.NomeDepartamento;

-- Consulta 12
SELECT AVG(v.Valor - v.Desconto) AS MediaVendaLiquida
FROM Vendas v;

-- Consulta 13
SELECT DISTINCT c.Email
FROM contato c
WHERE c.Email LIKE '%@editora.com';

-- Consulta 14
SELECT f.NomeFunc, f.dataAdm
FROM Funcionarios f
ORDER BY f.dataAdm ASC
LIMIT 1;

-- Consulta 15
SELECT c.Nome, COUNT(v.idVendas) AS TotalCompras
FROM clientes c
JOIN pedidos p ON c.CPF = p.Clientes_CPF
JOIN Vendas v ON p.idPedidos = v.Pedidos_idPedidos1
GROUP BY c.Nome;

-- Consulta 16
SELECT l.Titulo, e.Localizacao
FROM livros l
JOIN exemplares e ON l.ISBN = e.Livros_ISBN1
WHERE e.Estado = 'novo';

-- Consulta 17
SELECT a.Descricao, COUNT(l.ISBN) AS TotalLivros
FROM areasconhecimento a
JOIN livros l ON a.idAreaConhecimento = l.AreasConhecimento_idAreaConhecimento
GROUP BY a.Descricao;

-- Consulta 18
SELECT f.NomeFunc
FROM Funcionarios f
WHERE f.ch > 35 AND f.sexo = 'F';

-- Consulta 19
SELECT l.Titulo, l.Genero
FROM livros l
WHERE l.Genero IN ('Romance', 'Tecnologia');

-- Consulta 20
SELECT f.NomeFunc, v.Valor
FROM Funcionarios f
JOIN Vendas v ON f.CPF_Func = v.Funcionarios_CPF_Func
WHERE v.Valor > 80.00;
