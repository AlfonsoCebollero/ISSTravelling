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
public class Responsable  implements Serializable{
	@Id
	private String email;
	private String password;
	private String name;
	
	
	@OneToMany(mappedBy = "advisor2", fetch = FetchType.EAGER)
	private Collection<Empleado> advisedEmpleados;
	

	@OneToOne(fetch = FetchType.EAGER)
	private Empleado advisor3;
	
	
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

	public Collection<Empleado> getAdvisedEmpleados() {
		Collection<Empleado> out = new ArrayList<Empleado>();
		for(Empleado empleado : advisedEmpleados) {
			boolean esta = false;
			for(Empleado empleado2 : out) {
				if(empleado2.getEmail()==empleado.getEmail()) {
					esta=true;
				}
			}if(!esta) {
				out.add(empleado);
			}
		}
		return out;
	}

	public void setAdvisedEmpleados(Collection<Empleado> advisedEmpleados) {
		this.advisedEmpleados = advisedEmpleados;
	}

	public Empleado getAdvisor3() {
		return advisor3;
	}

	public void setAdvisor3(Empleado advisor3) {
		this.advisor3 = advisor3;
	}

	

}
