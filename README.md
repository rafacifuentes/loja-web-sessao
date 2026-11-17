# Loja Web — Programação para Web I

Projeto original da atividade, mantendo as páginas JSP e o CSS fornecidos. A adaptação para banco substitui os repositórios em memória por JDBC/MySQL; o Tomcat 9 continua sendo o servidor da aplicação.

## O que foi alterado

- Produtos são consultados na tabela `produtos` do MySQL.
- Login consulta a tabela `usuarios` do MySQL.
- Carrinho continua na `HttpSession`, como no projeto-base.
- `database/loja_web.sql` cria as tabelas e cadastra cinco produtos e dois usuários de teste.
- A tela de login recebeu os estilos que faltavam; cabeçalho e navegação foram padronizados nas páginas internas.
- O layout original (`index.jsp`, login, carrinho e `style.css`) foi preservado. A tela de produtos só mostra uma mensagem de aviso se a consulta ao banco falhar.

## Executar tudo com Docker

Requisitos: Docker Desktop com Docker Compose.

Na pasta onde está este README:

```bash
docker compose up --build -d
```

Acesse: <http://localhost:8080/loja-web-sessao/>.

Verifique os logs da aplicação e do banco:

```bash
docker compose logs --tail=150 loja-web banco
```

### Importante: banco de dados que já possui volume

O MySQL executa `database/loja_web.sql` automaticamente somente quando cria o volume de dados pela primeira vez. Se o container já existia, o script de inicialização pode não ter sido executado.

**Sem apagar o volume ou os dados existentes**, no PowerShell do Windows execute:

```powershell
.\scripts\importar-banco.ps1
```

Esse script reaplica o SQL de forma idempotente (`CREATE TABLE IF NOT EXISTS` e `INSERT IGNORE`) e mostra quantos produtos e usuários existem.

Para verificar os logs e diagnosticar erros:

```powershell
.\scripts\diagnostico.ps1
```

Se preferir recriar o banco de testes do zero, somente quando não houver dados importantes:

```bash
docker compose down -v
docker compose up --build -d
```

**Atenção:** `down -v` apaga os dados que estejam guardados no volume MySQL.

Confira se o banco inicializou:

```bash
docker compose logs --tail=100 banco
```

E se a aplicação conectou:

```bash
docker compose logs --tail=100 loja-web
```

## Executar com Tomcat local e MySQL no Docker

Se preferir continuar iniciando o Tomcat pelo IntelliJ:

1. Suba apenas o banco:

   ```bash
   docker compose up -d banco
   ```

2. Configure no processo do Tomcat estas variáveis:

   ```text
   DB_HOST=localhost
   DB_PORT=3306
   DB_NAME=loja_web
   DB_USER=loja_user
   DB_PASSWORD=loja_pass
   ```

3. Gere o WAR e implante no Tomcat 9:

   ```bash
   mvn clean package
   ```

   Arquivo: `target/loja-web-sessao.war`.

## Contas de teste

- `carlos@loja.com` / `123456`
- `ana@loja.com` / `123456`

As senhas estão em texto simples somente para o exercício didático e compatibilidade com o login original. Em uma aplicação real, devem ser armazenadas com hash seguro.

## GitHub Codespaces

A pasta `.devcontainer` prepara Java e ferramentas Docker. O Compose inicia MySQL e Tomcat. A porta 8080 é encaminhada para abrir a loja. A visibilidade pública do repositório e a visibilidade da porta encaminhada são configurações diferentes.

## Tecnologias

Java 17, Maven, Java EE 8 / Servlet 4.0 (`javax.servlet`), JSP, JSTL, JDBC, MySQL 8 e Tomcat 9.


## Inicialização/reparo do MySQL em volume já existente (Windows PowerShell)

Com o Docker Desktop aberto, na pasta raiz do projeto execute:

```powershell
Set-ExecutionPolicy -Scope Process Bypass -Force
.\scripts\importar-banco.ps1
docker compose up --build -d --force-recreate loja-web
```

O script prepara as permissões do usuário `loja_user`, importa as tabelas/dados sem apagar o volume e testa a consulta pelo usuário da aplicação. O Tomcat registra no log `[BANCO] Conexão JDBC com MySQL estabelecida com sucesso` quando a conexão real funcionar. Depois acesse `http://localhost:8080/loja-web-sessao/`.
