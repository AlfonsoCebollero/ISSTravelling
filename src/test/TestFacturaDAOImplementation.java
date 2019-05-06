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
class TestFacturaDAOImplementation {

	 private final Factura factura = new Factura();
	 FacturaDAO edao = FacturaDAOImplementation.getInstance();
	 int n = 1;
	 
	@BeforeEach
	void setUp() throws Exception {
		factura.setId(1);
		factura.setDescripcion("viaje");
		edao.create(factura);
		System.out.println(edao.readAll());
	}

	@AfterEach
	void tearDown() throws Exception {
		edao.delete(edao.read(1));
	}

	@Test
	void testCreate() {
		assertNotNull(edao.read(1));
	}

	@Test
	void testDelete() {
		int size1 = edao.readAll().size();
		edao.delete(edao.read(1));
		assertTrue(edao.readAll().size()<size1);
		
	}

	@Test
	void testRead() {
		
		assertEquals("viaje", edao.read(1).getDescripcion());
	}

	@Test
	void testReadAll() {
		assertFalse(edao.readAll().isEmpty());
	}

	@Test
	void testUpdate() {
		String descripcion1 = factura.getDescripcion();
		factura.setDescripcion("Alfonso");
		edao.update(factura);
		assertNotEquals(descripcion1, edao.read(1).getDescripcion());
	}


}
