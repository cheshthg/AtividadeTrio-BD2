-- Testando a função CalcularIdadeLivro
-- Deve retornar a idade em anos do livro com o ISBN fornecido.
SELECT '9780000000011' AS ISBN, CalcularIdadeLivro('9780000000011') AS IdadeDoLivro;
SELECT '9780000000012' AS ISBN, CalcularIdadeLivro('9780000000012') AS IdadeDoLivro;
SELECT '9780000000020' AS ISBN, CalcularIdadeLivro('9780000000020') AS IdadeDoLivro; -- Teste com um ISBN que pode não existir ou ter data de publicação diferente.

-- Testando a função GetProximoNumeroSerieExemplar
-- Deve retornar o próximo número de série disponível para o livro.
-- Se o livro já tiver exemplares, deve ser MAX(NumeroSerie) + 1. Se não, deve ser 1.
SELECT '9780000000011' AS ISBN, GetProximoNumeroSerieExemplar('9780000000011') AS ProximoNumeroSerie;
SELECT '9780000000012' AS ISBN, GetProximoNumeroSerieExemplar('9780000000012') AS ProximoNumeroSerie;
SELECT '9780000000099' AS ISBN, GetProximoNumeroSerieExemplar('9780000000099') AS ProximoNumeroSerie; -- Teste com ISBN sem exemplares.

-- Inserir um exemplar para o livro '9780000000099' para testar o incremento do GetProximoNumeroSerieExemplar
-- (Você pode pular isso se já tiver exemplares para o livro)
-- INSERT INTO Exemplares (NumeroSerie, Livros_ISBN1, Estado, Localizacao) VALUES (1, '9780000000099', 'novo', 'Estante A1');
-- SELECT '9780000000099' AS ISBN, GetProximoNumeroSerieExemplar('9780000000099') AS ProximoNumeroSerieAposInsercao;


-- Testando a função ContarAutoresLivro
-- Deve retornar o número de autores associados a um livro.
SELECT '9780000000011' AS ISBN, ContarAutoresLivro('9780000000011') AS TotalDeAutores;
SELECT '9780000000015' AS ISBN, ContarAutoresLivro('9780000000015') AS TotalDeAutores;
SELECT '9780000000099' AS ISBN, ContarAutoresLivro('9780000000099') AS TotalDeAutores; -- Teste com ISBN sem autores.

-- Testando a função CalcularMediaAvaliacaoLivro
-- Deve retornar a média das notas de avaliação para o livro.
-- Se não houver avaliações, deve retornar 0.00.
SELECT '9780000000011' AS ISBN, CalcularMediaAvaliacaoLivro('9780000000011') AS MediaAvaliacao;
SELECT '9780000000012' AS ISBN, CalcularMediaAvaliacaoLivro('9780000000012') AS MediaAvaliacao;
SELECT '9780000000099' AS ISBN, CalcularMediaAvaliacaoLivro('9780000000099') AS MediaAvaliacao; -- Teste com ISBN sem avaliações.

-- Testando a função IsLivroAbaixoEstoqueMinimo
-- Deve retornar TRUE (1) ou FALSE (0) se o livro estiver abaixo do estoque mínimo.
SELECT '9780000000011' AS ISBN,
       (SELECT Quantidade FROM EstoqueLivros WHERE ISBN_Livro = '9780000000011') AS QuantidadeAtual,
       (SELECT EstoqueMinimo FROM EstoqueLivros WHERE ISBN_Livro = '9780000000011') AS EstoqueMinimoDefinido,
       IsLivroAbaixoEstoqueMinimo('9780000000011') AS AbaixoEstoqueMinimo;

-- Para testar um cenário onde o estoque está abaixo do mínimo (você pode alterar os dados temporariamente)
-- UPDATE EstoqueLivros SET Quantidade = 2 WHERE ISBN_Livro = '9780000000011';
-- SELECT '9780000000011' AS ISBN,
--        (SELECT Quantidade FROM EstoqueLivros WHERE ISBN_Livro = '9780000000011') AS QuantidadeAtual,
--        (SELECT EstoqueMinimo FROM EstoqueLivros WHERE ISBN_Livro = '9780000000011') AS EstoqueMinimoDefinido,
--        IsLivroAbaixoEstoqueMinimo('9780000000011') AS AbaixoEstoqueMinimoAposUpdate;
-- UPDATE EstoqueLivros SET Quantidade = 10 WHERE ISBN_Livro = '9780000000011'; -- Reverte a alteração

-- Testando a função GetNomeClientePorCPF
-- Deve retornar o nome do cliente dado o CPF.
SELECT '12345678901' AS CPF, GetNomeClientePorCPF('12345678901') AS NomeDoCliente;
SELECT '34567890123' AS CPF, GetNomeClientePorCPF('34567890123') AS NomeDoCliente;
SELECT '99999999999' AS CPF, GetNomeClientePorCPF('99999999999') AS NomeDoCliente; -- Teste com CPF que não existe.
