/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.inbio.modeling.web.form;

import java.util.ArrayList;
import java.util.List;
import org.apache.commons.collections.FactoryUtils;
import org.apache.commons.collections.list.LazyList;
import org.inbio.modeling.web.form.util.Layer;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

/**
 *
 * @author asanabria
 */
public class ListLayerForm implements Validator{

	private Double resolution;
	private String projection;
	private List<Layer> layerList =
		LazyList.decorate( new ArrayList<Object>(),
						   FactoryUtils.instantiateFactory(Layer.class));


	public boolean supports(Class clazz) {
		return ListLayerForm.class.equals(clazz);
	}


	public void validate(Object target, Errors errors) {

		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "resolution", "errors.empty.resolution");

		int total = 0;
		ListLayerForm form = (ListLayerForm)target;

		for(Layer aLayer : form.getLayerList())
			total += aLayer.getWeight();

		if(total != 100)
			errors.reject("errors.weightSumNot100");

	}

	/** getters & setters */
	public List<Layer> getLayerList() {
		return layerList;
	}

	public void setLayerList(List<Layer> layerList) {
		this.layerList = layerList;
	}

	public String getProjection() {
		return projection;
	}

	public void setProjection(String projection) {
		this.projection = projection;
	}

	public Double getResolution() {
		return resolution;
	}

	public void setResolution(Double resolution) {
		this.resolution = resolution;
	}
}
