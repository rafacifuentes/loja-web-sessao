<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Loja Web</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=login-final-2">
    <style>
        .login-main-final { min-height: calc(100vh - 160px); display:flex; align-items:center; justify-content:center; padding:44px 20px; }
        .login-panel-final { width:min(460px, 100%); padding:38px 40px; background:#fff; border:1px solid #e1e7e1; border-radius:16px; box-shadow:0 12px 34px rgba(30,70,30,.10); }
        .login-panel-final .login-avatar { width:62px; height:62px; margin:0 auto 16px; display:flex; align-items:center; justify-content:center; border-radius:50%; background:#edf6ed; color:#359830; font-size:30px; }
        .login-panel-final h2 { margin:0 0 9px; text-align:center; color:#2d2d2d; font-size:27px; }
        .login-panel-final .login-description { margin:0 0 28px; text-align:center; color:#666; line-height:1.5; }
        .login-panel-final form { display:flex; flex-direction:column; gap:17px; }
        .login-panel-final .login-field label { display:block; margin:0 0 7px; color:#333; font-weight:700; font-size:14px; }
        .login-panel-final .login-field input { display:block; width:100%; min-height:48px; padding:12px 14px; border:1px solid #cfd8cf; border-radius:8px; background:#fff; color:#333; font:inherit; font-size:15px; }
        .login-panel-final .login-field input:focus { outline:0; border-color:#359830; box-shadow:0 0 0 3px rgba(53,152,48,.14); }
        .login-panel-final button { width:100%; min-height:48px; font-size:16px; }
        .login-panel-final .login-error { margin:0 0 18px; padding:12px 14px; border-left:4px solid #d64545; border-radius:7px; background:#fff0f0; color:#9d2929; font-size:14px; line-height:1.45; }
        .login-panel-final .login-hint { margin-top:24px; padding:13px 14px; border-radius:9px; background:#f4f7f4; color:#626b62; text-align:center; font-size:13px; line-height:1.55; }
        .login-panel-final .login-hint p { margin:3px 0; }
        @media(max-width:560px) { .login-main-final { min-height:auto; padding:32px 16px 42px; } .login-panel-final { padding:29px 22px; } .login-panel-final h2 { font-size:24px; } }
    </style>
</head>
<body>
<header class="topo">
    <div class="container topo-conteudo">
        <div><h1>Loja Web</h1><span>Programação para Web I</span></div>
        <nav class="menu">
            <a href="${pageContext.request.contextPath}/">Início</a>
            <a href="${pageContext.request.contextPath}/produtos">Produtos</a>
            <a href="${pageContext.request.contextPath}/carrinho">Carrinho</a>
            <a class="btn btn-primario ativo" href="${pageContext.request.contextPath}/login">Entrar</a>
        </nav>
    </div>
</header>

<main class="login-main-final">
    <section class="login-panel-final">
        <div class="login-avatar">👤</div>
        <h2>Entre na sua conta</h2>
        <p class="login-description">Informe seu e-mail e senha para continuar.</p>

        <c:if test="${not empty erro}">
            <div class="login-error" role="alert"><c:out value="${erro}"/></div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="login-field">
                <label for="email">E-mail</label>
                <input type="email" id="email" name="email" placeholder="Digite seu e-mail" autocomplete="username" required>
            </div>
            <div class="login-field">
                <label for="senha">Senha</label>
                <input type="password" id="senha" name="senha" placeholder="Digite sua senha" autocomplete="current-password" required>
            </div>
            <button class="btn btn-primario" type="submit">Entrar</button>
        </form>

        <div class="login-hint">
            <p><strong>Conta de teste:</strong> carlos@loja.com / 123456</p>
            <p><strong>Outra conta:</strong> ana@loja.com / 123456</p>
        </div>
    </section>
</main>
<footer><div class="container">Programação para Web I</div></footer>
</body>
</html>
