package dao;

import java.util.Calendar;
import java.util.Collection;

import org.hibernate.Session;

import model.Viaje;

public class ViajeDAOImplementation implements ViajeDAO{

	
	private static ViajeDAOImplementation instance = null;

	private ViajeDAOImplementation() {
	}

	public static ViajeDAOImplementation getInstance() {
		if (instance == null) {
			instance = new ViajeDAOImplementation();
		}
		return instance;
	}

	public void create(Viaje viaje) {
		Session session = SessionFactoryService.get().openSession();
		try {
			session.beginTransaction();
			session.save(viaje);
			session.getTransaction().commit();
		} catch (Exception e) {
			System.out.println("No se ha podido crear Viaje");
		} finally {
			session.close();
		}
	}

	public void delete(Viaje viaje) {
		Session session = SessionFactoryService.get().openSession();
		try {
			session.beginTransaction();
			session.delete(viaje);
			session.getTransaction().commit();
		} catch (Exception e) {
			System.out.println("No se ha podido borrar Viaje");
		} finally {
			session.close();
		}
	}

	public Viaje read(int id) {
		Session session = SessionFactoryService.get().openSession();
		Viaje viaje = null;
		try {
			session.beginTransaction();
			viaje = session.load(Viaje.class, id);
			session.getTransaction().commit();
		} catch (Exception e) {
			System.out.println("No se ha podido leer Viaje");
		} finally {
			session.close();
		}
		return viaje;
	}

	public Collection<Viaje> readAll() {
		Session session = SessionFactoryService.get().openSession();
		Collection<Viaje> viajes = null;
		try {
			session.beginTransaction();
			viajes = session.createQuery("from Viaje").list();
			session.getTransaction().commit();
		} catch (Exception e) {
			System.out.println("No se ha podido leer todos los Viajes");
		} finally {
			session.close();
			for(Viaje viaje : viajes) {
				java.sql.Date sqlDate = new java.sql.Date(Calendar.getInstance().getTime().getTime());
				if(viaje.getStatus() < 9 && viaje.getStatus() > 2 && viaje.getFecha_inicio().compareTo(sqlDate) <= 0) {
					viaje.setStatus(7);
					if( viaje.getFecha_fin().compareTo(sqlDate) < 0) {
						viaje.setStatus(8);
					}
					update(viaje);
				}
			}
		}
		return viajes;
	}

	public void update(Viaje viaje) {
		Session session = SessionFactoryService.get().openSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(viaje);
			session.getTransaction().commit();
		} catch (Exception e) {
			System.out.println("No se ha podido actualizar Viaje");
		} finally {
			session.close();
		}
	}
}
