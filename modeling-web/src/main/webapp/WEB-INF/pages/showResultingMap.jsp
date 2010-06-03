<%-- 
    Document   : showResultingMap
    Created on : 24/03/2010, 08:59:36 AM
    Author     : asanabria
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="/common/taglibs" %>

<html>
	<head>
		<%@ include file="/common/theme" %>
		<%@ include file="/common/javascript" %>
	</head>
	<body>
		<div id="Header">
			<!-- Header -->
			<jsp:include page="/common/header.jsp"/>
		</div>
		<div id="contenido">

			<spring:hasBindErrors name="intervalsForm">
				<div class="errors">
					<h3><fmt:message key="errors.title"/></h3>
					<p>
						<c:forEach items="${errors.allErrors}" var="error">
							<fmt:message key="${error.code}" />
						</c:forEach>
					</p>
				</div>
			</spring:hasBindErrors>

			<table width="100%" border="0">
				<tr>
					<td style="vertical-align: bottom; text-align:  right">
						up
						<br />
						<div id="scale" />
						down
					</td>
					<td style="text-align: left; width: 50%">
						<div id="map" >
							<img alt="<fmt:message key='maps.resultingMap' />" src="/resmaps/R_${fullSessionInfo.imageName}_${fullSessionInfo.userSessionId}_r.png" />
						</div>

					</td>
					<td colspan="1" >
						<div id="categoryInfo">
							<table class="tabla-contenido">
								<tr class="celda02"  >
									<td colspan="2"><span class="textosnegrita"><fmt:message key="showMap.leyend" /></span></td>
								</tr>
								<tr class="celda01" align="right"  >
									<td width="50%"><span class="textosnegrita"><fmt:message key="showMap.resolution" /></span></td>
									<td><span class="textos"><c:out value="${fullSessionInfo.resolution}" /></span></td>
								</tr>
								<c:forEach items="${fullSessionInfo.layerList}" var="layer" >
									<tr class="celda02">
									<span class="textosnegrita">
										<td colspan="2"><c:out value="${layer.name}" /><fmt:message key="showMap.categories" /></td>
									</span>
									</tr>
									<c:forEach items="${layer.categories}" var="category">
										<tr class="celda01">
											<td><span class="textos"><c:out value="${category.value}" /></span></td>
											<td><span class="textos"><c:out value="${category.description}" /></span></td>
										</tr>
									</c:forEach>
								</c:forEach>
							</table>
						</div>
					</td>
				</tr>
			</table>
			<div id="footer">
				<jsp:include page="/common/footer.jsp"/>
			</div>
		</div>
	</body>
</html>
