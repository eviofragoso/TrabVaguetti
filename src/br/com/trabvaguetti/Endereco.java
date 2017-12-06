package br.com.trabvaguetti;

public class Endereco {
	 private int id;
	 private String logradouro;
	 private String cep;
	 private String complemento;
	 private String gps;
	 
	 public int getId() {
	  return id;
	 }
	 public void setId(int id) {
	  this.id = id;
	 }
	 public String getLogradouro() {
	  return logradouro;
	 }
	 public void setLogradouro(String logradouro) {
	  this.logradouro = logradouro;
	 }
	 public String getCep() {
	  return cep;
	 }
	 public void setCep(String cep) {
	  this.cep = cep;
	 }
	 public String getComplemento() {
	  return complemento;
	 }
	 public void setComplemento(String complemento) {
	  this.complemento = complemento;
	 }
	 public String getGps() {
	  return gps;
	 }
	 public void setGps(String gps) {
	  this.gps = gps;
	 }
	 
}
