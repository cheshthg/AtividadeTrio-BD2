-- Trigger 1: Prevent deletion of a book if it has associated sales records.
-- Ensures referential integrity and prevents historical data loss.
DELIMITER //
CREATE TRIGGER trg_prevent_book_delete_on_sales
BEFORE DELETE ON Livros
FOR EACH ROW
BEGIN
    DECLARE sales_count INT;
    SELECT COUNT(*) INTO sales_count FROM Vendas WHERE Livros_ISBN1 = OLD.ISBN;
    IF sales_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete book: Associated sales records exist.';
    END IF;
END;
//
DELIMITER ;

-- Trigger 2: Update 'DataAtualizacao' in EstoqueLivros automatically on quantity change.
-- Helps in tracking when the stock level of a book was last modified.
DELIMITER //
CREATE TRIGGER trg_update_estoque_data_atualizacao
BEFORE UPDATE ON EstoqueLivros
FOR EACH ROW
BEGIN
    IF OLD.Quantidade <> NEW.Quantidade THEN
        SET NEW.DataAtualizacao = CURDATE();
    END IF;
END;
//
DELIMITER ;

-- Trigger 3: Ensure a new employee's admission date is not in the future.
-- Basic data validation to maintain data accuracy.
DELIMITER //
CREATE TRIGGER trg_check_funcionario_data_adm
BEFORE INSERT ON Funcionarios
FOR EACH ROW
BEGIN
    IF NEW.dataAdm > CURDATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Admission date cannot be in the future.';
    END IF;
END;
//
DELIMITER ;

-- Trigger 4: Automatically set the 'Status' of a new order to 'Pendente'.
-- Standardizes the initial state of new orders.
DELIMITER //
CREATE TRIGGER trg_set_pedido_status_on_insert
BEFORE INSERT ON Pedidos
FOR EACH ROW
BEGIN
    SET NEW.Status = 'Pendente';
END;
//
DELIMITER ;

-- Trigger 5: Prevent a book from being assigned to more than 3 authors.
-- Enforces a business rule regarding collaborative authorship. (Adjust 3 as needed)
DELIMITER //
CREATE TRIGGER trg_restrict_livro_autores
BEFORE INSERT ON LivroAutores
FOR EACH ROW
BEGIN
    DECLARE author_count INT;
    SELECT COUNT(*) INTO author_count FROM LivroAutores WHERE Livros_ISBN = NEW.Livros_ISBN;
    IF author_count >= 3 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A book cannot have more than 3 authors.';
    END IF;
END;
//
DELIMITER ;

-- Trigger 6: Log changes to employee salaries into an audit table.
-- Creates an audit trail for sensitive data changes.
DELIMITER //
CREATE TRIGGER trg_log_salario_change
AFTER UPDATE ON Funcionarios
FOR EACH ROW
BEGIN
    IF OLD.salario <> NEW.salario THEN
        INSERT INTO AuditSalarioFunc (CPF_Func, OldSalario, NewSalario, DataModificacao)
        VALUES (OLD.CPF_Func, OLD.salario, NEW.salario, NOW());
    END IF;
END;
//
DELIMITER ;

-- DDL for the audit table (needed for Trigger 6)
CREATE TABLE IF NOT EXISTS AuditSalarioFunc (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    CPF_Func VARCHAR(14) NOT NULL,
    OldSalario DECIMAL(10, 2),
    NewSalario DECIMAL(10, 2),
    DataModificacao DATETIME
);
