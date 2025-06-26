DELIMITER $$

-- 1. Função para calcular a idade de um livro em anos desde a sua publicação
-- Retorna a idade de um livro em anos, baseada na DataPublicacao.
CREATE FUNCTION CalcularIdadeLivro(p_ISBN VARCHAR(14))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE idade INT;
    SELECT TIMESTAMPDIFF(YEAR, DataPublicacao, CURDATE())
    INTO idade
    FROM Livros
    WHERE ISBN = p_ISBN;
    RETURN idade;
END$$

-- 2. Função para obter o próximo número de série disponível para um exemplar de um livro
-- Retorna o próximo número de série sequencial para um exemplar de um dado livro.
CREATE FUNCTION GetProximoNumeroSerieExemplar(p_ISBN VARCHAR(14))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE proximo_numero INT;
    SELECT IFNULL(MAX(NumeroSerie), 0) + 1
    INTO proximo_numero
    FROM Exemplares
    WHERE Livros_ISBN1 = p_ISBN;
    RETURN proximo_numero;
END$$

-- 3. Função para contar o número de autores de um livro específico
-- Retorna o total de autores associados a um livro pelo seu ISBN.
CREATE FUNCTION ContarAutoresLivro(p_ISBN VARCHAR(14))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_autores INT;
    SELECT COUNT(*)
    INTO total_autores
    FROM LivroAutores
    WHERE Livros_ISBN = p_ISBN;
    RETURN total_autores;
END$$

-- 4. Função para calcular a média de avaliação de um livro
-- Retorna a média das notas de avaliação para um livro específico.
CREATE FUNCTION CalcularMediaAvaliacaoLivro(p_ISBN VARCHAR(14))
RETURNS DECIMAL(3,2)
DETERMINISTIC
BEGIN
    DECLARE media_avaliacao DECIMAL(3,2);
    SELECT IFNULL(AVG(Nota), 0.00)
    INTO media_avaliacao
    FROM AvaliacoesLivros
    WHERE ISBN_Livro = p_ISBN;
    RETURN media_avaliacao;
END$$

-- 5. Função para verificar se um livro está abaixo do estoque mínimo
-- Retorna TRUE (1) se a quantidade em estoque for menor ou igual ao estoque mínimo, FALSE (0) caso contrário.
CREATE FUNCTION IsLivroAbaixoEstoqueMinimo(p_ISBN VARCHAR(14))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE abaixo_minimo BOOLEAN;
    SELECT (Quantidade <= EstoqueMinimo)
    INTO abaixo_minimo
    FROM EstoqueLivros
    WHERE ISBN_Livro = p_ISBN;
    RETURN abaixo_minimo;
END$$

-- 6. Função para obter o nome completo de um cliente baseado no CPF
-- Retorna o nome completo do cliente dado o seu CPF.
CREATE FUNCTION GetNomeClientePorCPF(p_CPF VARCHAR(14))
RETURNS VARCHAR(45)
DETERMINISTIC
BEGIN
    DECLARE nome_cliente VARCHAR(45);
    SELECT Nome
    INTO nome_cliente
    FROM Clientes
    WHERE CPF = p_CPF;
    RETURN nome_cliente;
END$$

DELIMITER ;
