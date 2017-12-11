package br.com.trabvaguetti;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public aspect Persistence {
	pointcut save() : call (* PF.salvar(..));
	pointcut delete() : call (* PF.excluir(..));
	pointcut edit() : call (* PF.alterar(..));
	pointcut list() : call (* PF.listar(..));

	after(PF p) : save() && target(p){
		String sql1 = "insert into generic (nome, datanascimento)";
		sql1 += "values (?,?)";
		Connection con1 = Conexao.abrirConexao();
		try {
			PreparedStatement pst1 = con1.prepareStatement(sql1);
			pst1.setString(1, p.getNome());
			pst1.setDate(2, java.sql.Date.valueOf(java.time.LocalDate.now()));

			if (pst1.executeUpdate() > 0) {
				Conexao.fecharConexao(con1);
				System.out.println("ok");
			} else {
				Conexao.fecharConexao(con1);
				System.out.println("erro");
			}
		} catch (SQLException e) {
			Conexao.fecharConexao(con1);
			System.out.println(e.getMessage());
		}
		
		
		
		
		
		

		
		
		String sql2 = "insert into pessoa (email)";
		sql2 += "values (?)";
		Connection con2 = Conexao.abrirConexao();
		try {
			PreparedStatement pst2 = con2.prepareStatement(sql2);
			pst2.setString(1, p.getEmail());
			if (pst2.executeUpdate() > 0) {
				Conexao.fecharConexao(con2);
				System.out.println("ok");
			} else {
				Conexao.fecharConexao(con2);
				System.out.println("erro");
			}
		} catch (SQLException e) {
			Conexao.fecharConexao(con2);
			System.out.println(e.getMessage());
		}

		
		
		String sql = "insert into pessoafisica (idpessoa,cpf, rg, erg)";
		sql += "values (?,?,?)";
		Connection con = Conexao.abrirConexao();
		try {
			PreparedStatement pst = con.prepareStatement(sql);
			pst.setString(1, p.get);
			pst.setString(1, p.getCpf());
			pst.setString(2, p.getRg());
			pst.setString(3, p.getErg());
			if (pst.executeUpdate() > 0) {
				Conexao.fecharConexao(con);
				System.out.println("ok");
			} else {
				Conexao.fecharConexao(con);
				System.out.println("erro");
			}
		} catch (SQLException e) {
			Conexao.fecharConexao(con);
			System.out.println(e.getMessage());
		}
	}

	after(PF p) : delete() && target(p){
		// System.out.println("\ndelete from pessoa where nome = '"+p.getNome()+"' and
		// cpf = "+p.getCpf()+"");
	}

	after(PF p) : edit() && target(p){
		// System.out.println("\ninsert into pessoa values ("+p.getCpf()+",
		// '"+p.getNome()+"')");
	}

	after(PF p) : list() && target(p){
		// System.out.println("\nselect * from pessoa where nome = '"+p.getNome()+"' and
		// cpf = "+p.getCpf()+"");
	}

	before(Pessoa p) : save() && target(p){
		String sql = "SELECT id FROM generic ORDER BY id DESC LIMIT 1";

		Connection con = Conexao.abrirConexao();
		try {
			PreparedStatement pst = con.prepareStatement(sql);
			pst.setInt(1, 1);
		} catch (SQLException e) {
			Conexao.fecharConexao(con);
			System.out.println(e.getMessage());
		}
	}
}