
-- Questão 01: Criação do procedimento student_grade_points
CREATE PROCEDURE dbo.student_grade_points @conceito CHAR(2)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        s.name AS nome_estudante,
        s.dept_name AS departamento_estudante,
        c.title AS titulo_curso,
        c.dept_name AS departamento_curso,
        t.semester AS semestre,
        t.year AS ano,
        t.grade AS pontuacao_alfanumerica,
        gp.points AS pontuacao_numerica
    FROM 
        student s
    JOIN 
        takes t ON s.ID = t.ID
    JOIN 
        course c ON t.course_id = c.course_id
    JOIN 
        grade_points gp ON t.grade = gp.grade
    WHERE 
        t.grade = @conceito;
END;

-- Questão 02: Criação da função return_instructor_location
CREATE FUNCTION dbo.return_instructor_location (@nome_instrutor NVARCHAR(50))
RETURNS TABLE
AS
RETURN (
    SELECT 
        i.name AS nome_instrutor,
        c.title AS curso_ministrado,
        s.semester AS semestre,
        s.year AS ano,
        r.building AS predio,
        r.room_number AS numero_sala
    FROM 
        instructor i
    JOIN 
        teaches t ON i.ID = t.ID
    JOIN 
        section s ON t.course_id = s.course_id AND t.sec_id = s.sec_id AND t.semester = s.semester AND t.year = s.year
    JOIN 
        course c ON s.course_id = c.course_id
    JOIN 
        classroom r ON s.building = r.building AND s.room_number = r.room_number
    WHERE 
        i.name = @nome_instrutor
);
