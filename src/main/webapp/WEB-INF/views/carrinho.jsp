<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="pt_BR" />
<!DOCTYPE html><html lang="pt-BR"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Carrinho - Loja Web</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head><body>
<header class="topo">
    <div class="container topo-conteudo">
        <div>
            <h1>Loja Web</h1>
            <span>Programação para Web I</span>
        </div>
        <nav class="menu">
            <a href="${pageContext.request.contextPath}/">Início</a>
            <a href="${pageContext.request.contextPath}/produtos">Produtos</a>
            <a class="ativo" href="${pageContext.request.contextPath}/carrinho">Carrinho <span class="contador">${quantidadeTotal}</span></a>
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
<main class="container secao"><div class="titulo-pagina"><div><h2>Meu carrinho</h2><p>Os produtos ficam salvos na sessão deste navegador.</p></div></div>
<div class="carrinho-layout"><section class="carrinho-produtos"><c:choose><c:when test="${empty itens}"><div class="aviso">Seu carrinho está vazio. Adicione produtos para começar.</div></c:when><c:otherwise><c:forEach var="item" items="${itens}"><article class="item-carrinho"><div class="item-icone"><c:out value="${item.produto.icone}"/></div><div class="item-info"><h3><c:out value="${item.produto.nome}"/></h3><span><fmt:formatNumber value="${item.produto.preco}" type="currency" currencySymbol="R$"/></span></div><div class="quantidade"><span>Quantidade</span><strong>${item.quantidade}</strong></div><div class="subtotal"><span>Subtotal</span><strong><fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="R$"/></strong></div><button class="btn-remover" type="button" data-id="${item.produto.id}">Remover</button></article></c:forEach></c:otherwise></c:choose></section>
<aside class="resumo"><h3>Resumo do pedido</h3><div class="resumo-linha"><span>Itens</span><strong>${quantidadeTotal}</strong></div><div class="resumo-linha total"><span>Total</span><strong><fmt:formatNumber value="${valorTotal}" type="currency" currencySymbol="R$"/></strong></div><a class="btn btn-secundario btn-bloco" href="${pageContext.request.contextPath}/produtos">Continuar comprando</a><button id="limpar" class="btn btn-perigo btn-bloco" type="button" ${empty itens ? 'disabled="disabled"' : ''}>Limpar carrinho</button></aside></div></main>
<footer><div class="container">Programação para Web I</div></footer>
<script>
const base = '${pageContext.request.contextPath}';
async function apagar(url){try{const resposta=await fetch(url,{method:'DELETE'});if(!resposta.ok)throw new Error('HTTP '+resposta.status);window.location.reload();}catch(erro){alert('Não foi possível atualizar o carrinho: '+erro.message);}}
document.querySelectorAll('.btn-remover').forEach(botao=>botao.addEventListener('click',()=>apagar(base+'/carrinho/itens?id='+encodeURIComponent(botao.dataset.id))));
document.getElementById('limpar').addEventListener('click',()=>apagar(base+'/carrinho'));
</script></body></html>
