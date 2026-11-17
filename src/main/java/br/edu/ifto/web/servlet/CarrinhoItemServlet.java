package br.edu.ifto.web.servlet;

import br.edu.ifto.web.dao.ProdutoRepository;
import br.edu.ifto.web.model.ItemCarrinho;
import br.edu.ifto.web.model.Produto;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

@WebServlet("/carrinho/itens")
public class CarrinhoItemServlet extends HttpServlet {
    private final ProdutoRepository repository = new ProdutoRepository();

    private Integer obterId(HttpServletRequest request) {
        try {
            return Integer.valueOf(request.getParameter("id"));
        } catch (NumberFormatException | NullPointerException e) {
            return null;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer id = obterId(request);
        if (id == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de produto inválido.");
            return;
        }

        final Produto produto;
        try {
            produto = repository.buscarPorId(id);
        } catch (SQLException e) {
            getServletContext().log("Erro ao buscar produto para adicionar ao carrinho.", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Não foi possível consultar o produto no banco de dados.");
            return;
        }

        if (produto == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Produto não encontrado.");
            return;
        }

        HttpSession sessao = request.getSession();
        synchronized (sessao) {
            @SuppressWarnings("unchecked")
            Map<Integer, ItemCarrinho> carrinho =
                    (Map<Integer, ItemCarrinho>) sessao.getAttribute("carrinho");

            if (carrinho == null) {
                carrinho = new LinkedHashMap<>();
                sessao.setAttribute("carrinho", carrinho);
            }

            ItemCarrinho item = carrinho.get(id);
            if (item == null) {
                carrinho.put(id, new ItemCarrinho(produto));
            } else {
                item.incrementar();
            }
        }

        response.sendRedirect(request.getContextPath() + "/carrinho");
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer id = obterId(request);
        if (id == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID inválido.");
            return;
        }

        HttpSession sessao = request.getSession(false);
        if (sessao != null) {
            synchronized (sessao) {
                @SuppressWarnings("unchecked")
                Map<Integer, ItemCarrinho> carrinho =
                        (Map<Integer, ItemCarrinho>) sessao.getAttribute("carrinho");
                if (carrinho != null) {
                    carrinho.remove(id);
                }
            }
        }
        response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    }
}
