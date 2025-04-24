
-- ================================
-- QUESTÃO 01: Criação do SCHEMA avaliaocontinua
-- ================================
CREATE SCHEMA avaliacaocontinua;

-- ================================
-- QUESTÃO 02: Criação da tabela company
-- ================================
CREATE TABLE avaliacaocontinua.company (
    company_name VARCHAR(100) NOT NULL PRIMARY KEY,
    city VARCHAR(100)
);

-- ================================
-- QUESTÃO 03: Criação da tabela employee
-- ================================
CREATE TABLE avaliacaocontinua.employee (
    person_name VARCHAR(100) NOT NULL PRIMARY KEY,
    street VARCHAR(100),
    city VARCHAR(100)
);

-- ================================
-- QUESTÃO 04: Criação da tabela manages
-- ================================
CREATE TABLE avaliacaocontinua.manages (
    person_name VARCHAR(100) NOT NULL PRIMARY KEY,
    manager_name VARCHAR(100)
);

-- ================================
-- QUESTÃO 05: Criação da tabela works
-- ================================
CREATE TABLE avaliacaocontinua.works (
    person_name VARCHAR(100) NOT NULL,
    company_name VARCHAR(100) NOT NULL,
    salary DECIMAL(10,2),
    PRIMARY KEY (person_name)
);

-- ================================
-- QUESTÃO 06: Integridade referencial works → employee (com ações em cascata)
-- ================================
ALTER TABLE avaliacaocontinua.works
ADD CONSTRAINT fk_works_employee
FOREIGN KEY (person_name) REFERENCES avaliacaocontinua.employee(person_name)
ON UPDATE CASCADE ON DELETE CASCADE;

-- ================================
-- QUESTÃO 07: Integridade referencial works → company (com ações em cascata)
-- ================================
ALTER TABLE avaliacaocontinua.works
ADD CONSTRAINT fk_works_company
FOREIGN KEY (company_name) REFERENCES avaliacaocontinua.company(company_name)
ON UPDATE CASCADE ON DELETE CASCADE;

-- ================================
-- QUESTÃO 08: Integridade referencial manages → employee (com ações em cascata)
-- ================================
ALTER TABLE avaliacaocontinua.manages
ADD CONSTRAINT fk_manages_employee
FOREIGN KEY (person_name) REFERENCES avaliacaocontinua.employee(person_name)
ON UPDATE CASCADE ON DELETE CASCADE;
