package dao;

import java.util.Collection;

import model.Factura;


public interface FacturaDAO {
	public void create(Factura factura);
	public Factura read(int id);
	public void update(Factura factura);
	public void delete(Factura factura);
	public Collection<Factura> readAll();

}
