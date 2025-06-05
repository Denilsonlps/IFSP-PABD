
-- Questão 01: Trigger que impede atribuição de aulas a instrutores com 2 ou mais aulas no mesmo ano

CREATE TRIGGER dbo.trigger_prevent_assignment_teaches
ON dbo.teaches
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    IF (ROWCOUNT_BIG() = 0)
        RETURN;

    -- Verifica se algum dos instrutores inseridos já tem 2 ou mais atribuições no mesmo ano
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN (
            SELECT ID, year, COUNT(*) AS qtd
            FROM teaches
            GROUP BY ID, year
            HAVING COUNT(*) >= 3
        ) t ON i.ID = t.ID AND i.year = t.year
    )
    BEGIN
        RAISERROR ('Instrutor já possui 2 ou mais atribuições neste ano.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;
