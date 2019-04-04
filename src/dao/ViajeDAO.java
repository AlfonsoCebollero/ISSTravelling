package dao;

import java.util.Collection;

import model.Viaje;


public interface ViajeDAO {
	public void create(Viaje viaje);
	public Viaje read(int id);
	public void update(Viaje viaje);
	public void delete(Viaje viaje);
	public Collection<Viaje> readAll();

}
