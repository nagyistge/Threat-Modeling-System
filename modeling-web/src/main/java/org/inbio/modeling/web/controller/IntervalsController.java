/* Modeling - Application to model threats.
 *
 * Copyright (C) 2010  INBio ( Instituto Nacional de Biodiversidad )
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package org.inbio.modeling.web.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.inbio.modeling.core.dto.IntervalDTO;
import org.inbio.modeling.core.dto.LayerDTO;
import org.inbio.modeling.core.manager.GrassManager;
import org.inbio.modeling.web.forms.LayersForm;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractFormController;

/**
 *
 * @author asanabria
 */
public class IntervalsController extends AbstractFormController {

	private GrassManager grassManagerImpl;

	@Override
	protected ModelAndView processFormSubmission(HttpServletRequest request, HttpServletResponse response, Object command, BindException errors) throws Exception {

		LayersForm selectedLayers = (LayersForm)command;
		List<LayerDTO> layers = new ArrayList<LayerDTO>();
		LayerDTO layerDTO = null;
		HashMap<String, String> h = null;
		Long suffix = new Long(1271111604483L);
		List<IntervalDTO> intervals = null;

		String[] parts = null;
		List<String> temp = selectedLayers.getDataColumnList();

		for(String t : temp){
			parts = t.split(":");
			layerDTO = new LayerDTO();
			layerDTO.setName(parts[0]);

			h = new HashMap<String,String>();
			h.put(parts[1], parts[2]);
			if(parts[2].equals("CHARACTER")){
				this.grassManagerImpl.simpleReclasification(layerDTO.getName(), parts[1], suffix);
			}
			this.grassManagerImpl.convertLayer2Raster(layerDTO.getName(), suffix, true);
			intervals = this.grassManagerImpl.getLayerCategories(layerDTO.getName(), "RAST", suffix);

			layerDTO.setDataColumnList(h);
			layerDTO.setIntervals(intervals);
			layers.add(layerDTO);
		}

		System.out.println("asdf");
		
		return new ModelAndView("intervals", "layers", layers);
	}

	@Override
	protected ModelAndView showForm(HttpServletRequest request, HttpServletResponse response, BindException errors) throws Exception {
		return new ModelAndView("index");
	}

	/* Getters and Setters */
	public GrassManager getGrassManagerImpl() {
		return grassManagerImpl;
	}

	public void setGrassManagerImpl(GrassManager grassManagerImpl) {
		this.grassManagerImpl = grassManagerImpl;
	}
}
