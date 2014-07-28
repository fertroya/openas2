package com.nimbo.openas2;

import java.security.Permission;

import org.junit.AfterClass;
import org.junit.Before;
import org.junit.Test;
import org.openas2.app.OpenAS2Server;
import static org.junit.Assert.*;

public class OpenAS2ServerTest {
	private static final int OK_EXIT_CODE = 0;
	private OpenAS2Server server;

	@Before
	/**
	 * Logging property mandatory for default configuration.
	 * SecurityManager workaround explained in implementating class.
	 * 
	 * */
	public void setUp() {
		this.server = new OpenAS2Server();
		System.setProperty("org.apache.commons.logging.Log",
				"org.openas2.logging.Log");
		System.setSecurityManager(new NoExitSecurityManager());
	}

	@AfterClass
	public static void tearDown() throws Exception {
		System.setSecurityManager(null); // or save and restore original
	}

	@Test
	public void testStart() {
		try {
			/* Configuration loaded from test resources. */
			String[] args = new String[] { "src/test/resources/config.xml" };
			this.server.start(args);
		} catch (ExitException e) {
			/* Fail if exit code is not 0. */
			assertEquals("The server ended prematurely", OK_EXIT_CODE, e.status);
		}
	}

	/**
	 * Security manager that catches exit calls throwing a custom Exception.
	 * */
	private static class NoExitSecurityManager extends SecurityManager {
		@Override
		public void checkPermission(Permission perm) {
			// allow anything.
		}

		@Override
		public void checkPermission(Permission perm, Object context) {
			// allow anything.
		}

		@Override
		public void checkExit(int status) {
			super.checkExit(status);
			throw new ExitException(status);
		}
	}

	/**
	 * Custom exception to identify exit status of the OpenAS2Server processes.
	 */
	protected static class ExitException extends SecurityException {
		private static final long serialVersionUID = 1L;
		public final int status;

		public ExitException(int status) {
			this.status = status;
		}
	}

}
