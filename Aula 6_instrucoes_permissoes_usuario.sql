
-- Questão 1: Criação das contas de usuário User_A a User_E
CREATE USER User_A WITH PASSWORD = 'SenhaUserA123';
CREATE USER User_B WITH PASSWORD = 'SenhaUserB123';
CREATE USER User_C WITH PASSWORD = 'SenhaUserC123';
CREATE USER User_D WITH PASSWORD = 'SenhaUserD123';
CREATE USER User_E WITH PASSWORD = 'SenhaUserE123';

-- Questão 2: Conceder privilégios de seleção e modificação ao User_A (exceto na tabela CLASSROOM)
GRANT SELECT, INSERT, UPDATE, DELETE ON course TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON department TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON instructor TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON prereq TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON section TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON student TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON takes TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON teaches TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON advisor TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON time_slot TO User_A WITH GRANT OPTION;

-- Questão 3: Listar todas as permissões concedidas ao usuário User_A
SELECT  
    princ.name AS usuario,
    princ.type_desc AS tipo_usuario,
    perm.permission_name AS permissao,
    perm.state_desc AS estado_permissao,
    perm.class_desc AS tipo_objeto,
    OBJECT_NAME(perm.major_id) AS nome_objeto
FROM 
    sys.database_principals princ
LEFT JOIN 
    sys.database_permissions perm ON perm.grantee_principal_id = princ.principal_id
WHERE 
    princ.name = 'User_A'
ORDER BY 
    nome_objeto, permissao;
