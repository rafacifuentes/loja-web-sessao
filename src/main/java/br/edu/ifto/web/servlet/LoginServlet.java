package br.edu.ifto.web.servlet;

import br.edu.ifto.web.dao.UsuarioRepository;
import br.edu.ifto.web.model.Usuario;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final UsuarioRepository repository = new UsuarioRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sessao = request.getSession(false);
        if (sessao != null && sessao.getAttribute("usuarioLogado") != null) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        final Usuario usuario;
        try {
            usuario = repository.autenticar(email, senha);
        } catch (SQLException e) {
            getServletContext().log("Erro ao autenticar usuário no banco de dados.", e);
            request.setAttribute("erro", "Não foi possível realizar o login. Verifique a conexão com o banco de dados.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }

        if (usuario == null) {
            request.setAttribute("erro", "E-mail ou senha inválidos.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }

        HttpSession sessao = request.getSession();
        request.changeSessionId();
        sessao.setAttribute("usuarioLogado", usuario);
        response.sendRedirect(request.getContextPath() + "/");
    }
}
