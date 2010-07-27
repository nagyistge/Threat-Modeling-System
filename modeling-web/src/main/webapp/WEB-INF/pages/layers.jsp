<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs" %>

<html>
	<head>
		<%@ include file="/common/theme" %>
		<%@ include file="/common/javascript" %>
	</head>
    <body onload="calculateValues();">
		<div id="header-contenedor">
			<jsp:include page="/common/header.jsp"/>
		</div>
		<div id="contenido">

			<p class="titulo-principal"><fmt:message key="title.layer"/></p>

			<spring:hasBindErrors name="layersForm">
				<div class="errors">
					<h3><fmt:message key="errors.title"/></h3>
					<p>
						<c:forEach items="${errors.allErrors}" var="error">
							<fmt:message key="${error.code}" />
						</c:forEach>
					</p>
				</div>
			</spring:hasBindErrors>

			<div id="formXD">
				<form:form id="layersForm" commandName="layersForm" method="post" action="layers.html" >
					<div id="layers">
						<table id="layerTable" class="tabla-contenido" width="70%" border="0" align="center" cellpadding="4" cellspacing="1" >

							<tr class="celda02">
                                <td colspan="2" style="text-align: left; "><span class="textosnegrita" style="text-align: left; font-size: 17px"><fmt:message key="layer.generalConfiguration"/></span></td>
							</tr>
							<tr class="celda01">

                                <td width="60%">
									<span class="textos">
										<fmt:message key="common.resolution"/><br />
										<fmt:message key="layer.resolutionDecimalDegrees" />
									</span>
								</td>
								<td>
                                    <form:input title="" path="resolution" />&nbsp;&deg;
								</td>
							</tr>
							<tr class="celda02">
								<td><span class="textosnegrita"><fmt:message key="layer.availableLayers"/></span></td>
								<td><span class="textosnegrita"><fmt:message key="layer.importanceValue"/></span></td>
							</tr>
							<c:forEach items="${layersForm.layerList}" var="layer"  varStatus="current">
								<form:hidden path="layerList[${current.index}].name" />
								<form:hidden path="layerList[${current.index}].uri" />
								<form:hidden path="layerList[${current.index}].displayName" />
								<tr class="celda01">
								<div class="${layer.name}">
									<td>
                                        <span class="textos" title="<fmt:message key='layer.description' />: ${layer.description}">
											<form:checkbox id="${layer.name}" path="layerList[${current.index}].selected" onclick="setValueToZero(this);" />
											<c:out value="${layer.displayName}" />
										</span>
									</td>
									<td>
										<span class="textos">
											<c:choose>
												<c:when test="${layer.selected == false}">
													<form:input cssStyle="align: left;"
																id="${layer.name}_weight"
																disabled="true"
																path="layerList[${current.index}].weight"
																maxlength="2"
                                                                onkeyup="calculateValues(this);${layer.selected}" />&nbsp;%
												</c:when>
												<c:otherwise>

													<form:input cssStyle="align: left;"
																id="${layer.name}_weight"
																path="layerList[${current.index}].weight"
																maxlength="2"
																onkeyup="calculateValues(this);${layer.selected}" />&nbsp;%
												</c:otherwise>


											</c:choose>
										</span>
									</td>
								</div>
								</tr>
							</c:forEach>
							<tr class="celda02">
								<td>
									<span class="textos">
										<div id="importance">
											<fmt:message key="layer.importanceValueTotal"/>
											<label id="totalImportanceValue" title="<fmt:message key="layer.importanceValueHint"/>" >
								0
											</label>
								%
										</div>
									</span>
								</td>
								<td>
                                    <input class="button-simple" id="submitButton" disabled="true" type="submit" value='<fmt:message key="layer.nextStep"/>'  />
								</td>
							<tr>
						</table>
					</div>
				</div>
			</form:form>
		</div>
		<div id="footer">
			<jsp:include page="/common/footer.jsp"/>
		</div>
	</body>
</html>
