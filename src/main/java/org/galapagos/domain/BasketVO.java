package org.galapagos.domain;

import lombok.Data;
import weka.core.DenseInstance;
import weka.core.Instance;

@Data
public class BasketVO {
	private double P3;
	private double P2;
	private double TRP;
	private double AST;
	private double STL;
	private double BLK;
	
	public Instance toInstance() {
		double [] values = { P3, P2, TRP, AST, STL, BLK};
		return new DenseInstance(1, values);
		
	}
}
