package br.com.trabvaguetti;

import java.util.Date;

public class Testar {
	public static void main(String[] args){

		Date date = new Date();
		
		PF pf = new PF();
		
		pf.setNome("Maxwell"); // Generic
		pf.setDataNascimento(date); // Generic
		
		pf.setEmail("mmmm"); // Pessoa
		
		// PF
		pf.setId(1);
		pf.setCpf("000.000.000-00");
		
		pf.salvar();
		pf.alterar();
		pf.excluir();
		pf.listar();
		
	}
}
