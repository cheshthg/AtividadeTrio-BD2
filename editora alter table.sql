-- 1. Adicionar coluna DataAtualizacao na tabela EstoqueLivros
ALTER TABLE EstoqueLivros
ADD COLUMN DataAtualizacao DATE AFTER Localizacao;

-- 2. Adicionar índice na coluna NomeCategoria para melhorar buscas por nome
ALTER TABLE CategoriasLivros
ADD INDEX idx_NomeCategoria (NomeCategoria);

-- 3. Adicionar coluna CNPJ para os fornecedores
ALTER TABLE Fornecedores
ADD COLUMN CNPJ VARCHAR(18) AFTER NomeFornecedor;

-- 4. Tornar o campo Email único na tabela Fornecedores
ALTER TABLE Fornecedores
ADD CONSTRAINT uq_EmailFornecedor UNIQUE (Email);

-- 5. Adicionar coluna Nacional ou Internacional à tabela PremiosLiterarios
ALTER TABLE PremiosLiterarios
ADD COLUMN TipoPremio ENUM('Nacional', 'Internacional') DEFAULT 'Nacional';

-- 6. Adicionar índice para busca rápida por ISBN em LivroPremios
ALTER TABLE LivroPremios
ADD INDEX idx_ISBN_Livro (ISBN_Livro);

-- 7. Adicionar coluna NomeClienteAnonimo na tabela AvaliacoesLivros para avaliações de clientes não cadastrados
ALTER TABLE AvaliacoesLivros
ADD COLUMN NomeClienteAnonimo VARCHAR(45) NULL AFTER Cliente_CPF_Cli;

-- 8. Adicionar verificação de valor entre 1 e 5 para a nota na AvaliacoesLivros
ALTER TABLE AvaliacoesLivros
ADD CONSTRAINT chk_NotaValida CHECK (Nota BETWEEN 1 AND 5);

-- 9. Adicionar coluna EstoqueMinimo na tabela EstoqueLivros para controle de reposição
ALTER TABLE EstoqueLivros
ADD COLUMN EstoqueMinimo INT DEFAULT 5 AFTER Quantidade;

-- 10. Alterar o tipo da coluna Comentario para aumentar o limite de caracteres
ALTER TABLE AvaliacoesLivros
MODIFY COLUMN Comentario VARCHAR(255);