DELIMITER $$

-- Procedure 1: sp_GerenciarLivroCompleto
-- Descrição: Insere um novo livro, um autor associado, uma categoria e atualiza o estoque.
-- Comandos SQL distintos: INSERT, INSERT, INSERT, UPDATE, SELECT (implícito para verificação ou para obter dados para UPDATE)
CREATE PROCEDURE sp_GerenciarLivroCompleto(
    IN p_ISBN VARCHAR(14),
    IN p_Titulo VARCHAR(100),
    IN p_AnoPublicacao INT,
    IN p_NumPaginas INT,
    IN p_Idioma VARCHAR(45),
    IN p_Editora VARCHAR(45),
    IN p_AreaConhecimentoID INT,
    IN p_AutorCPF VARCHAR(14),
    IN p_NomeAutor VARCHAR(45),
    IN p_NacionalidadeAutor VARCHAR(45),
    IN p_DataNascAutor DATE,
    IN p_NomeCategoria VARCHAR(50),
    IN p_DescricaoCategoria VARCHAR(60),
    IN p_QuantidadeEstoque INT,
    IN p_LocalizacaoEstoque VARCHAR(50)
)
BEGIN
    -- 1. Inserir o novo livro
    INSERT INTO Livros (ISBN, Titulo, AnoPublicacao, Numero_Paginas, Idioma, Editora, AreasConhecimento_idAreaConhecimento)
    VALUES (p_ISBN, p_Titulo, p_AnoPublicacao, p_NumPaginas, p_Idioma, p_Editora, p_AreaConhecimentoID);

    -- 2. Inserir o autor (se não existir, ou apenas associar se já existir)
    INSERT IGNORE INTO Autores (CPF_Autor, NomeAutor, Nacionalidade, DataNascimento)
    VALUES (p_AutorCPF, p_NomeAutor, p_NacionalidadeAutor, p_DataNascAutor);

    -- 3. Associar o livro ao autor
    INSERT INTO LivroAutores (Livros_ISBN, Autores_CPF_Autor)
    VALUES (p_ISBN, p_AutorCPF);

    -- 4. Inserir a categoria (se não existir, garantindo unicidade)
    INSERT IGNORE INTO CategoriasLivros (NomeCategoria, Descricao)
    VALUES (p_NomeCategoria, p_DescricaoCategoria);

    -- 5. Atualizar ou inserir estoque do livro
    INSERT INTO EstoqueLivros (ISBN_Livro, Quantidade, Localizacao, DataAtualizacao, EstoqueMinimo)
    VALUES (p_ISBN, p_QuantidadeEstoque, p_LocalizacaoEstoque, CURDATE(), 5)
    ON DUPLICATE KEY UPDATE
        Quantidade = Quantidade + VALUES(Quantidade),
        Localizacao = VALUES(Localizacao),
        DataAtualizacao = CURDATE();

    -- Opcional: Selecionar dados para confirmar a inserção/atualização
    SELECT 'Livro, autor, categoria e estoque gerenciados com sucesso!' AS Status;

END$$

-- Procedure 2: sp_AtualizarInfoClienteEPedidos
-- Descrição: Atualiza informações de um cliente e seus pedidos.
-- Comandos SQL distintos: UPDATE, UPDATE, SELECT, INSERT (para log)
CREATE PROCEDURE sp_AtualizarInfoClienteEPedidos(
    IN p_CPFCliente VARCHAR(14),
    IN p_NovoNome VARCHAR(45),
    IN p_NovoBairro VARCHAR(45),
    IN p_IdPedido INT,
    IN p_NovoStatusPedido VARCHAR(45)
)
BEGIN
    DECLARE v_OldStatus VARCHAR(45);

    -- 1. Atualizar nome do cliente
    UPDATE Clientes
    SET Nome = p_NovoNome
    WHERE CPF = p_CPFCliente;

    -- 2. Atualizar bairro do cliente no endereço
    UPDATE EnderecoCli
    SET Bairro = p_NovoBairro
    WHERE Clientes_CPF = p_CPFCliente;

    -- 3. Obter status antigo do pedido para log (exemplo de SELECT)
    SELECT `Status` INTO v_OldStatus
    FROM Pedidos
    WHERE idPedidos = p_IdPedido AND Clientes_CPF = p_CPFCliente;

    -- 4. Atualizar status do pedido
    UPDATE Pedidos
    SET `Status` = p_NovoStatusPedido
    WHERE idPedidos = p_IdPedido AND Clientes_CPF = p_CPFCliente;

    -- Exemplo de INSERT para um log simples (se houvesse uma tabela de log)
    -- INSERT INTO LogAtualizacoes (Tabela, Acao, DataHora) VALUES ('Pedidos', CONCAT('Status alterado de ', v_OldStatus, ' para ', p_NovoStatusPedido), NOW());

    SELECT 'Informações do cliente e status do pedido atualizados com sucesso!' AS Status;

END$$

-- Procedure 3: sp_GerenciarPremioEAssociacao
-- Descrição: Adiciona um novo prêmio literário e o associa a um livro existente.
-- Comandos SQL distintos: INSERT, INSERT, SELECT, UPDATE (opcional: para alterar tipo de prêmio)
CREATE PROCEDURE sp_GerenciarPremioEAssociacao(
    IN p_NomePremio VARCHAR(100),
    IN p_AnoPremio INT,
    IN p_DescricaoPremio VARCHAR(60),
    IN p_TipoPremio ENUM('Nacional', 'Internacional'),
    IN p_ISBNLivro VARCHAR(14)
)
BEGIN
    DECLARE v_PremioID INT;

    -- 1. Inserir o novo prêmio literário
    INSERT INTO PremiosLiterarios (NomePremio, AnoPremio, DescricaoPremio, TipoPremio)
    VALUES (p_NomePremio, p_AnoPremio, p_DescricaoPremio, p_TipoPremio);

    -- 2. Obter o ID do prêmio recém-inserido
    SET v_PremioID = LAST_INSERT_ID();

    -- 3. Associar o prêmio ao livro
    INSERT INTO LivroPremios (ISBN_Livro, PremioID)
    VALUES (p_ISBNLivro, v_PremioID);

    -- 4. Opcional: Atualizar a descrição do livro após o prêmio
    UPDATE Livros
    SET Titulo = CONCAT(Titulo, ' (Premiado)')
    WHERE ISBN = p_ISBNLivro;

    SELECT CONCAT('Prêmio "', p_NomePremio, '" adicionado e associado ao livro ', p_ISBNLivro, ' com sucesso!') AS Status;

END$$

-- Procedure 4: sp_DeletarFuncionarioEEnderecos
-- Descrição: Deleta um funcionário e todos os seus endereços associados, além de remover seus contatos e vendas.
-- Comandos SQL distintos: DELETE, DELETE, DELETE, SELECT (para verificar a exclusão)
CREATE PROCEDURE sp_DeletarFuncionarioEEnderecos(
    IN p_CPF_Func VARCHAR(14)
)
BEGIN
    -- 1. Deletar registros de contato associados ao funcionário
    DELETE FROM Contato
    WHERE Funcionarios_CPF_Func = p_CPF_Func;

    -- 2. Deletar registros de vendas associados ao funcionário
    DELETE FROM Vendas
    WHERE Funcionarios_CPF_Func = p_CPF_Func;

    -- 3. Deletar endereços do funcionário
    DELETE FROM EnderecoFunc
    WHERE Funcionarios_CPF_Func = p_CPF_Func;

    -- 4. Deletar o funcionário
    DELETE FROM Funcionarios
    WHERE CPF_Func = p_CPF_Func;

    -- Opcional: Verificar se o funcionário foi deletado
    SELECT 'Funcionário e dados relacionados deletados.' AS Status,
           COUNT(*) AS Remanescentes
    FROM Funcionarios
    WHERE CPF_Func = p_CPF_Func;

END$$

-- Procedure 5: sp_AdicionarAvaliacaoEAtualizarMedia
-- Descrição: Adiciona uma nova avaliação a um livro e atualiza a nota média do livro.
-- Comandos SQL distintos: INSERT, UPDATE, SELECT (para calcular a média), SELECT (para verificar)
CREATE PROCEDURE sp_AdicionarAvaliacaoEAtualizarMedia(
    IN p_ISBNLivro VARCHAR(14),
    IN p_CPFCliente VARCHAR(14),
    IN p_Nota INT,
    IN p_Comentario TEXT,
    IN p_NomeClienteAnonimo VARCHAR(45)
)
BEGIN
    DECLARE v_MediaNota DECIMAL(3,2);

    -- 1. Inserir a nova avaliação
    INSERT INTO AvaliacoesLivros (ISBN_Livro, Cliente_CPF_Cli, Nota, Comentario, DataAvaliacao, NomeClienteAnonimo)
    VALUES (p_ISBNLivro, p_CPFCliente, p_Nota, p_Comentario, CURDATE(), p_NomeClienteAnonimo);

    -- 2. Calcular a nova nota média para o livro
    SELECT AVG(Nota) INTO v_MediaNota
    FROM AvaliacoesLivros
    WHERE ISBN_Livro = p_ISBNLivro;

    -- 3. Atualizar a nota média na tabela de Livros (assumindo que haja uma coluna MediaNota)
    -- Se não houver, esta parte da procedure precisaria de uma alteração de tabela ou ser removida.
    -- Para este exemplo, vou assumir uma coluna 'MediaNota' em 'Livros' para demonstração.
    -- Se não existir, pode-se criar com: ALTER TABLE Livros ADD COLUMN MediaNota DECIMAL(3,2) DEFAULT 0.00;
    UPDATE Livros
    SET MediaNota = v_MediaNota
    WHERE ISBN = p_ISBNLivro;

    -- 4. Selecionar a avaliação e a nova média para confirmação
    SELECT 'Avaliação adicionada e média atualizada!' AS Status,
           p_ISBNLivro AS ISBN,
           v_MediaNota AS NovaMedia;
END$$


-- Procedure 6: sp_TransferirLivroEntreAreasEAutores
-- Descrição: Altera a área de conhecimento de um livro e associa um novo autor a ele.
-- Comandos SQL distintos: UPDATE, INSERT, DELETE (opcional: para remover associação antiga de autor), SELECT (para verificação)
CREATE PROCEDURE sp_TransferirLivroEntreAreasEAutores(
    IN p_ISBN VARCHAR(14),
    IN p_NovaAreaConhecimentoID INT,
    IN p_NovoAutorCPF VARCHAR(14),
    IN p_NomeNovoAutor VARCHAR(45),
    IN p_NacionalidadeNovoAutor VARCHAR(45),
    IN p_DataNascNovoAutor DATE,
    IN p_RemoverAutorAntigo BOOLEAN
)
BEGIN
    -- 1. Atualizar a área de conhecimento do livro
    UPDATE Livros
    SET AreasConhecimento_idAreaConhecimento = p_NovaAreaConhecimentoID
    WHERE ISBN = p_ISBN;

    -- 2. Inserir o novo autor (se não existir)
    INSERT IGNORE INTO Autores (CPF_Autor, NomeAutor, Nacionalidade, DataNascimento)
    VALUES (p_NovoAutorCPF, p_NomeNovoAutor, p_NacionalidadeNovoAutor, p_DataNascNovoAutor);

    -- 3. (Opcional) Remover associação de autores antigos, se solicitado
    IF p_RemoverAutorAntigo THEN
        DELETE FROM LivroAutores
        WHERE Livros_ISBN = p_ISBN AND Autores_CPF_Autor <> p_NovoAutorCPF;
    END IF;

    -- 4. Associar o livro ao novo autor (garantindo que não duplique)
    INSERT IGNORE INTO LivroAutores (Livros_ISBN, Autores_CPF_Autor)
    VALUES (p_ISBN, p_NovoAutorCPF);

    -- 5. Selecionar informações atualizadas do livro
    SELECT 'Livro atualizado com nova área e autor.' AS Status,
           l.Titulo, l.Editora, ac.Descricao AS NovaArea, a.NomeAutor AS NovoAutor
    FROM Livros l
    JOIN AreasConhecimento ac ON l.AreasConhecimento_idAreaConhecimento = ac.idAreaConhecimento
    JOIN LivroAutores la ON l.ISBN = la.Livros_ISBN
    JOIN Autores a ON la.Autores_CPF_Autor = a.CPF_Autor
    WHERE l.ISBN = p_ISBN AND a.CPF_Autor = p_NovoAutorCPF;

END$$

DELIMITER ;
