package br.edu.ifto.web.config;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.sql.Connection;
import java.sql.SQLException;

/** Registra no log do Tomcat o resultado real do teste de conexão ao iniciar a aplicação. */
@WebListener
public class VerificacaoBancoListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent evento) {
        try (Connection conexao = ConexaoBanco.obterConexao()) {
            evento.getServletContext().log("[BANCO] Conexão JDBC com MySQL estabelecida com sucesso.");
        } catch (SQLException e) {
            evento.getServletContext().log("[BANCO] Falha ao conectar ao MySQL: " + e.getMessage(), e);
        }
    }
}
