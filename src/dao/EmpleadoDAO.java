package dao;

import java.util.Collection;

import model.Empleado;


public interface EmpleadoDAO {
	public void create(Empleado empleado);
	public Empleado read(String email);
	public void update(Empleado empleado);
	public void delete(Empleado empleado);
	public Collection<Empleado> readAll();
	public boolean exists(String email);

}
