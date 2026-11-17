<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Loja Web</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<header class="topo">
    <div class="container topo-conteudo">
        <div>
            <h1>Loja Web</h1>
            <span>Programação para Web I</span>
        </div>
        <nav class="menu">
            <a class="ativo" href="${pageContext.request.contextPath}/">Início</a>
            <a href="${pageContext.request.contextPath}/produtos">Produtos</a>
            <a href="${pageContext.request.contextPath}/carrinho">Carrinho</a>
            <c:choose>
                <c:when test="${not empty sessionScope.usuarioLogado}">
                    <span>Olá, ${sessionScope.usuarioLogado.nome}</span>
                    <form action="${pageContext.request.contextPath}/logout" method="post" style="display:inline">
                        <button class="btn btn-secundario" type="submit">Sair</button>
                    </form>
                </c:when>
                <c:otherwise>
                    <a class="btn btn-primario" href="${pageContext.request.contextPath}/login">Entrar</a>
                </c:otherwise>
            </c:choose>
        </nav>
    </div>
</header>

<main>
    <section class="hero">
        <div class="container">
            <span class="badge">Projeto Java Web</span>
            <h2>Sua loja de equipamentos de informática</h2>
            <p>Projeto didático para praticar HTTP, Servlets, HttpSession, JSP, EL/JSTL e organização de endpoints.</p>
            <div class="hero-acoes">
                <a class="btn btn-primario" href="${pageContext.request.contextPath}/produtos">Ver produtos</a>
                <a class="btn btn-secundario" href="${pageContext.request.contextPath}/carrinho">Meu carrinho</a>
            </div>
        </div>
    </section>

    <section class="container secao">
        <h2>Conheça a aplicação</h2>
        <div class="cards">
            <article class="card">
                <h3>Produtos</h3>
                <p>Consulte os equipamentos disponíveis na loja.</p>
                <a href="${pageContext.request.contextPath}/produtos">Ver produtos →</a>
            </article>
            <article class="card">
                <h3>Carrinho</h3>
                <p>Adicione produtos e mantenha suas escolhas durante a sessão.</p>
                <a href="${pageContext.request.contextPath}/carrinho">Ver carrinho →</a>
            </article>
            <article class="card">
                <h3>Autenticação</h3>
                <p>Entre para manter seu usuário disponível durante a navegação.</p>
            </article>
        </div>
    </section>
</main>
<footer><div class="container">Programação para Web I</div></footer>
</body>
</html>
