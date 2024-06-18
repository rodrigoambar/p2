CREATE TABLE tb_aluno(
	cod_id SERIAL PRIMARY KEY,
	salary INT,
	mother_edu INT,
	father_edu INT,
	prep_study INT,
	grade INT
);

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