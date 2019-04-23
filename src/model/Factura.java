package model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;

@Entity
public class Factura implements Serializable{
	
	@Id @GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	private String descripcion;
	private Float cargo;
	private int estado;
	
	@Lob
	private byte[] comprobante;
	
	@ManyToOne
	private Viaje advisor4;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public Float getCargo() {
		return cargo;
	}

	public void setCargo(Float cargo) {
		this.cargo = cargo;
	}

	public int getEstado() {
		return estado;
	}

	public void setEstado(int estado) {
		this.estado = estado;
	}

	public byte[] getComprobante() {
		return comprobante;
	}

	public void setComprobante(byte[] comprobante) {
		this.comprobante = comprobante;
	}

	public Viaje getAdvisor4() {
		return advisor4;
	}

	public void setAdvisor4(Viaje advisor4) {
		this.advisor4 = advisor4;
	}

	

}
