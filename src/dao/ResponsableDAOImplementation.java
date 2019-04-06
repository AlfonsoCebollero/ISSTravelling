package dao;

import java.util.Collection;

import org.hibernate.Session;

import model.Responsable;


public class ResponsableDAOImplementation implements ResponsableDAO{
	
	private static ResponsableDAOImplementation instance = null;

	private ResponsableDAOImplementation() {
	}

	public static ResponsableDAOImplementation getInstance() {
		if (instance == null) {
			instance = new ResponsableDAOImplementation();
		}
		return instance;
	}

	public void create(Responsable responsable) {
		Session session = SessionFactoryService.get().openSession();
		try {
			session.beginTransaction();
			session.save(responsable);
			session.getTransaction().commit();
		} catch (Exception e) {
			System.out.println("No se ha podido crear Responsable");
		} finally {
			session.close();
		}
	}

	public void delete(Responsable responsable) {
		Session session = SessionFactoryService.get().openSession();
		try {
			session.beginTransaction();
			session.delete(responsable);
			session.getTransaction().commit();
		} catch (Exception e) {
			System.out.println("No se ha podido borrar Responsable");
		} finally {
			session.close();
		}
	}

	public Responsable read(String email) {
		Session session = SessionFactoryService.get().openSession();
		Responsable responsable = null;
		try {
			session.beginTransaction();
			responsable = session.load(Responsable.class, email);
			session.getTransaction().commit();
		} catch (Exception e) {
			System.out.println("No se ha podido leer Responsable");
		} finally {
			session.close();
		}
		return responsable;
	}

	public Collection<Responsable> readAll() {
		Session session = SessionFactoryService.get().openSession();
		Collection<Responsable> responsables = null;
		try {
			session.beginTransaction();
			responsables = session.createQuery("from Responsable").list();
			session.getTransaction().commit();
		} catch (Exception e) {
			System.out.println("No se ha podido leer todos los Responsables");
		} finally {
			session.close();
		}
		return responsables;
	}

	public void update(Responsable responsable) {
		Session session = SessionFactoryService.get().openSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(responsable);
			session.getTransaction().commit();
		} catch (Exception e) {
			System.out.println("No se ha podido actualizar Responsable");
		} finally {
			session.close();
		}
	}
	
	public boolean exists(String email) {
		boolean exists = true;
		Responsable responsable = read(email);
		try {
			if(responsable.getName() == null || responsable.getName() == "") {
				exists = false;
			}
		} catch (Exception e) {
			exists = false;
		}
		return exists;
	}

}
