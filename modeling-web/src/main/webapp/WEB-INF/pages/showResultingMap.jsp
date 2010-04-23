<%-- 
    Document   : showResultingMap
    Created on : 24/03/2010, 08:59:36 AM
    Author     : asanabria
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="common/taglibs" %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<%@ include file="common/theme" %>
		<%@ include file="common/javascript" %>
		<script  type="text/javascript">
			//<!--

			function edit(radio){

				var radios = document.getElementsByName("rbEditing");
				var rad = undefined;

				for(var item in radios){
					rad = radios[item];
					if(rad.checked != true){
						document.getElementById(rad.id+"_cats").style.display="none";
					}else{
						document.getElementById(rad.id+"_cats").style.display="";
					}
				}
			}

			function addCategory(){

				var radio = undefined;
				var radios = document.getElementsByName("rbEditing");
				var categories = undefined;
				var currentLayer = undefined;
				var currentCategory = undefined;

				for(var item in radios){
					radio = radios[item];
					if(radio.checked == true)
						break;
				}
				categories = document.getElementById(radio.id+"_cats");
				currentCategory = categories.childElementCount;
				currentLayer = radio.value;

				categories.innerHTML = categories.innerHTML+
					"<div><input type='checkbox' name='"+radio.id+"'/>&nbsp;" +
					"<input  type='text' name='layers["+currentLayer+"].categories["+currentCategory+"].value' value='0'  style='width: 150px' />&nbsp;"+
					"<input style='width: 150px' name='layers["+currentLayer+"].categories["+currentCategory+"].description' value='Category "+(currentCategory+1)+"' /><br /></div>";
			}

			function deleteCategory(){

				var radio = undefined;
				var categories = undefined;

				var radios = document.getElementsByName("rbEditing");

				for(var item in radios){
					radio = radios[item];
					if(radio.checked == true)
						break;
				}

				categories = document.getElementsByName(radio.id);

				for(var ckb = categories.length-1; ckb >= 0; ckb--){
					check = categories[ckb];
					if(check.checked == true){
						check.parentNode.parentNode.removeChild(check.parentNode);
					}
				}
			}
		</script>
	</head>
	<body>
		<div id="Header">
			<!-- Header -->
			<jsp:include page="common/header.jsp"/>
		</div>

		<div id="contenido">
			mapa resultante
		</div>
	</body>
</html>