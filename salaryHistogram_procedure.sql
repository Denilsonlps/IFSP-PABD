
-- Questão 01: Criação do procedimento salaryHistogram para calcular faixas de salário (histograma)

CREATE PROCEDURE dbo.salaryHistogram @num_intervals INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @min_salary NUMERIC(10,2), 
            @max_salary NUMERIC(10,2),
            @interval_range NUMERIC(10,2),
            @i INT = 0;

    -- Tabela temporária para armazenar o histograma
    DECLARE @Histogram TABLE (
        valorMinimo NUMERIC(10,2),
        valorMaximo NUMERIC(10,2),
        total INT
    );

    -- Buscar o menor e maior salário
    SELECT @min_salary = MIN(salary), @max_salary = MAX(salary)
    FROM instructor;

    -- Calcular tamanho de cada intervalo
    SET @interval_range = (@max_salary - @min_salary) / @num_intervals;

    WHILE @i < @num_intervals
    BEGIN
        DECLARE @range_start NUMERIC(10,2) = @min_salary + (@i * @interval_range);
        DECLARE @range_end NUMERIC(10,2) = @min_salary + ((@i + 1) * @interval_range);

        INSERT INTO @Histogram (valorMinimo, valorMaximo, total)
        SELECT 
            @range_start,
            @range_end,
            COUNT(*) 
        FROM instructor
        WHERE salary > @range_start AND salary <= @range_end;

        SET @i += 1;
    END

    -- Exibir histograma
    SELECT * FROM @Histogram;
END;
