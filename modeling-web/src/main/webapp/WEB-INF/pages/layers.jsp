<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="common/taglibs" %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<%@ include file="common/theme" %>
		<%@ include file="common/javascript" %>
		<script  type="text/javascript">
			//<!--

			function calculateValues(modifiedWeight){

				var layerDiv   = document.getElementById("selectionFrame");
				var totalLabel = document.getElementById("totalImportanceValue");

				var selectedValue =  undefined;
				var totalImportanceValue = 0;

				for each(var selected in selectedElements){
					if ( selected.checked == true ){

						selectedValue = document.getElementById("layer_"+selected.value);

						if(selected.value != undefined &&
								selectedValue.value != undefined){
							totalImportanceValue += (+selectedValue.value);
						}
					}
				}

				if(totalImportanceValue != 100 ){
					totalLabel.style.color = "red";
					totalLabel.style.fontSize = "24";
	//				submitButtom.disabled = true;

				}else{
					totalLabel.style.color = "black";
					totalLabel.style.fontSize = "16";
//					submitButtom.disabled = false;
				}


				totalLabel.firstChild.nodeValue = totalImportanceValue;

				return;
			}

			function setValueToZero(selected){

				var selectedValue = document.getElementById(selected.id+"_weight");

				if(selected.checked == true){
					selectedValue.disabled = false;
					selectedValue.value = 0;
				}else{
					selectedValue.disabled = true;
					selectedValue.value = "";
				}

				calculateValues();

				return;
			}

			function send(){

				document.forms["layersForm"].submit();
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
			<h1><fmt:message key="title.layer"/></h1>
			<font color="red">
				<b><c:out value="${status.errorMessage}"/></b>
			</font>
			<div id="formXD">
				<form:form id="layersForm" commandName="systemInfo" method="post" action="columns.html" >
					<div id="layerListTitle">
					</div>
					<div id="layerFrame">
						<div id="resolutionInfo">
							<fmt:message key="common.resolution"/>
							<form:input path="resolution" />
							<fmt:message key="layer.resolutionDecimalDegrees" />
						</div>
						<div id="layerList" >
							<div id="layerTitles" >
								<fmt:message key="common.selected"/>
								<fmt:message key="layer.layerName"/>
								<fmt:message key="layer.importanceValue"/>
							</div>
							<div id="selectionFrame">
								<c:forEach items="${systemInfo.layers}" var="layer"  varStatus="current">
									<form:hidden path="layers[${current.index}].name" />
									<form:checkbox id="${layer.name}" path="layers[${current.index}].selected" onclick="setValueToZero(this);" />
									<c:out value="${layer.name}" />
									<form:input id="${layer.name}_weight"  path="layers[${current.index}].weight" maxlength="2" onkeyup="calculateValues(this);" />
									<br />
								</c:forEach>
							</div>
						</div>
						<div id="importanceFrame">
							<fmt:message key="layer.importanceValueTotal"/>
							<label id="totalImportanceValue" style="font-size: xx-large; color: red" title="<fmt:message key="layer.importanceValueHint"/>" >
								0
							</label>
								%
						</div>
						<div id="buttonFrame">
							<input id="submitButton" type="button" onclick="send();" value='<fmt:message key="layer.importanceValue"/>' />
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</body>
</html>
