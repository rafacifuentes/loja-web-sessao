package br.edu.ifto.web.servlet;
import br.edu.ifto.web.model.ItemCarrinho;
import javax.servlet.*;import javax.servlet.annotation.WebServlet;import javax.servlet.http.*;
import java.io.IOException;import java.math.BigDecimal;import java.util.*;
@WebServlet("/carrinho") public class CarrinhoServlet extends HttpServlet {
 @Override protected void doGet(HttpServletRequest req,HttpServletResponse resp)throws ServletException,IOException{
 HttpSession sessao=req.getSession();List<ItemCarrinho> itens;int quantidade=0;BigDecimal total=BigDecimal.ZERO;
 synchronized(sessao){
 @SuppressWarnings("unchecked") Map<Integer,ItemCarrinho> carrinho=(Map<Integer,ItemCarrinho>)sessao.getAttribute("carrinho");
 itens=carrinho==null?new ArrayList<>():new ArrayList<>(carrinho.values());
 for(ItemCarrinho item:itens){quantidade+=item.getQuantidade();total=total.add(item.getSubtotal());}
 }
 req.setAttribute("itens",itens);req.setAttribute("quantidadeTotal",quantidade);req.setAttribute("valorTotal",total);
 req.getRequestDispatcher("/WEB-INF/views/carrinho.jsp").forward(req,resp);
 }
 @Override protected void doDelete(HttpServletRequest req,HttpServletResponse resp)throws IOException{
 HttpSession sessao=req.getSession(false);if(sessao!=null)synchronized(sessao){sessao.removeAttribute("carrinho");}
 resp.setStatus(HttpServletResponse.SC_NO_CONTENT);
 }
}
