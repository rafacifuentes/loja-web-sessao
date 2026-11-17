<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="pt_BR" />
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Produtos - Loja Web</title>
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
            <a href="${pageContext.request.contextPath}/">Início</a>
            <a class="ativo" href="${pageContext.request.contextPath}/produtos">Produtos</a>
            <a href="${pageContext.request.contextPath}/carrinho">Carrinho</a>
            <c:choose>
                <c:when test="${not empty sessionScope.usuarioLogado}">
                    <span>Olá, <c:out value="${sessionScope.usuarioLogado.nome}"/></span>
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

<main class="container secao">
    <div class="titulo-pagina">
        <div>
            <h2>Nossos produtos</h2>
            <p>Escolha os equipamentos que deseja adicionar ao carrinho.</p>
        </div>
    </div>

    <c:if test="${not empty erro}">
        <div class="aviso" role="alert"><c:out value="${erro}"/></div>
    </c:if>

    <div class="grade-produtos">
        <c:forEach var="produto" items="${produtos}">
            <article class="produto-card">
                <div class="produto-icone"><c:out value="${produto.icone}"/></div>
                <h3><c:out value="${produto.nome}"/></h3>
                <p class="produto-descricao"><c:out value="${produto.descricao}"/></p>
                <strong class="preco"><fmt:formatNumber value="${produto.preco}" type="currency" currencySymbol="R$"/></strong>
                <form action="${pageContext.request.contextPath}/carrinho/itens" method="post">
                    <input type="hidden" name="id" value="${produto.id}">
                    <button class="btn btn-primario btn-bloco" type="submit">Adicionar ao carrinho</button>
                </form>
            </article>
        </c:forEach>
    </div>
</main>
<footer><div class="container">Programação para Web I</div></footer>
</body>
</html>
