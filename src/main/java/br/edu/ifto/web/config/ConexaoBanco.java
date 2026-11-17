package br.edu.ifto.web.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/** Centraliza a conexão JDBC com o MySQL. */
public final class ConexaoBanco {
    private ConexaoBanco() {
    }

    public static Connection obterConexao() throws SQLException {
        String url = System.getenv("DB_URL");
        if (url == null || url.isBlank()) {
            String host = variavel("DB_HOST", "localhost");
            String porta = variavel("DB_PORT", "3306");
            String banco = variavel("DB_NAME", "loja_web");
            url = "jdbc:mysql://" + host + ":" + porta + "/" + banco
                    + "?sslMode=DISABLED&allowPublicKeyRetrieval=true"
                    + "&serverTimezone=UTC&characterEncoding=UTF-8"
                    + "&connectTimeout=10000&socketTimeout=15000";
        }

        String usuario = variavel("DB_USER", "loja_user");
        String senha = variavel("DB_PASSWORD", "loja_pass");

        try {
            // Registro explícito evita depender apenas da descoberta automática do driver no Tomcat.
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver JDBC do MySQL não encontrado em WEB-INF/lib.", e);
        }

        return DriverManager.getConnection(url, usuario, senha);
    }

    private static String variavel(String nome, String padrao) {
        String valor = System.getenv(nome);
        return valor == null || valor.isBlank() ? padrao : valor;
    }
}
