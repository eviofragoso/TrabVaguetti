package br.com.trabvaguetti;

public aspect Persistence {
	pointcut save() : call (* Pessoa.salvar(..));
	pointcut delete() : call (* Pessoa.excluir(..));
	pointcut edit() : call (* Pessoa.alterar(..));
	pointcut list() : call (* Pessoa.listar(..));
	
	after (Pessoa p) : save() && target(p){
		System.out.println("\ninsert into pessoa values ("+p.getCpf()+", '"+p.getNome()+"')");
	}
	after (Pessoa p) : delete() && target(p){
		System.out.println("\ndelete from pessoa where nome = '"+p.getNome()+"' and cpf = "+p.getCpf()+"");
	}
	after (Pessoa p) : edit() && target(p){
		System.out.println("\ninsert into pessoa values ("+p.getCpf()+", '"+p.getNome()+"')");
	}
	after (Pessoa p) : list() && target(p){
		System.out.println("\nselect * from pessoa where nome = '"+p.getNome()+"' and cpf = "+p.getCpf()+"");
	}
}