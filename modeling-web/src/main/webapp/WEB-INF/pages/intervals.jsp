<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="common/taglibs" %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<%@ include file="common/theme" %>
		<%@ include file="common/javascript" %>
		<script  type="text/javascript">
			//<!--

			function send(formName){

				document.forms[formName].submit();
				return true;
			}
			//-->
		</script>

	</head>
	<body>
		<div id="Header">
			<!-- Header -->
			<jsp:include page="common/header.jsp"/>
		</div>

		<div id="contenido">
			<h1><fmt:message key="title.intervals"/></h1>
			<font color="red">
				<b><c:out value="${status.errorMessage}"/></b>
			</font>
			<table border="3">
				<tr>
					<td><fmt:message key="common.layers"/></td>
					<td><fmt:message key="layer.weight"/></td>
					<td><fmt:message key="interval.column"/></td>
				</tr>
				<form method="post" action="showResultingMap.html" id="intevalsForm">
					<c:forEach items="${layers}" var="layer"  varStatus="current">
						<tr>
							<td>
								<c:out value="${layer.name}" />
							</td>
							<td>
							<c:forEach items="${layer.intervals}" var="interval"  varStatus="current">
								<c:out value="${interval.description}" /><br />
							</c:forEach>
							</td>
					</c:forEach>
					<tr>
						<td align="right">
							<input id="submitButton" type="button" onclick="send('intevalsForm');" value='<fmt:message key="common.acceptChanges"/>' />
						</td>
					</tr>
				</form>
			</table>
		</div>
	</body>
</html>
