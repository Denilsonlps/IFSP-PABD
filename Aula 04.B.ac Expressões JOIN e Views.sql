
-- Questão 1: Listar todos os instrutores com número de seções ministradas (usar OUTER JOIN)
SELECT 
    i.ID,
    i.name,
    COALESCE(COUNT(s.course_id), 0) AS number_of_sections
FROM 
    instructor i
LEFT JOIN 
    teaches s ON i.ID = s.ID
GROUP BY 
    i.ID, i.name
ORDER BY 
    i.ID;

-- Questão 2: Listar todos os instrutores com número de seções usando subconsulta escalar (sem OUTER JOIN)
SELECT 
    i.ID,
    i.name,
    (
        SELECT COUNT(*) 
        FROM teaches t 
        WHERE t.ID = i.ID
    ) AS number_of_sections
FROM 
    instructor i
ORDER BY 
    i.ID;

-- Questão 3: Listar seções oferecidas na primavera de 2010, com nome dos instrutores (usar "-" caso não haja)
SELECT 
    s.course_id,
    s.sec_id,
    t.ID,
    s.semester,
    s.year,
    COALESCE(i.name, '-') AS name
FROM 
    section s
LEFT JOIN 
    teaches t ON s.course_id = t.course_id 
             AND s.sec_id = t.sec_id 
             AND s.semester = t.semester 
             AND s.year = t.year
LEFT JOIN 
    instructor i ON t.ID = i.ID
WHERE 
    s.semester = 'Spring' 
    AND s.year = 2010
ORDER BY 
    s.course_id, s.sec_id, i.name;

-- Questão 4: Calcular os pontos totais recebidos por aluno (nota * créditos)
SELECT 
    s.ID,
    s.name,
    c.title,
    d.dept_name,
    t.grade,
    gp.points,
    c.credits,
    (gp.points * c.credits) AS total_points
FROM 
    student s
JOIN 
    takes t ON s.ID = t.ID
JOIN 
    course c ON t.course_id = c.course_id
JOIN 
    department d ON c.dept_name = d.dept_name
JOIN 
    grade_points gp ON t.grade = gp.grade
ORDER BY 
    s.ID;

-- Questão 5: Criar uma VIEW chamada coeficiente_rendimento com os dados da questão 4
CREATE VIEW coeficiente_rendimento AS
SELECT 
    s.ID,
    s.name,
    c.title,
    d.dept_name,
    t.grade,
    gp.points,
    c.credits,
    (gp.points * c.credits) AS total_points
FROM 
    student s
JOIN 
    takes t ON s.ID = t.ID
JOIN 
    course c ON t.course_id = c.course_id
JOIN 
    department d ON c.dept_name = d.dept_name
JOIN 
    grade_points gp ON t.grade = gp.grade;
