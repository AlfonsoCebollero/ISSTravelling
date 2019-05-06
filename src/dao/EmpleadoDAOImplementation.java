package dao;

import java.util.Collection;

import org.hibernate.Session;

import model.Empleado;

public class EmpleadoDAOImplementation implements EmpleadoDAO{

	private static EmpleadoDAOImplementation instance = null;

	public EmpleadoDAOImplementation() {
	}

	public static EmpleadoDAOImplementation getInstance() {
		if (instance == null) {
			instance = new EmpleadoDAOImplementation();
		}
		return instance;
	}

	public void create(Empleado empleado) {
		Session session = SessionFactoryService.get().openSession();
		try {
			session.beginTransaction();
			session.save(empleado);
			session.getTransaction().commit();
		} catch (Exception e) {
			System.out.println("No se ha podido crear Empleado");
		} finally {
			session.close();
		}
	}

	public void delete(Empleado empleado) {
		Session session = SessionFactoryService.get().openSession();
		try {
			session.beginTransaction();
			session.delete(empleado);
			session.getTransaction().commit();
		} catch (Exception e) {
			System.out.println("No se ha podido borrar Empleado");
		} finally {
			session.close();
		}
	}

	public Empleado read(String email) {
		Session session = SessionFactoryService.get().openSession();
		Empleado empleado = null;
		try {
			session.beginTransaction();
			empleado = session.load(Empleado.class, email);
			session.getTransaction().commit();
		} catch (Exception e) {
			System.out.println("No se ha podido leer Empleado");
		} finally {
			session.close();
		}
		return empleado;
	}

	public Collection<Empleado> readAll() {
		Session session = SessionFactoryService.get().openSession();
		Collection<Empleado> empleados = null;
		try {
			session.beginTransaction();
			empleados = session.createQuery("from Empleado").list();
			session.getTransaction().commit();
		} catch (Exception e) {
			System.out.println("No se ha podido leer todos los Empleados");
		} finally {
			session.close();
		}
		return empleados;
	}

	public void update(Empleado empleado) {
		Session session = SessionFactoryService.get().openSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(empleado);
			session.getTransaction().commit();
		} catch (Exception e) {
			System.out.println("No se ha podido actualizar Empleado");
		} finally {
			session.close();
		}
	}
	
	public boolean exists(String email) {
		boolean exists = true;
		Empleado empleado = read(email);
		try {
			if(empleado.getName() == null || empleado.getName() == "") {
				exists = false;
			}
		} catch (Exception e) {
			exists = false;
		}
		return exists;
	}
}
