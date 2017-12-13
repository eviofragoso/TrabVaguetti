package br.com.trabvaguetti;

import java.util.Date;

public class Testar {
	public static void main(String[] args){

		Date date = new Date();
		
		PF pf = new PF();
		
		pf.setNome("Maxwell"); // Generic
		pf.setDataNascimento(date); // Generic
		pf.setId(3);
		
		pf.setEmail("mmmm@gmail.com"); // Pessoa
		
		// PF
		pf.setCpf("000");
		pf.setRg("000");
		pf.setErg("000");
		
		pf.salvar();
		pf.alterar();
		pf.excluir();
		pf.listar();
		
		
		
	}
}
