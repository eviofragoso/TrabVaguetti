package br.com.trabvaguetti;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.swing.text.html.HTMLDocument.Iterator;

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
		  String pessoa = "insert into pessoa (id, idgeneric, email)";
		  pessoa += "values (?,?,?)";
		  Connection con2 = Conexao.abrirConexao();
		  try {
		   PreparedStatement pst2 = con2.prepareStatement(pessoa);
		   pst2.setInt(1, p.getId());
		   pst2.setInt(2, p.getId());
		   pst2.setString(3, p.getEmail());
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
		  String sql = "insert into pessoafisica (id, idpessoa ,cpf, rg, erg)";
		  sql += "values (?,?,?,?,?)";
		  Connection con = Conexao.abrirConexao();
		  try {
		   PreparedStatement pst = con.prepareStatement(sql);
		   pst.setInt(1, p.getId());
		   pst.setInt(2, p.getId());
		   pst.setString(3, p.getCpf());
		   pst.setString(4, p.getRg());
		   pst.setString(5, p.getErg());
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
		String sql = "delete from pessoafisica where id=";
		sql += "?";
		Connection con = Conexao.abrirConexao();
		try {
			PreparedStatement pst = con.prepareStatement(sql);
			pst.setInt(1, p.getId());
			if (pst.executeUpdate() > 0) {
				Conexao.fecharConexao(con);
				System.out.println("deletou");
			} else {
				Conexao.fecharConexao(con);
				System.out.println("erro n deletou");
			}
		} catch (SQLException e) {
			Conexao.fecharConexao(con);
			System.out.println(e.getMessage());
		}
	}

	after(PF p) : edit() && target(p){
		String sql = "update pessoafisica SET cpf = ? WHERE cpf = ?";
		Connection con = Conexao.abrirConexao();
		try {
			PreparedStatement pst = con.prepareStatement(sql);
			pst.setString(1, "123");
			pst.setString(2, p.getCpf());
			if (pst.executeUpdate() > 0) {
				Conexao.fecharConexao(con);
				System.out.println("update");
			} else {
				Conexao.fecharConexao(con);
				System.out.println("n update");
			}
		} catch (SQLException e) {
			Conexao.fecharConexao(con);
			System.out.println(e.getMessage());
		}
	}

	after(PF p) : list() && target(p){
		String sql = "select id from pessoa";
		Connection con = Conexao.abrirConexao();
		try {
			PreparedStatement pst = con.prepareStatement(sql);
			ArrayList lista = new ArrayList();
			
			ResultSet rs;
			rs = pst.executeQuery();
			while(rs.next())
			    lista.add(rs.getString(1));
			
			while(!lista.isEmpty()){
	            System.out.println(lista.remove(0));
	        }
			 
			pst.close();
		} catch (SQLException e) {
			Conexao.fecharConexao(con);
			System.out.println(e.getMessage());
		}
	}

	before(PF p) : save() && target(p){
		  String sql = "SELECT id FROM generic ORDER BY id DESC LIMIT 1";

		  Connection con = Conexao.abrirConexao();
		  try {
		   PreparedStatement pst = con.prepareStatement(sql);
		   
		   ResultSet rs = pst.executeQuery();
		   
		   
		   if (rs.next()) {
		               p.setId(rs.getInt("id")+1); 
		               System.out.println("Setado ID, "+p.getId());
		            } else {
		                
		            }
		  } catch (SQLException e) {
		   Conexao.fecharConexao(con);
		   System.out.println(e.getMessage());
		  }
		  
		 }
}