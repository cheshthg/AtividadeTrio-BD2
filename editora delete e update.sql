SET SQL_SAFE_UPDATES = 0;

-- Atualiza salário de um funcionário
UPDATE Funcionarios SET salario = 3500.00 WHERE CPF_Func = '12345678901';

-- Atualiza cidade de um endereço de funcionário
UPDATE EnderecoFunc SET cidade = 'Olinda' WHERE Funcionarios_CPF_Func = '23456789012';

-- Atualiza descrição de departamento
UPDATE Departamento SET Descricao_Departamento = 'Responsável por campanhas digitais' WHERE ID_Departamento = 4;

-- Atualiza nome de cliente
UPDATE clientes SET Nome = 'Marina Sena' WHERE CPF = '12345678901';

-- Atualiza bairro no endereço de cliente
UPDATE enderecocli SET Bairro = 'Boa Vista' WHERE Clientes_CPF = '34567890123';

-- Atualiza e-mail de contato
UPDATE contato SET Email = 'novoemail@editora.com' WHERE idContato = 3;

-- Atualiza descrição de área de conhecimento
UPDATE areasconhecimento SET Descricao = 'Estudo da lógica simbólica' WHERE idAreaConhecimento = 7;

-- Atualiza título de livro
UPDATE livros SET Titulo = 'Banco de Dados Avançado' WHERE ISBN = '9780000000014';

-- Atualiza localização de exemplar
UPDATE exemplares SET Localizacao = 'Estante Z9' WHERE NumeroSerie = 28;

-- Atualiza status de pedido
UPDATE pedidos SET `Status` = 'cancelado' WHERE idPedidos = 2;

-- Remove um funcionário
DELETE FROM Funcionarios WHERE CPF_Func = '78901234567';

-- Remove endereço de funcionário
DELETE FROM EnderecoFunc WHERE Funcionarios_CPF_Func = '89012345678';

-- Remove um departamento
DELETE FROM Departamento WHERE ID_Departamento = 10;

-- Remove cliente
DELETE FROM clientes WHERE CPF = '89012345678';

-- Remove endereço de cliente
DELETE FROM enderecocli WHERE Clientes_CPF = '01234567890';

-- Remove contato
DELETE FROM contato WHERE idContato = 10;

-- Remove área de conhecimento
DELETE FROM areasconhecimento WHERE idAreaConhecimento = 10;

-- Remove exemplar de livro
DELETE FROM exemplares WHERE NumeroSerie = 33;

-- Remove pedido
DELETE FROM pedidos WHERE idPedidos = 8;

-- Remove forma de pagamento
DELETE FROM FormaPag WHERE idFormaPag = 10;
