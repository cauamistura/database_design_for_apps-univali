-- Inserts
INSERT INTO `locadoradb`.`marcas` (`descricao`)
VALUES ('Volkswagen');

INSERT INTO `locadoradb`.`modelos` (`codigo_marca`, `descricao`)
VALUES (1, 'Gol');

INSERT INTO `locadoradb`.`carros` (`ano`, `cor`, `descricao`, `observacao`, `codigo_modelo`)
VALUES (2024, 'Vermelho', 'Gol Vermelho', '', 1);

INSERT INTO `locadoradb`.`clientes` (`nome`, `email`, `senha`)
VALUES ('Cauã Mistura', 'caua.m@teste.com', 'senha1234');

-- Updates
UPDATE `locadoradb`.`modelos` set `descricao`='Gol GTI' where `codigo`=1;

UPDATE `locadoradb`.`carros` set `descricao`='Gol GTI Vermelho' where `codigo`=1;

UPDATE `locadoradb`.`clientes` set `nome`='caua.m@editado.com' where `codigo`=1;

-- Deletes
DELETE FROM `locadoradb`.`carros` where `codigo`=1;

DELETE FROM `locadoradb`.`modelos` where `codigo`=1;

DELETE FROM `locadoradb`.`marcas` where `codigo`=1;