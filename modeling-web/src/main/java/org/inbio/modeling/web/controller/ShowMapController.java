/* Modeling - Application to model threats.
 *
 * Copyright (C) 2010  INBio (Instituto Nacional de Biodiversidad)
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

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.inbio.modeling.core.dto.LayerDTO;
import org.inbio.modeling.core.manager.FileManager;
import org.inbio.modeling.core.manager.GrassManager;
import org.inbio.modeling.web.forms.LayersForm;
import org.inbio.modeling.web.session.SessionInfo;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractFormController;

/**
 *
 * @author asanabria
 */
public class ShowMapController extends AbstractFormController {

	private GrassManager grassManagerImpl;
	private FileManager fileManagerImpl;

	@Override
	protected ModelAndView processFormSubmission(HttpServletRequest request, HttpServletResponse response, Object command, BindException errors) throws Exception {

		LayersForm selectedLayers = null;
		List<LayerDTO> layerList =  null;
		SessionInfo sessionInfo = null;
		Long currentSessionId = null;
		HttpSession session = null;
		ModelAndView model = null;

		/**	Long currentSessionId = Calendar.getInstance().getTimeInMillis();
			currentSessionId = new Long(1271111604483L);
			currentSessionId = new Long(666L); */

		// TODO: retrieve the information from the Form
		selectedLayers = (LayersForm)command;


		// retrieve the session Information.
		session = request.getSession();
		sessionInfo = (SessionInfo)session.getAttribute("CurrentSessionInfo");
		currentSessionId = sessionInfo.getCurrentSessionId();

		layerList = sessionInfo.getSelectedLayerList();

		for(LayerDTO layer : layerList){
			System.out.println("layer: "+layer.getName() + "  W: "+layer.getWeight());
			this.fileManagerImpl.writeReclasFile(layer, currentSessionId);
			this.grassManagerImpl.advanceReclasification(layer.getName(), currentSessionId);
		}


		LayerDTO M1 = null;
		LayerDTO M2 = null;
		LayerDTO R = null;

		if(layerList.size() >= 2){
			M1 = layerList.get(0);
			M2 = layerList.get(1);
			R  = new LayerDTO("Res1", 1);
		}

		for(int i = 2; i<layerList.size(); i++){

			this.grassManagerImpl.executeWeightedSum(M1.getName(), M1.getWeight(), M2.getName(), M2.getWeight(), currentSessionId, R.getName());
			M1 = R;
			M2 = layerList.get(i);
			R  = new LayerDTO("Res"+i, 1);
			System.out.println("Testing");
		}

		this.grassManagerImpl.exportLayer2Image(currentSessionId, R.getName());

		//save session
		session.setAttribute("CurrentSessionInfo", sessionInfo);

		// Send the layer list to the JSP
		model = new ModelAndView();
		model.setViewName("showResultingMap");
		model.addObject("layers", layerList);

		return model;
	}


	@Override
	protected ModelAndView showForm(HttpServletRequest request, HttpServletResponse response, BindException errors) throws Exception {
		return new ModelAndView("index");
	}

	public GrassManager getGrassManagerImpl() {
		return grassManagerImpl;
	}

	public void setGrassManagerImpl(GrassManager grassManagerImpl) {
		this.grassManagerImpl = grassManagerImpl;
	}

	public FileManager getFileManagerImpl() {
		return fileManagerImpl;
	}

	public void setFileManagerImpl(FileManager fileManagerImpl) {
		this.fileManagerImpl = fileManagerImpl;
	}
}