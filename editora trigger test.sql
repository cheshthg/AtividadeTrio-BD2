-- Disable safe updates mode for testing UPDATE and DELETE operations
SET SQL_SAFE_UPDATES = 0;

-- Test Trigger 1: trg_prevent_book_delete_on_sales
-- Scenario 1.1: Try to delete a book with sales records (should fail)
-- First, ensure a book exists with sales. Let's use an ISBN that has sales from your insert script.
-- From 'editora insert.sql', '9780000000011' has sales data.
SELECT '--- Testing Trigger 1 (trg_prevent_book_delete_on_sales) ---';
SELECT 'Attempting to delete book 9780000000011 (should fail)...';
DELETE FROM Livros WHERE ISBN = '9780000000011'; -- This should trigger the error
SELECT 'Result for deleting book 9780000000011: (Check error message above)';

-- Scenario 1.2: Try to delete a book without sales records (should succeed)
-- Insert a temporary book without sales
INSERT INTO Livros (ISBN, Titulo, Numero_Paginas, Ano_Publicacao, Idioma, AreasConhecimento_idAreaConhecimento)
VALUES ('9789999999999', 'Test Book No Sales', 100, 2023, 'Português', 1);
SELECT 'Attempting to delete book 9789999999999 (should succeed)...';
DELETE FROM Livros WHERE ISBN = '9789999999999';
SELECT 'Result for deleting book 9789999999999: (Check if deleted successfully)';


-- Test Trigger 2: trg_update_estoque_data_atualizacao
-- Scenario 2.1: Update quantity in EstoqueLivros (DataAtualizacao should update)
SELECT '--- Testing Trigger 2 (trg_update_estoque_data_atualizacao) ---';
SELECT Quantidade, Localizacao, DataAtualizacao FROM EstoqueLivros WHERE ISBN_Livro = '9780000000011';
SELECT 'Updating quantity for book 9780000000011...';
UPDATE EstoqueLivros SET Quantidade = 50 WHERE ISBN_Livro = '9780000000011';
SELECT 'After update:';
SELECT Quantidade, Localizacao, DataAtualizacao FROM EstoqueLivros WHERE ISBN_Livro = '9780000000011';

-- Scenario 2.2: Update a non-quantity field (DataAtualizacao should not update)
SELECT 'Updating location for book 9780000000012...';
SELECT Quantidade, Localizacao, DataAtualizacao FROM EstoqueLivros WHERE ISBN_Livro = '9780000000012';
UPDATE EstoqueLivros SET Localizacao = 'Warehouse B' WHERE ISBN_Livro = '9780000000012';
SELECT 'After update:';
SELECT Quantidade, Localizacao, DataAtualizacao FROM EstoqueLivros WHERE ISBN_Livro = '9780000000012';


-- Test Trigger 3: trg_check_funcionario_data_adm
-- Scenario 3.1: Insert employee with future admission date (should fail)
SELECT '--- Testing Trigger 3 (trg_check_funcionario_data_adm) ---';
SELECT 'Attempting to insert employee with future admission date (should fail)...';
INSERT INTO Funcionarios (CPF_Func, NomeFunc, sexo, dataNasc, ch, salario, dataAdm)
VALUES ('99988877766', 'Futuro Funcionario', 'M', '1990-01-01', 40, 3000.00, '2026-01-01'); -- Future date
SELECT 'Result for future admission date: (Check error message above)';

-- Scenario 3.2: Insert employee with valid admission date (should succeed)
SELECT 'Attempting to insert employee with valid admission date (should succeed)...';
INSERT INTO Funcionarios (CPF_Func, NomeFunc, sexo, dataNasc, ch, salario, dataAdm)
VALUES ('99988877765', 'Presente Funcionario', 'F', '1992-02-02', 35, 2800.00, CURDATE());
SELECT 'Result for valid admission date: (Check if inserted successfully)';
DELETE FROM Funcionarios WHERE CPF_Func = '99988877765'; -- Clean up


-- Test Trigger 4: trg_set_pedido_status_on_insert
-- Scenario 4.1: Insert a new order (Status should be 'Pendente' automatically)
SELECT '--- Testing Trigger 4 (trg_set_pedido_status_on_insert) ---';
INSERT INTO Pedidos (idPedidos, DataPedido, Clientes_CPF)
VALUES (999, CURDATE(), '12345678901'); -- Assuming client '12345678901' exists
SELECT 'Checking status of newly inserted order 999:';
SELECT idPedidos, DataPedido, Status, Clientes_CPF FROM Pedidos WHERE idPedidos = 999;
DELETE FROM Pedidos WHERE idPedidos = 999; -- Clean up


-- Test Trigger 5: trg_restrict_livro_autores
-- Scenario 5.1: Add authors to a book up to the limit (3 authors for ISBN '9780000000011')
SELECT '--- Testing Trigger 5 (trg_restrict_livro_autores) ---';
-- Assuming '9780000000011' has one author initially from 'editora insert.sql'
-- Let's ensure it has less than 3 authors first, then add.
-- Run your initial inserts to reset if needed, then:
DELETE FROM LivroAutores WHERE Livros_ISBN = '9780000000011';
INSERT INTO LivroAutores (Livros_ISBN, Autores_CPF_Autor) VALUES
('9780000000011', '111.222.333-44'); -- Author 1 (from insert.sql)

SELECT 'Adding second author to book 9780000000011...';
INSERT INTO LivroAutores (Livros_ISBN, Autores_CPF_Autor) VALUES
('9780000000011', '222.333.444-55'); -- Author 2 (new)
SELECT 'Current authors for 9780000000011:';
SELECT COUNT(*) FROM LivroAutores WHERE Livros_ISBN = '9780000000011';

SELECT 'Adding third author to book 9780000000011...';
INSERT INTO LivroAutores (Livros_ISBN, Autores_CPF_Autor) VALUES
('9780000000011', '333.444.555-66'); -- Author 3 (new)
SELECT 'Current authors for 9780000000011:';
SELECT COUNT(*) FROM LivroAutores WHERE Livros_ISBN = '9780000000011';

-- Scenario 5.2: Try to add a fourth author (should fail)
SELECT 'Attempting to add fourth author to book 9780000000011 (should fail)...';
INSERT INTO LivroAutores (Livros_ISBN, Autores_CPF_Autor) VALUES
('9780000000011', '444.555.666-77'); -- Author 4 (should trigger error)
SELECT 'Result for adding fourth author: (Check error message above)';
DELETE FROM LivroAutores WHERE Livros_ISBN = '9780000000011' AND Autores_CPF_Autor IN ('222.333.444-55', '333.444.555-66');


-- Test Trigger 6: trg_log_salario_change
-- Scenario 6.1: Update an employee's salary (should log to AuditSalarioFunc)
SELECT '--- Testing Trigger 6 (trg_log_salario_change) ---';
SELECT 'Salaries before update:';
SELECT CPF_Func, Salario FROM Funcionarios WHERE CPF_Func = '12345678901';
SELECT 'Updating salary for employee 12345678901...';
UPDATE Funcionarios SET salario = 3500.00 WHERE CPF_Func = '12345678901';
SELECT 'Salaries after update:';
SELECT CPF_Func, Salario FROM Funcionarios WHERE CPF_Func = '12345678901';
SELECT 'Checking AuditSalarioFunc table:';
SELECT * FROM AuditSalarioFunc WHERE CPF_Func = '12345678901';

-- Scenario 6.2: Update a non-salary field (should not log)
SELECT 'Updating ch for employee 12345678901 (should not log)...';
UPDATE Funcionarios SET ch = 45 WHERE CPF_Func = '12345678901';
SELECT 'Checking AuditSalarioFunc table again: (should be no new entry for 12345678901)';
SELECT * FROM AuditSalarioFunc WHERE CPF_Func = '12345678901';


-- Re-enable safe updates mode
SET SQL_SAFE_UPDATES = 1;

-- Clean up any temporary data if desired (optional)
-- DELETE FROM Livros WHERE ISBN = '9789999999999';
-- DELETE FROM Pedidos WHERE idPedidos = 999;
-- DELETE FROM AuditSalarioFunc; -- Use with caution if you want to keep audit history
