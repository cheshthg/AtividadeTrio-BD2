DELIMITER ;

-- Test Script for Stored Procedures

-- SET SQL_SAFE_UPDATES = 0; -- Uncomment if you encounter issues with safe update mode

-- Before running tests, ensure your database has some initial data.
-- You can use the 'editora insert.sql' script to populate the tables.

-- Test 1: sp_GerenciarLivroCompleto
-- Insere um novo livro, autor, categoria e estoque.
-- Verifique a existência de ISBN '9780000000021' antes de executar
SELECT '--- Teste 1: sp_GerenciarLivroCompleto ---' AS Teste;
CALL sp_GerenciarLivroCompleto(
    '9780000000021',      -- p_ISBN
    'A Ascensão da IA',  -- p_Titulo
    2023,                -- p_AnoPublicacao
    450,                 -- p_NumPaginas
    'Português',         -- p_Idioma
    'TechBooks',         -- p_Editora
    1,                   -- p_AreaConhecimentoID (Assumindo que ID 1 exista para 'Tecnologia')
    '111.111.111-11',    -- p_AutorCPF (Novo Autor)
    'Alice Smith',       -- p_NomeAutor
    'Americana',         -- p_NacionalidadeAutor
    '1975-01-10',        -- p_DataNascAutor
    'Inteligência Artificial', -- p_NomeCategoria (Nova Categoria)
    'Livros sobre IA e Machine Learning', -- p_DescricaoCategoria
    100,                 -- p_QuantidadeEstoque
    'Armazem A, Corredor 5' -- p_LocalizacaoEstoque
);
SELECT * FROM Livros WHERE ISBN = '9780000000021';
SELECT * FROM Autores WHERE CPF_Autor = '111.111.111-11';
SELECT * FROM LivroAutores WHERE Livros_ISBN = '9780000000021';
SELECT * FROM CategoriasLivros WHERE NomeCategoria = 'Inteligência Artificial';
SELECT * FROM EstoqueLivros WHERE ISBN_Livro = '9780000000021';

-- Test 2: sp_AtualizarInfoClienteEPedidos
-- Atualiza o nome de um cliente existente e o status de um pedido.
-- Use um CPF e ID de pedido que existam no seu 'editora insert.sql'
SELECT '--- Teste 2: sp_AtualizarInfoClienteEPedidos ---' AS Teste;
-- Antes da atualização
SELECT Nome, CPF FROM Clientes WHERE CPF = '12345678901';
SELECT Bairro, Clientes_CPF FROM EnderecoCli WHERE Clientes_CPF = '12345678901';
SELECT idPedidos, `Status`, Clientes_CPF FROM Pedidos WHERE Clientes_CPF = '12345678901' LIMIT 1; -- Seleciona o primeiro pedido do cliente

CALL sp_AtualizarInfoClienteEPedidos(
    '12345678901',       -- p_CPFCliente (Cliente existente, ex: Ana Lima)
    'Ana Laura',         -- p_NovoNome
    'Casa Forte',        -- p_NovoBairro
    1,                   -- p_IdPedido (Assumindo que o pedido 1 pertence a '12345678901')
    'Entregue'           -- p_NovoStatusPedido
);
-- Após a atualização
SELECT Nome, CPF FROM Clientes WHERE CPF = '12345678901';
SELECT Bairro, Clientes_CPF FROM EnderecoCli WHERE Clientes_CPF = '12345678901';
SELECT idPedidos, `Status`, Clientes_CPF FROM Pedidos WHERE Clientes_CPF = '12345678901' LIMIT 1;


-- Test 3: sp_GerenciarPremioEAssociacao
-- Adiciona um novo prêmio e o associa a um livro existente.
-- Use um ISBN de livro que exista. Ex: '9780000000011' (Primeiro livro do insert.sql)
SELECT '--- Teste 3: sp_GerenciarPremioEAssociacao ---' AS Teste;
CALL sp_GerenciarPremioEAssociacao(
    'Melhor Romance do Ano', -- p_NomePremio
    2024,                   -- p_AnoPremio
    'Reconhecimento pela originalidade', -- p_DescricaoPremio
    'Nacional',             -- p_TipoPremio
    '9780000000011'         -- p_ISBNLivro
);
SELECT * FROM PremiosLiterarios WHERE NomePremio = 'Melhor Romance do Ano';
SELECT * FROM LivroPremios WHERE ISBN_Livro = '9780000000011';
SELECT Titulo FROM Livros WHERE ISBN = '9780000000011'; -- Verifique se o título foi atualizado

-- Test 4: sp_DeletarFuncionarioEEnderecos
-- Deleta um funcionário e seus dados relacionados.
-- CUIDADO: Este teste deletará dados. Use um CPF de funcionário de teste ou um que possa ser recriado.
-- Use um CPF que exista e você não se importe em apagar, ex: '56789012345' (Lucas Braga)
SELECT '--- Teste 4: sp_DeletarFuncionarioEEnderecos ---' AS Teste;
SELECT 'Antes da exclusão:' AS Status;
SELECT * FROM Funcionarios WHERE CPF_Func = '56789012345';
SELECT * FROM EnderecoFunc WHERE Funcionarios_CPF_Func = '56789012345';
SELECT * FROM Contato WHERE Funcionarios_CPF_Func = '56789012345';
SELECT * FROM Vendas WHERE Funcionarios_CPF_Func = '56789012345';

CALL sp_DeletarFuncionarioEEnderecos(
    '56789012345' -- p_CPF_Func
);
SELECT 'Após a exclusão:' AS Status;
SELECT * FROM Funcionarios WHERE CPF_Func = '56789012345';
SELECT * FROM EnderecoFunc WHERE Funcionarios_CPF_Func = '56789012345';
SELECT * FROM Contato WHERE Funcionarios_CPF_Func = '56789012345';
SELECT * FROM Vendas WHERE Funcionarios_CPF_Func = '56789012345';


-- Test 5: sp_AdicionarAvaliacaoEAtualizarMedia
-- Adiciona uma avaliação a um livro e atualiza sua nota média.
-- Use um ISBN de livro existente e um CPF de cliente, ou NULL para anônimo.
-- OBS: A coluna 'MediaNota' na tabela Livros é assumida. Se não existir, crie-a manualmente ou adapte a procedure.
-- Ex: ALTER TABLE Livros ADD COLUMN MediaNota DECIMAL(3,2) DEFAULT 0.00;
SELECT '--- Teste 5: sp_AdicionarAvaliacaoEAtualizarMedia ---' AS Teste;
-- Antes da avaliação
SELECT Titulo, MediaNota FROM Livros WHERE ISBN = '9780000000012'; -- Ex: 'Dom Casmurro'
SELECT * FROM AvaliacoesLivros WHERE ISBN_Livro = '9780000000012';

CALL sp_AdicionarAvaliacaoEAtualizarMedia(
    '9780000000012',      -- p_ISBNLivro
    '12345678901',        -- p_CPFCliente (Cliente existente)
    5,                    -- p_Nota (entre 1 e 5)
    'Excelente leitura, recomendo!', -- p_Comentario
    NULL                  -- p_NomeClienteAnonimo
);
-- Após a avaliação
SELECT Titulo, MediaNota FROM Livros WHERE ISBN = '9780000000012';
SELECT * FROM AvaliacoesLivros WHERE ISBN_Livro = '9780000000012' ORDER BY DataAvaliacao DESC LIMIT 1;

-- Test 6: sp_TransferirLivroEntreAreasEAutores
-- Altera a área de conhecimento de um livro e associa um novo autor a ele.
-- Use um ISBN de livro existente.
SELECT '--- Teste 6: sp_TransferirLivroEntreAreasEAutores ---' AS Teste;
-- Antes da atualização
SELECT l.Titulo, ac.Descricao AS AreaAtual, a.NomeAutor AS AutorAtual
FROM Livros l
JOIN AreasConhecimento ac ON l.AreasConhecimento_idAreaConhecimento = ac.idAreaConhecimento
JOIN LivroAutores la ON l.ISBN = la.Livros_ISBN
JOIN Autores a ON la.Autores_CPF_Autor = a.CPF_Autor
WHERE l.ISBN = '9780000000013'; -- Ex: 'Memórias Póstumas de Brás Cubas'

CALL sp_TransferirLivroEntreAreasEAutores(
    '9780000000013',      -- p_ISBN
    2,                   -- p_NovaAreaConhecimentoID (Assumindo ID 2 para 'Literatura Clássica')
    '999.999.999-99',    -- p_NovoAutorCPF
    'Novo Escritor',     -- p_NomeNovoAutor
    'Brasileira',        -- p_NacionalidadeNovoAutor
    '1980-04-20',        -- p_DataNascNovoAutor
    TRUE                 -- p_RemoverAutorAntigo (TRUE para remover associações anteriores)
);

-- Após a atualização
SELECT l.Titulo, ac.Descricao AS AreaAtualizada, a.NomeAutor AS AutorAtualizado
FROM Livros l
JOIN AreasConhecimento ac ON l.AreasConhecimento_idAreaConhecimento = ac.idAreaConhecimento
JOIN LivroAutores la ON l.ISBN = la.Livros_ISBN
JOIN Autores a ON la.Autores_CPF_Autor = a.CPF_Autor
WHERE l.ISBN = '9780000000013';

-- Reverter para o DELIMITER padrão
DELIMITER ;
