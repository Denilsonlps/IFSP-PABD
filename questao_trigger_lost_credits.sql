
-- Questão 01: Trigger que atualiza os créditos do aluno ao remover um curso da lista (dbo.lost_credits)

CREATE TRIGGER dbo.lost_credits
ON dbo.takes
AFTER DELETE AS
BEGIN
    IF (ROWCOUNT_BIG() = 0)
        RETURN;

    UPDATE s
    SET s.tot_cred = s.tot_cred - c.credits
    FROM dbo.student s
    JOIN deleted d ON s.ID = d.ID
    JOIN dbo.course c ON d.course_id = c.course_id;
END;
