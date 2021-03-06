<%-- 
    Document   : listUsers
    Created on : 19/05/2010, 09:56:00 AM
    Author     : asanabria
--%>

<%@ page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@ include file="/common/taglibs" %>

<html>
	<head>
		<%@ include file="/common/theme" %>
	</head>
	<body onload="checkSize()">
		<div id="Header">
			<jsp:include page="/common/header.jsp"/>
		</div>
		<div id="contenido">
			<form:form  id="layerForm" commandName="layerForm" action="/listLayers.html">
				<div align="center" >
					<table id="layerListTable" cellspacing="0" cellpadding="3px" width="960px" >
						<tr style="font-weight: bold;">
							<td class="layerListHeader" width="4%">
								&nbsp;
							</td>
							<td class="layerListHeader" width="30%" style="" >
								<fmt:message key="layer.displayName" />
							</td>
							<td class="layerListHeader" >
								<fmt:message key="layer.description" />
							</td>
						</tr>
					</table>
				</div>
				<div align="center" style="height: 390px; overflow: auto; margin-right: -20px" >
					<table id="layerListTable" cellspacing="0" cellpadding="3px" width="960px">
						<c:forEach items="${layers}" var="layer">
							<tr>
								<td width="4%">
									<form:radiobutton value="${layer.id}" path="id" /> &nbsp;
								</td>
								<td width="30%">
									<c:out value="${layer.displayName}" />&nbsp;
								</td>
								<td>
									<c:out value="${layer.description}" />&nbsp;
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</form:form>
			<div align="center">
				<input class="button-simple" type="button" value="<fmt:message key='common.edit' />" onclick="editLayer()"/>
				<input class="button-simple" type="button" value="<fmt:message key='common.delete' />" onclick="deleteLayer()"/>
				<input class="button-simple" type="button" value="<fmt:message key='common.new' />" onclick="newLayer()"/>
			</div>
		</div>
		<div id="footer">
			<jsp:include page="/common/footer.jsp"/>
		</div>
	</body>
</html>