package br.com.trabvaguetti;

public class User {
	private int id;
	private String login;
	private String senha;
	private List<User> perfil;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getLogin() {
		return login;
	}
	public void setLogin(String login) {
		this.login = login;
	}
	public String getSenha() {
		return senha;
	}
	public void setSenha(String senha) {
		this.senha = senha;
	}
	public List<User> getPerfil() {
		return perfil;
	}
	public void setPerfil(List<User> perfil) {
		this.perfil = perfil;
	}
}
