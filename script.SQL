CREATE TABLE tb_aluno(
	cod_id SERIAL PRIMARY KEY,
	salary INT,
	mother_edu INT,
	father_edu INT,
	prep_study INT,
	prep_exam INT,
	grade INT
);
DROP TABLE tb_aluno;
--1 Escreva um stored procedure que exibe o número de alunos aprovados e cujos pais são ambos PhDs.
CREATE OR REPLACE PROCEDURE sp_pais_phd(
	 OUT cont INT
) LANGUAGE plpgsql
AS $$
BEGIN
	SELECT COUNT(*)
	INTO cont
	FROM tb_aluno
	WHERE father_edu = 6 and mother_edu = 6 and grade > 0;
END;
$$

DO $$
DECLARE
cont INT;
BEGIN
	CALL sp_pais_phd(cont);
	RAISE NOTICE 'o número de alunos aprovados com ambos pais phds é : %', cont;
END;
$$

-- 2-) Resultado em função dos estudos
-- Escreva um stored procedure que disponibiliza,
-- utilizando um parâmetro em modo OUT,
-- o número de alunos aprovados dentre aqueles que estudam sozinhos.

SELECT * from tb_aluno;
CREATE OR REPLACE PROCEDURE sp_aprovados_sozinhos(
	 OUT cont INT
) LANGUAGE plpgsql
AS $$
BEGIN
	SELECT COUNT(*)
	INTO cont
	FROM tb_aluno
	WHERE prep_study = 1 AND grade > 0;
END;
$$

DO $$
DECLARE
cont INT;
BEGIN
	CALL sp_aprovados_sozinhos(cont);
	RAISE NOTICE 'o número de alunos aprovados que estudam sozinhos é : %', cont;
END;
$$

-- 3 
-- Dentre os alunos que têm salário maior que 410, 
--quantos costumams e preparar com frequência (regularmente)
-- para os exames? Escreva uma função que devolva esse número.
DROP FUNCTION fn_renda_aprovados
CREATE OR REPLACE FUNCTION fn_renda_aprovados() RETURNS INT
AS $$
DECLARE
	cont INT;
BEGIN
	SELECT COUNT(*) 
	FROM tb_aluno
	WHERE salary = 5 and grade > 0 and prep_exam = 2
    INTO cont;
	
	RETURN cont;
END;
$$ LANGUAGE plpgsql;

DO $$
DECLARE 
	renda_aprovados INT;
BEGIN
	renda_aprovados := fn_renda_aprovados();
	RAISE NOTICE 'o número de alunos aprovados com renda maior que 410 é : %', renda_aprovados;
END;
$$
