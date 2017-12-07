package br.com.trabvaguetti;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public aspect Persistence {
	pointcut save() : call (* PF.salvar(..));
	pointcut delete() : call (* PF.excluir(..));
	pointcut edit() : call (* PF.alterar(..));
	pointcut list() : call (* PF.listar(..));
	
	after (PF p) : save() && target(p){
		        String sql = "insert into pessoafisica ";
		        sql += "values (?,?,?,?)";
		        Connection con = Conexao.abrirConexao();
		        try{
		            PreparedStatement pst = con.prepareStatement(sql);
		            pst.setInt(1, p.getId());
		            pst.setString(2, p.getCpf());
		            pst.setString(3, p.getRg());
		            pst.setString(4, p.getErg());
		            if(pst.executeUpdate() > 0){
		                Conexao.fecharConexao(con);
		                System.out.println("ok");
		            }else{
		                Conexao.fecharConexao(con);
		                System.out.println("erro");
		            }
		        }catch(SQLException e){
		            Conexao.fecharConexao(con);
		            System.out.println(e.getMessage());
		        }        
	}
	after (PF p) : delete() && target(p){
		//System.out.println("\ndelete from pessoa where nome = '"+p.getNome()+"' and cpf = "+p.getCpf()+"");
	}
	after (PF p) : edit() && target(p){
		//System.out.println("\ninsert into pessoa values ("+p.getCpf()+", '"+p.getNome()+"')");
	}
	after (PF p) : list() && target(p){
		//System.out.println("\nselect * from pessoa where nome = '"+p.getNome()+"' and cpf = "+p.getCpf()+"");
	}
}