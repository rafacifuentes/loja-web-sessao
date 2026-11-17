package br.edu.ifto.web.dao;

import br.edu.ifto.web.config.ConexaoBanco;
import br.edu.ifto.web.model.Produto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/** Acessa os produtos persistidos no MySQL. */
public class ProdutoRepository {

    public List<Produto> listarTodos() throws SQLException {
        String sql = "SELECT id, nome, descricao, preco, icone FROM produtos ORDER BY id";
        List<Produto> produtos = new ArrayList<>();

        try (Connection conexao = ConexaoBanco.obterConexao();
             PreparedStatement comando = conexao.prepareStatement(sql);
             ResultSet resultado = comando.executeQuery()) {

            while (resultado.next()) {
                produtos.add(new Produto(
                        resultado.getInt("id"),
                        resultado.getString("nome"),
                        resultado.getString("descricao"),
                        resultado.getBigDecimal("preco"),
                        resultado.getString("icone")
                ));
            }
        }
        return produtos;
    }

    public Produto buscarPorId(int id) throws SQLException {
        String sql = "SELECT id, nome, descricao, preco, icone FROM produtos WHERE id = ?";

        try (Connection conexao = ConexaoBanco.obterConexao();
             PreparedStatement comando = conexao.prepareStatement(sql)) {
            comando.setInt(1, id);

            try (ResultSet resultado = comando.executeQuery()) {
                if (resultado.next()) {
                    return new Produto(
                            resultado.getInt("id"),
                            resultado.getString("nome"),
                            resultado.getString("descricao"),
                            resultado.getBigDecimal("preco"),
                            resultado.getString("icone")
                    );
                }
            }
        }
        return null;
    }
}
