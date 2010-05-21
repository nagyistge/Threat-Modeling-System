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
			<img alt="<fmt:message key='maps.resultingMap' />" src="/resmaps/R_${layer}_${suffix}_r.png" />
		</div>
	</body>
</html>
