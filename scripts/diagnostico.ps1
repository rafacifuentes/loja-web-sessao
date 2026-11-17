Write-Host '=== Estado dos containers ==='
docker compose ps
Write-Host "`n=== Logs recentes do MySQL e Tomcat ==="
docker compose logs --tail=100 banco loja-web
Write-Host "`n=== Tabelas e quantidades no MySQL ==="
docker compose exec banco mysql -uloja_user -ploja_pass loja_web -e 'SHOW TABLES; SELECT COUNT(*) AS total_produtos FROM produtos; SELECT COUNT(*) AS total_usuarios FROM usuarios;'
