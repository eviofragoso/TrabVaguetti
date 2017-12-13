package br.com.trabvaguetti;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public aspect Persistence {
	pointcut save() : call (* PF.salvar(..));
	pointcut delete() : call (* PF.excluir(..));
	pointcut edit() : call (* PF.alterar(..));
	pointcut list() : call (* PF.listar(..));

	after(PF p) : save() && target(p){
		//--------------------- INSERIR NA GENERIC ---------------------------//
		String insertGeneric = "insert into generic (id, nome, datanascimento)";
		insertGeneric += "values (?,?,?)";
		Connection con1 = Conexao.abrirConexao();
		try {
			PreparedStatement pst1 = con1.prepareStatement(insertGeneric);
			pst1.setInt(1, p.getId());
			pst1.setString(2, p.getNome());
			pst1.setDate(3, java.sql.Date.valueOf(java.time.LocalDate.now()));

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
		
		//--------------------- INSERIR NA PESSOA ---------------------------//
		String pessoa = "insert into pessoa (id, email)";
		pessoa += "values (?,?)";
		Connection con2 = Conexao.abrirConexao();
		try {
			PreparedStatement pst2 = con2.prepareStatement(pessoa);
			pst2.setInt(1, p.getId());
			pst2.setString(2, p.getEmail());
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

		//--------------------- INSERIR NA PESSOA FISICA ---------------------------//
		String sql = "insert into pessoafisica (id,cpf, rg, erg)";
		sql += "values (?,?,?,?)";
		Connection con = Conexao.abrirConexao();
		try {
			PreparedStatement pst = con.prepareStatement(sql);
			pst.setInt(1, p.getId());
			pst.setString(2, p.getCpf());
			pst.setString(3, p.getRg());
			pst.setString(4, p.getErg());
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