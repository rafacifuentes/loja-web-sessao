package br.edu.ifto.web.model;
import java.math.BigDecimal;
public class Produto {
 private final int id; private final String nome, descricao, icone; private final BigDecimal preco;
 public Produto(int id,String nome,String descricao,BigDecimal preco,String icone){this.id=id;this.nome=nome;this.descricao=descricao;this.preco=preco;this.icone=icone;}
 public int getId(){return id;} public String getNome(){return nome;} public String getDescricao(){return descricao;} public BigDecimal getPreco(){return preco;} public String getIcone(){return icone;}
}
