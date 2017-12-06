package br.com.trabvaguetti;

import java.util.Date;

public class Medicado {

	private Integer id;
	  private Date dataPrevista;
	  private Date dataRealizada;
	  private String observacao;
	  public Integer getId() {
	    return id;
	  }
	  public void setId(Integer id) {
	    this.id = id;
	  }
	  public Date getDataPrevista() {
	    return dataPrevista;
	  }
	  public void setDataPrevista(Date dataPrevista) {
	    this.dataPrevista = dataPrevista;
	  }
	  public Date getDataRealizada() {
	    return dataRealizada;
	  }
	  public void setDataRealizada(Date dataRealizada) {
	    this.dataRealizada = dataRealizada;
	  }
	  public String getObservacao() {
	    return observacao;
	  }
	  public void setObservacao(String observacao) {
	    this.observacao = observacao;
	  }
}
