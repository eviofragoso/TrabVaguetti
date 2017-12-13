package br.com.trabvaguetti;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Scanner;

import javax.swing.text.html.HTMLDocument.Iterator;

public aspect Persistence {
	pointcut save() : call (* PF.salvar(..));
	pointcut delete() : call (* PF.excluir(..));
	pointcut edit() : call (* PF.alterar(..));
	pointcut list() : call (* PF.listar(..));
	
	Scanner entrada = new Scanner (System.in);

	after(PF p) : save() && target(p){

		String insertGeneric = "insert into generic (id, nome, datanascimento) values (?,?,?)";
		String insertPessoa = "insert into pessoa (id, idgeneric, email) values (?,?,?)";
		String insertPf = "insert into pessoafisica (id, idpessoa ,cpf, rg, erg) values (?,?,?,?,?)";

		Connection con = Conexao.abrirConexao();
		try {
			// --------------------- INSERIR NA GENERIC ---------------------------//
			PreparedStatement pst = con.prepareStatement(insertGeneric);
			pst.setInt(1, p.getId());
			pst.setString(2, p.getNome());
			pst.setDate(3, java.sql.Date.valueOf(java.time.LocalDate.now()));

			if (pst.executeUpdate() > 0) {
				// --------------------- INSERIR NA PESSOA ---------------------------//
				System.out.println("Inserido em Generic");
				pst = con.prepareStatement(insertPessoa);
				pst.setInt(1, p.getId());
				pst.setInt(2, p.getId());
				pst.setString(3, p.getEmail());

				if (pst.executeUpdate() > 0) {
					// --------------------- INSERIR NA PESSOAFISICA---------------------------//
					System.out.println("Inserido do Pessoa");
					pst = con.prepareStatement(insertPf);
					pst.setInt(1, p.getId());
					pst.setInt(2, p.getId());
					pst.setString(3, p.getCpf());
					pst.setString(4, p.getRg());
					pst.setString(5, p.getErg());

					if (pst.executeUpdate() > 0) {
						Conexao.fecharConexao(con);
						System.out.println("Inserido no pessoaFisica");
					}
				}
			} else {
				Conexao.fecharConexao(con);
				System.out.println("n update");
			}
		} catch (SQLException e) {
			Conexao.fecharConexao(con);
			System.out.println(e.getMessage());
		}
	}

	after(PF p) : delete() && target(p){
		
		System.out.print("Digite o ID para deletar: ");
		int id = Integer.parseInt(entrada.nextLine());

		String sql = "delete from pessoafisica where id=?";
		Connection con = Conexao.abrirConexao();
		try {
			PreparedStatement pst = con.prepareStatement(sql);
			pst.setInt(1, id);
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
		
		System.out.print("Digite o ID que deseja alterar: ");
		int id = Integer.parseInt(entrada.nextLine());
		System.out.print("Digite novo CPF: ");
		String cpf = entrada.nextLine();
		System.out.print("Digite novo RG: ");
		String rg = entrada.nextLine();
		System.out.print("Digite novo ERG: ");
		String erg = entrada.nextLine();
		System.out.print("Digite novo email: ");
		String email = entrada.nextLine();
		System.out.print("Digite novo nome: ");
		String nome = entrada.nextLine();
		System.out.print("Digite nova data de nascimento: ");
		String dataNascimento = entrada.nextLine();
		
		
		String sqlpf = "update pessoafisica SET cpf = ?, rg = ?, erg = ? WHERE id = ?";
		Connection con = Conexao.abrirConexao();
		try {

			PreparedStatement pst = con.prepareStatement(sqlpf);

			pst.setString(1, cpf);
			pst.setString(2, rg);
			pst.setString(3, erg);
			pst.setInt(4, id);
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

		String sqlp = "update pessoa SET email = ? WHERE id = ?";
		Connection con2 = Conexao.abrirConexao();
		try {

			PreparedStatement pst = con2.prepareStatement(sqlp);

			pst.setString(1, email);
			pst.setInt(2, id);
			if (pst.executeUpdate() > 0) {
				Conexao.fecharConexao(con2);
				System.out.println("update");
			} else {
				Conexao.fecharConexao(con2);
				System.out.println("n update");
			}
		} catch (SQLException e) {
			Conexao.fecharConexao(con2);
			System.out.println(e.getMessage());
		}

		String sqlg = "update generic SET nome = ?, datanascimento = ? WHERE id = ?";
		Connection con3 = Conexao.abrirConexao();
		try {

			PreparedStatement pst = con3.prepareStatement(sqlg);

			pst.setString(1, nome);
			pst.setDate(2, java.sql.Date.valueOf(java.time.LocalDate.now()));
			pst.setInt(3, id);
			if (pst.executeUpdate() > 0) {
				Conexao.fecharConexao(con3);
				System.out.println("update");
			} else {
				Conexao.fecharConexao(con3);
				System.out.println("n update");
			}
		} catch (SQLException e) {
			Conexao.fecharConexao(con3);
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
			while (rs.next())
				lista.add(rs.getString(1));

			while (!lista.isEmpty()) {
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
				p.setId(rs.getInt("id") + 1);
				System.out.println("Setado ID, " + p.getId());
			} else {

			}
		} catch (SQLException e) {
			Conexao.fecharConexao(con);
			System.out.println(e.getMessage());
		}

	}
}