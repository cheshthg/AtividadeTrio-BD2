/* Comandos DDL - create tables*/
-- 1. Tabela para Rastrear o Estoque de Livros - Essa tabela ajudaria a editora a manter o controle sobre a quantidade de exemplares de cada livro em estoque.
create table EstoqueLivros (
    ISBN_Livro VARCHAR(14),
    Quantidade int,
    Localizacao varchar(50),  -- Para rastrear em qual armazém/prateleira o livro está
    primary key (ISBN_Livro),
    foreign key (ISBN_Livro) references livros(ISBN)
);
-- 2. Tabela para Categorias de Livros - Para classificar os livros em diferentes categorias (e.g., Ficção, Não Ficção, Romance, Suspense)
create table CategoriasLivros (
    CategoriaID int auto_increment,
    NomeCategoria varchar(50) unique, -- Garante que não haja categorias duplicadas
    Descricao varchar(60),
    primary key (CategoriaID)
);
-- 3. Tabela para Fornecedores/Distribuidores - Para manter informações sobre os fornecedores ou distribuidores dos livros.
create table Fornecedores (
    FornecedorID int auto_increment,
    NomeFornecedor varchar(100) not null,
    Endereco varchar(200),
    Telefone varchar(20),
    Email varchar(100),
    primary key (FornecedorID)
);
-- 4. Tabela para Prêmios Literários - Para registrar os prêmios que os livros ou autores da editora ganharam.
create table PremiosLiterarios (
    PremioID int auto_increment,
    NomePremio varchar(100) not null,
    AnoPremio int,
    DescricaoPremio varchar(60),
    primary key (PremioID)
);
-- 4.1  Tabela para relacionar livros e prêmios (relação muitos-para-muitos)
create table LivroPremios (
    ISBN_Livro VARCHAR(14),
    PremioID int,
    primary key (ISBN_Livro, PremioID),
    foreign key (ISBN_Livro) references livros(ISBN),
    foreign key (PremioID) references PremiosLiterarios(PremioID)
);
-- 5. Tabela para Avaliações de Livros - Para armazenar as avaliações e comentários dos clientes sobre os livros.
create table AvaliacoesLivros (
    AvaliacaoID int auto_increment,
    ISBN_Livro VARCHAR(14),
    Cliente_CPF_Cli varchar(14),
    Nota int ,
    Comentario varchar(60),
    DataAvaliacao date,
    primary key (AvaliacaoID),
    foreign key (ISBN_Livro) references livros(ISBN),
    foreign key (Cliente_CPF_Cli) references cliente(CPF)
);