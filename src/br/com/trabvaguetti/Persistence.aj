package br.com.trabvaguetti;

public aspect Persistence {
	pointcut save() : call (* PF.salvar(..));
	pointcut delete() : call (* PF.excluir(..));
	pointcut edit() : call (* PF.alterar(..));
	pointcut list() : call (* PF.listar(..));
	
	after (PF p) : save() && target(p){
		System.out.println("\ninsert into pessoa values ("+p.getCpf()+", '"+p.getNome()+"')");
	}
	after (PF p) : delete() && target(p){
		System.out.println("\ndelete from pessoa where nome = '"+p.getNome()+"' and cpf = "+p.getCpf()+"");
	}
	after (PF p) : edit() && target(p){
		System.out.println("\ninsert into pessoa values ("+p.getCpf()+", '"+p.getNome()+"')");
	}
	after (PF p) : list() && target(p){
		System.out.println("\nselect * from pessoa where nome = '"+p.getNome()+"' and cpf = "+p.getCpf()+"");
	}
}