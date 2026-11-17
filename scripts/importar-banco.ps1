$ErrorActionPreference = 'Stop'
Set-Location (Split-Path -Parent $PSScriptRoot)

Write-Host 'Preparando usuario e permissoes do MySQL...'
$usuarioSql = @'
CREATE USER IF NOT EXISTS 'loja_user'@'%' IDENTIFIED BY 'loja_pass';
ALTER USER 'loja_user'@'%' IDENTIFIED BY 'loja_pass';
GRANT ALL PRIVILEGES ON loja_web.* TO 'loja_user'@'%';
FLUSH PRIVILEGES;
'@
$usuarioSql | docker compose exec -T banco mysql -uroot -proot_dev_password
if ($LASTEXITCODE -ne 0) { throw 'Falha ao configurar o usuario loja_user no MySQL.' }

Write-Host 'Copiando o script SQL para o container MySQL...'
docker compose cp database/loja_web.sql banco:/tmp/loja_web.sql
if ($LASTEXITCODE -ne 0) { throw 'Falha ao copiar database/loja_web.sql.' }

Write-Host 'Criando tabelas e inserindo dados iniciais...'
docker compose exec -T banco sh -c "mysql -uroot -proot_dev_password loja_web < /tmp/loja_web.sql"
if ($LASTEXITCODE -ne 0) { throw 'Falha ao executar o script SQL.' }

Write-Host 'Testando acesso com o mesmo usuario usado pela aplicacao...'
docker compose exec banco mysql --protocol=TCP -h127.0.0.1 -uloja_user -ploja_pass loja_web -e "SELECT COUNT(*) AS total_produtos FROM produtos; SELECT COUNT(*) AS total_usuarios FROM usuarios;"
if ($LASTEXITCODE -ne 0) { throw 'O usuario loja_user nao consegue consultar o banco.' }

Write-Host 'Banco preparado. Agora reconstrua/reinicie a aplicacao.' -ForegroundColor Green
