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

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;


class TestViajeDaoImplementation {
	
	private final Viaje viaje = new Viaje();
	ViajeDAO vdao = ViajeDAOImplementation.getInstance();

	@BeforeEach
	void setUp() throws Exception {
		viaje.setId(1);
		viaje.setDestino("Madrid");
		vdao.create(viaje);
		System.out.println(viaje);
	}

	@AfterEach
	void tearDown() throws Exception {
		vdao.delete(vdao.read(1));
	}

	@Test
	void testCreate() {
		assertNotNull(vdao.read(20));
	}

	@Test
	void testDelete() {
		int size1 = vdao.readAll().size();
		vdao.delete(vdao.read(1));
		assertTrue(vdao.readAll().size()<size1);
	}

	@Test
	void testRead() {
		assertEquals("Madrid", vdao.read(1).getDestino());
	}

	@Test
	void testReadAll() {
		assertFalse(vdao.readAll().isEmpty());
	}

	@Test
	void testUpdate() {
		String destino1 = viaje.getDestino();
		viaje.setDestino("Alfonso");
		vdao.update(viaje);
		assertNotEquals(destino1, vdao.read(1).getDestino());
	}

}
