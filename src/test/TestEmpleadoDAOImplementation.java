package test;

import static org.junit.jupiter.api.Assertions.*;
import dao.*;
import model.*;

import static org.junit.Assert.assertNull;
import static org.junit.jupiter.api.Assertions.*;

import org.apache.shiro.crypto.hash.Sha256Hash;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;


import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class TestEmpleadoDAOImplementation {

	 private final Empleado empleado = new Empleado();
	 private final Empleado responsable = new Empleado();
	 private final Viaje viaje = new Viaje();
	 EmpleadoDAO edao = EmpleadoDAOImplementation.getInstance();
	 

	
	@BeforeEach
	void setUp() throws Exception {
		empleado.setName( "name" );
		empleado.setEmail( "emailll" );
		empleado.setPassword( new Sha256Hash( "password" ).toString() );
		empleado.setTelefono("679989273");
		empleado.setAdvisor2(null);
		empleado.setAdvisedEmpleados(null);
		empleado.setAdvisedViajes(null);
		edao.create(empleado);


	}

	@AfterEach
	void tearDown() throws Exception {
		edao.delete(edao.read("emailll"));
	}

	@Test
	void testCreate() {
		assertNotNull(edao.read("emailll"));
	}

	@Test
	void testDelete() {
		edao.delete(edao.read("emailll"));
		assertFalse(edao.exists("emailll"));
		
	}

	@Test
	void testRead() {
		assertEquals("emailll", edao.read("emailll").getEmail());
	}

	@Test
	void testReadAll() {
		assertTrue(!(edao.readAll().isEmpty()));
	}

	@Test
	void testUpdate() {
		String nombre1 = empleado.getName();
		empleado.setName("Alfonso");
		edao.update(empleado);
		assertNotEquals(nombre1, edao.read("emailll").getName());
	}

	@Test
	void testExists() {
		assertTrue(edao.exists("emailll"));
	}

}
