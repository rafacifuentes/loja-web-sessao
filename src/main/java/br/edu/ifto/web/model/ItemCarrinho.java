package br.edu.ifto.web.model;
import java.math.BigDecimal;
public class ItemCarrinho {
 private final Produto produto; private int quantidade;
 public ItemCarrinho(Produto produto){this.produto=produto;this.quantidade=1;}
 public Produto getProduto(){return produto;} public int getQuantidade(){return quantidade;}
 public void incrementar(){quantidade++;} public BigDecimal getSubtotal(){return produto.getPreco().multiply(BigDecimal.valueOf(quantidade));}
}
