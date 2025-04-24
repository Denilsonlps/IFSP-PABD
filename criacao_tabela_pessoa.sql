
-- ================================
-- QUESTÃO 1: Criação da Tabela Pessoa com cláusula CHECK em idade
-- ================================

CREATE TABLE Pessoa (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    sobrenome VARCHAR(100) NOT NULL,
    idade INT CHECK (idade >= 0)
);

-- ================================
-- QUESTÃO 2: Adição da restrição UNIQUE para os campos id, nome e sobrenome
-- ================================

ALTER TABLE Pessoa
ADD CONSTRAINT uq_id_nome_sobrenome
UNIQUE (id, nome, sobrenome);

-- ================================
-- QUESTÃO 3: Alteração da coluna idade para NÃO aceitar valores nulos
-- ================================

ALTER TABLE Pessoa
MODIFY idade INT NOT NULL CHECK (idade >= 0);

-- ================================
-- QUESTÃO 4: Criação da tabela Endereco e integridade referencial com Pessoa
-- ================================

-- Criação da tabela Endereco
CREATE TABLE Endereco (
    id INT AUTO_INCREMENT PRIMARY KEY,
    rua VARCHAR(255) NOT NULL
);

-- Adição do campo id_endereco na tabela Pessoa
ALTER TABLE Pessoa
ADD COLUMN id_endereco INT;

-- Criação da chave estrangeira (integridade referencial)
ALTER TABLE Pessoa
ADD CONSTRAINT fk_pessoa_endereco
FOREIGN KEY (id_endereco) REFERENCES Endereco(id);
