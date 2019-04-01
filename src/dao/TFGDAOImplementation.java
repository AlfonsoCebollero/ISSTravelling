package dao;

import java.util.ArrayList;
import java.util.Collection;

import org.hibernate.Session;




import model.TFG;


public class TFGDAOImplementation implements TFGDAO {
	
	private static TFGDAOImplementation instance = null;
	
	private TFGDAOImplementation() {}
	@Override
	public void create(TFG tfg) {
		Session session = SessionFactoryService.get().openSession();
		try {
			session.beginTransaction();
			session.save( tfg );
			session.getTransaction().commit();
		}catch(Exception e){
		}finally {
			session.close();
		}
	}
	@Override
	public void delete(TFG tfg) {
		Session session = SessionFactoryService.get().openSession();
		try {
			session.beginTransaction();
			session.delete( tfg );
			session.getTransaction().commit();
		}catch(Exception e) {
			
		}finally {
			session.close();
		}
	}
	@Override
	public TFG read(String email) {
		Session session = SessionFactoryService.get().openSession();
		TFG tfg = null;
		try {
			session.beginTransaction();
			tfg = session.load( TFG.class, email );
			session.getTransaction().commit();
		}catch(Exception e){
			
		}finally {
			session.close();
		}
		
		return tfg;
	}
	
	@SuppressWarnings("unchecked")
	
	@Override
	public Collection<TFG> readAll() {
		Session session = SessionFactoryService.get().openSession();
		Collection<TFG> tfgs = new ArrayList();
		
		try {
			session.beginTransaction();
			tfgs = session.createQuery( "from TFG" ).list();
			session.getTransaction().commit();
		}catch(Exception e) {
			
		}finally {
			session.close();
		}		
		return tfgs;
	}
	@Override
	public void update(TFG tfg) {
		Session session = SessionFactoryService.get().openSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate( tfg );
			session.getTransaction().commit();
		}catch(Exception e) {
			
		}finally {
			session.close();
		}
	}
	
	public static TFGDAOImplementation getInstance() {
	    if( null == instance ) 
	      instance = new TFGDAOImplementation();
	    return instance;
	  }
}

