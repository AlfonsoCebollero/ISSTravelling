package dao;

import java.util.Collection;

import org.hibernate.Session;

import model.Factura;

public class FacturaDAOImplementation implements FacturaDAO{
	
	private static FacturaDAOImplementation instance = null;

	private FacturaDAOImplementation() {
	}

	public static FacturaDAOImplementation getInstance() {
		if (instance == null) {
			instance = new FacturaDAOImplementation();
		}
		return instance;
	}

	public void create(Factura factura) {
		Session session = SessionFactoryService.get().openSession();
		try {
			session.beginTransaction();
			session.save(factura);
			session.getTransaction().commit();
		} catch (Exception e) {
			System.out.println("No se ha podido crear Factura");
		} finally {
			session.close();
		}
	}

	public void delete(Factura factura) {
		Session session = SessionFactoryService.get().openSession();
		try {
			session.beginTransaction();
			session.delete(factura);
			session.getTransaction().commit();
		} catch (Exception e) {
			System.out.println("No se ha podido borrar Factura");
		} finally {
			session.close();
		}
	}

	public Factura read(int id) {
		Session session = SessionFactoryService.get().openSession();
		Factura factura = null;
		try {
			session.beginTransaction();
			factura = session.load(Factura.class, id);
			session.getTransaction().commit();
		} catch (Exception e) {
			System.out.println("No se ha podido leer Factura");
		} finally {
			session.close();
		}
		return factura;
	}

	public Collection<Factura> readAll() {
		Session session = SessionFactoryService.get().openSession();
		Collection<Factura> facturas = null;
		try {
			session.beginTransaction();
			facturas = session.createQuery("from Factura").list();
			session.getTransaction().commit();
		} catch (Exception e) {
			System.out.println("No se ha podido leer todos las Facturas");
		} finally {
			session.close();
		}
		return facturas;
	}

	public void update(Factura factura) {
		Session session = SessionFactoryService.get().openSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(factura);
			session.getTransaction().commit();
		} catch (Exception e) {
			System.out.println("No se ha podido actualizar Factura");
		} finally {
			session.close();
		}
	}
	
	public boolean exists(int id) {
		boolean exists = true;
		Factura factura = read(id);
		try {
			if(factura.getEstado()  == 0) {
				exists = false;
			}
		} catch (Exception e) {
			exists = false;
		}
		return exists;
	}

}
