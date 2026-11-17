package br.edu.ifto.web.dao;

import br.edu.ifto.web.config.ConexaoBanco;
import br.edu.ifto.web.model.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/** Consulta no MySQL as credenciais dos usuários cadastrados. */
public class UsuarioRepository {

    public Usuario autenticar(String email, String senha) throws SQLException {
        if (email == null || senha == null || email.isBlank() || senha.isBlank()) {
            return null;
        }

        String sql = "SELECT nome, email FROM usuarios WHERE LOWER(email) = LOWER(?) AND senha = ?";

        try (Connection conexao = ConexaoBanco.obterConexao();
             PreparedStatement comando = conexao.prepareStatement(sql)) {
            comando.setString(1, email.trim());
            comando.setString(2, senha);

            try (ResultSet resultado = comando.executeQuery()) {
                if (resultado.next()) {
                    // A senha não é carregada para o objeto guardado na sessão.
                    return new Usuario(resultado.getString("nome"), resultado.getString("email"));
                }
            }
        }
        return null;
    }
}
