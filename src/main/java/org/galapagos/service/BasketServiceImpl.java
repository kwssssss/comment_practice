package org.galapagos.service;

import java.io.FileInputStream;

import org.galapagos.domain.BasketVO;
import org.springframework.stereotype.Service;

import weka.classifiers.Classifier;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.SerializationHelper;

@Service
public class BasketServiceImpl implements BasketService{
	Classifier model;
	Instances dataSet;
	private double[] values;

	public BasketServiceImpl() {

		try {
			String[] classLabels = { "SG", "C" };
			dataSet = WekaUtil.makeInstnaces(6, classLabels);
			
			model = (Classifier) SerializationHelper
					.read(new FileInputStream("C:/Users/znlv0/Desktop/asdf/basketball.model"));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public String predict(BasketVO value) {
		Instance data = value.toInstance();
		data.setDataset(dataSet);
		
		// 분류하기
		double result = 0;
		try {
			result = model.classifyInstance(data);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dataSet.classAttribute().value((int) result);
	}
}
