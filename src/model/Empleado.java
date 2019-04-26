package model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

@Entity
public class Empleado  implements Serializable{
	@Id
	private String email;
	private String password;
	private String name;
	private String telefono;
	
	@OneToMany(mappedBy = "advisor", fetch = FetchType.EAGER)
	private Collection<Viaje> advisedViajes;
	
	@ManyToOne
	private Empleado advisor2;
	
	@OneToMany(mappedBy = "advisor2", fetch = FetchType.LAZY)
	private Collection<Empleado> advisedEmpleados;

	public String getEmail() {
		return email;
	}


	public Collection<Empleado> getAdvisedEmpleados() {
		return advisedEmpleados;
	}


	public void setAdvisedEmpleados(Collection<Empleado> advisedEmpleados) {
		this.advisedEmpleados = advisedEmpleados;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getTelefono() {
		return telefono;
	}


	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}


	public Collection<Viaje> getAdvisedViajes() {
		Collection<Viaje> out = new ArrayList<Viaje>();
		for(Viaje viaje : advisedViajes) {
			boolean esta = false;
			for(Viaje viaje2 : out) {
				if(viaje2.getId()==viaje.getId()) {
					esta=true;
				}
			}if(!esta) {
				out.add(viaje);
			}
		}
		return out;
	}


	public void setAdvisedViajes(Collection<Viaje> advisedViajes) {
		this.advisedViajes = advisedViajes;
	}


	public Empleado getAdvisor2() {
		return advisor2;
	}


	public void setAdvisor2(Empleado advisor2) {
		this.advisor2 = advisor2;
	}

}
