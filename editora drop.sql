-- 1. Apagar a tabela LivroPremios
drop table livroPremios;
-- 2. Apagar Tabela AvaliacoesLivros
drop table AvaliacoesLivros;
-- 3. Apagar tabela PremiosLiterarios
drop table PremiosLiterarios;
-- 4. Apagar tabela Fornecedores
drop table Fornecedores;
-- 5. Apagar tabela Categorias
drop table CategoriasLivros;
-- 6. Apagar tabela Estoque
drop table EstoqueLivros;

DROP VIEW IF EXISTS vw_funcionarios_departamentos;
DROP VIEW IF EXISTS vw_clientes_pe_bairros;
DROP VIEW IF EXISTS vw_livros_areas;
DROP VIEW IF EXISTS vw_funcionarios_acima_media;
DROP VIEW IF EXISTS vw_total_pedidos_clientes;
DROP VIEW IF EXISTS vw_total_vendas_funcionarios;
DROP VIEW IF EXISTS vw_exemplares_por_livro;
DROP VIEW IF EXISTS vw_funcionarias_ch_maior_35;
DROP VIEW IF EXISTS vw_localizacao_exemplares_novos;
DROP VIEW IF EXISTS vw_qtd_livros_por_area;

drop schema mydb