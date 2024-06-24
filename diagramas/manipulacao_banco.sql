-- Inserts
INSERT INTO `locadoradb`.`marcas` (`descricao`)
VALUES ('Volkswagen');

INSERT INTO `locadoradb`.`modelos` (`codigo_marca`, `descricao`)
VALUES (1, 'Gol');

INSERT INTO `locadoradb`.`carros` (`ano`, `cor`, `descricao`, `observacao`, `codigo_modelo`)
VALUES (2024, 'Vermelho', 'Gol Vermelho', '', 1);

INSERT INTO `locadoradb`.`clientes` (`nome`, `email`, `senha`)
VALUES ('Cauã Mistura', 'caua.m@teste.com', 'senha1234');

INSERT INTO `locadoradb`.`Locacao` (`data_retirada`, `data_devolucao`, `valor`, `observacao`, `codigo_carro`, `codigo_cliente`)
VALUES ('2024-05-30', '2024-05-31', 18.5,'Para viagem até SP', 1, 1);

-- Updates
UPDATE `locadoradb`.`modelos` set `descricao`='Gol GTI' where `codigo`=1;

UPDATE `locadoradb`.`carros` set `descricao`='Gol GTI Vermelho' where `codigo`=1;

UPDATE `locadoradb`.`clientes` set `nome`='caua.m@editado.com' where `codigo`=1;

-- Deletes
DELETE FROM `locadoradb`.`carros` where `codigo`=1;

DELETE FROM `locadoradb`.`modelos` where `codigo`=1;

DELETE FROM `locadoradb`.`marcas` where `codigo`=1;

-- Selects
SELECT * FROM `locadoradb`.`carros` ;
SELECT * FROM `locadoradb`.`modelos` ;
SELECT * FROM `locadoradb`.`marcas` ;

-- Selects with JOIN
SELECT carro.ano, carro.cor,modelo.descricao AS modelo, marca.descricao AS marca
FROM `locadoradb`.`carros` AS carro
JOIN `locadoradb`.`marcas` AS marca 
JOIN `locadoradb`.`modelos` AS modelo;

SELECT locacao.data_retirada, locacao.data_devolucao, locacao.valor AS valor_locacao, locacao.observacao, 
	   carro.ano AS ano_carro, carro.cor AS cor_carro,
       modelo.descricao AS modelo_carro, 
       marca.descricao AS marca_carro,
	   cliente.nome AS cliente
FROM `locadoradb`.`locacao` AS locacao
JOIN `locadoradb`.`carros` AS carro
JOIN `locadoradb`.`clientes` AS cliente 
JOIN `locadoradb`.`marcas` AS marca 
JOIN `locadoradb`.`modelos` AS modelo;

-- Drop do procedimento armazenado se existir
DROP PROCEDURE IF EXISTS AdicionarCarroCompleto;

DELIMITER //

-- Criação do procedimento armazenado
CREATE PROCEDURE AdicionarCarroCompleto(
    IN p_ano INT,
    IN p_cor VARCHAR(50),
    IN p_descricao VARCHAR(100),
    IN p_observacao VARCHAR(200),
    IN p_descricao_marca VARCHAR(100),
    IN p_descricao_modelo VARCHAR(100)
)
BEGIN
    DECLARE v_codigo_marca INT;
    DECLARE v_codigo_modelo INT;

    -- Inserir na tabela marcas
    INSERT INTO `locadoradb`.`marcas` (`descricao`)
    VALUES (p_descricao_marca);

    -- Capturar o último ID inserido na tabela marcas
    SET v_codigo_marca = LAST_INSERT_ID(); 

    -- Inserir na tabela modelos
    INSERT INTO `locadoradb`.`modelos` (`codigo_marca`, `descricao`)
    VALUES (v_codigo_marca, p_descricao_modelo);

    -- Capturar o último ID inserido na tabela modelos
    SET v_codigo_modelo = LAST_INSERT_ID(); 

    -- Inserir na tabela carros
    INSERT INTO `locadoradb`.`carros` (`ano`, `cor`, `descricao`, `observacao`, `codigo_modelo`)
    VALUES (p_ano, p_cor, p_descricao, p_observacao, v_codigo_modelo);

    SELECT 'Carro adicionado com sucesso!' AS mensagem;
END//

DELIMITER ;

-- Chamar o procedimento armazenado
CALL AdicionarCarroCompleto(2024, 'Vermelho', 'Gol Vermelho', '', 'Volkswagen', 'Gol');

-- Drop do gatilho se existir
DROP TRIGGER IF EXISTS criar_carro_apos_modelo;

DELIMITER //

CREATE TRIGGER criar_carro_apos_modelo
AFTER INSERT
ON locadoradb.modelos
FOR EACH ROW
BEGIN
    DECLARE v_codigo_modelo INT;

    -- Captura o código do modelo inserido
    SET v_codigo_modelo = NEW.codigo_modelo;

    -- Insere um novo carro relacionado ao modelo na tabela carros
    INSERT INTO `locadoradb`.`carros` (`ano`, `cor`, `descricao`, `observacao`, `codigo_modelo`)
    VALUES (YEAR(CURDATE()), 'Cor Padrão', CONCAT('Novo Carro ', v_codigo_modelo), 'Criado automaticamente após inserção do modelo', v_codigo_modelo);
END//

DELIMITER ;