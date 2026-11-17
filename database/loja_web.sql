SET NAMES utf8mb4;

-- Estrutura e dados iniciais da Loja Web (MySQL 8+).
-- Execute este arquivo no banco loja_web.

CREATE TABLE IF NOT EXISTS produtos (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(120) NOT NULL,
    descricao VARCHAR(500) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    icone VARCHAR(20) NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS usuarios (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(120) NOT NULL,
    email VARCHAR(160) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT uk_usuarios_email UNIQUE (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Produtos iniciais da aplicação. INSERT IGNORE evita duplicação ao executar novamente.
INSERT IGNORE INTO produtos (id, nome, descricao, preco, icone) VALUES
    (1, 'Notebook', 'Notebook para trabalho e estudos.', 3500.00, '💻'),
    (2, 'Mouse', 'Mouse óptico USB.', 80.00, '🖱️'),
    (3, 'Teclado Mecânico', 'Teclado mecânico para produtividade.', 250.00, '⌨️'),
    (4, 'Monitor', 'Monitor para estação de trabalho.', 1200.00, '🖥️'),
    (5, 'Headset', 'Headset para aulas e reuniões.', 180.00, '🎧');

-- Contas didáticas para testar o login (senha: 123456).
-- Em sistemas reais, senhas devem ser armazenadas com hash seguro.
INSERT IGNORE INTO usuarios (id, nome, email, senha) VALUES
    (1, 'Carlos Lima', 'carlos@loja.com', '123456'),
    (2, 'Ana Beatriz Santos', 'ana@loja.com', '123456');
