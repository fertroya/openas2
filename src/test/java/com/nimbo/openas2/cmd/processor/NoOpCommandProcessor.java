/**
 * 
 */
package com.nimbo.openas2.cmd.processor;

import org.openas2.OpenAS2Exception;
import org.openas2.cmd.processor.BaseCommandProcessor;

/**
 * @author ftroya
 *
 */
public class NoOpCommandProcessor extends BaseCommandProcessor {

	/* (non-Javadoc)
	 * @see org.openas2.cmd.processor.CommandProcessor#deInit()
	 */
	@Override
	public void deInit() throws OpenAS2Exception {
		// TODO Auto-generated method stub

	}

	/* (non-Javadoc)
	 * @see org.openas2.cmd.processor.CommandProcessor#init()
	 */
	@Override
	public void init() throws OpenAS2Exception {
		this.terminate();
	}

}
