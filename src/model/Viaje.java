package model;

import java.io.Serializable;
import java.sql.Date;
import java.util.Collection;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;



@Entity
public class Viaje implements Serializable{
	
	@Id @GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	private String destino;
	private Date fecha_inicio;
	private Date fecha_fin;
	private int presupuesto;
	private int status;
	
	@ManyToOne
	private Empleado advisor;
	
	@OneToMany(mappedBy = "advisor4", fetch = FetchType.EAGER)
	private Collection<Factura> advisedFacturas;
	
	
	public Collection<Factura> getAdvisedFacturas() {
		return advisedFacturas;
	}


	public void setAdvisedFacturas(Collection<Factura> advisedFacturas) {
		this.advisedFacturas = advisedFacturas;
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getDestino() {
		return destino;
	}


	public void setDestino(String destino) {
		this.destino = destino;
	}


	public Date getFecha_inicio() {
		return fecha_inicio;
	}


	public void setFecha_inicio(Date fecha_inicio) {
		this.fecha_inicio = fecha_inicio;
	}


	public Date getFecha_fin() {
		return fecha_fin;
	}


	public void setFecha_fin(Date fecha_fin) {
		this.fecha_fin = fecha_fin;
	}


	public int getPresupuesto() {
		return presupuesto;
	}


	public void setPresupuesto(int presupuesto) {
		this.presupuesto = presupuesto;
	}


	public int getStatus() {
		return status;
	}


	public void setStatus(int status) {
		this.status = status;
	}


	public Empleado getAdvisor() {
		return advisor;
	}


	public void setAdvisor(Empleado advisor) {
		this.advisor = advisor;
	}

}
