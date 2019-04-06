package dao;

import java.util.Collection;

import model.Responsable;


public interface ResponsableDAO {
	public void create(Responsable responsable);
	public Responsable read(String email);
	public void update(Responsable responsable);
	public void delete(Responsable responsable);
	public Collection<Responsable> readAll();
	public boolean exists(String email);

}
