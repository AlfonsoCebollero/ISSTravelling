package model;

import java.io.Serializable;
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
	private Responsable advisor2;
	

	public String getEmail() {
		return email;
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
		return advisedViajes;
	}


	public void setAdvisedViajes(Collection<Viaje> advisedViajes) {
		this.advisedViajes = advisedViajes;
	}


	public Responsable getAdvisor2() {
		return advisor2;
	}


	public void setAdvisor2(Responsable advisor2) {
		this.advisor2 = advisor2;
	}

}
