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


        <link rel="stylesheet" type="text/css" href="http://openlayers.org/theme/default/style.css"/>
        <script type="text/JavaScript" src="http://openlayers.org/api/OpenLayers.js"></script>
        <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=ABQIAAAAGtIHQJm1-pS3ci26k9D7hRQgngloALHesSZLYd1j0z536uH2MxQmIpE6xoh3_0LA7MpmysupPTjnvg" type="text/javascript"></script>

        <script type="text/javascript" >

            /**
             *Add layers
             */
            //Use a proxy for GeoServer requesting
            OpenLayers.ProxyHost = "cgi-bin/proxy.cgi/?url=";

            /*
            * Initialazing the gis functionality
            */
            function initMap(divId){


                var initialbounds = new OpenLayers.Bounds(
                    -85.954, 8.04,
                    -82.553, 11.22);

                var options = {
                    controls: [],
                    maxResolution: 0.09776171875,
                    projection: "EPSG:900913",
                    units: 'm'
                };

                var myMapDiv = document.getElementById(divId);
                map = new OpenLayers.Map(divId, options);
                map.render(myMapDiv);

                //------------------------------ Layers ------------------------------------
                //Base layer
                googleLayer  = new OpenLayers.Layer.Google('Google Hybrid', {type: G_SATELLITE_MAP });
                map.addLayer(googleLayer);

                <c:forEach items="${speciesLayers}" var="layer">
                            var aux = addLayerWMS("${layer.displayName}", "${layer.name}");//(name,id)
                            map.addLayer(aux);
                </c:forEach>

                var aux = addLayerWMS("<fmt:message key='showMap.principal' />","${fullSessionInfo.limitLayerName}");//(name,id)
                map.addLayer(aux);


    //Prepare URL for XHR request:
    var sUrl = "cgi-bin/proxy.cgi/?url=http://216.75.53.105:80/geoserver/wms?request=getCapabilities";

    //Prepare callback object
    var callback = {

        //If XHR call is successful
        success: function(oResponse) {


            //Root element -> response
            var xmlDoc = oResponse.responseXML.documentElement;
            //Get the list of specimens
            var layerList = xmlDoc.getElementsByTagName("Layer");

            //Add all the specimen point
            for(var i = 0;i<layerList.length;i++){
                var node = layerList[i];
                var name = node.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
                if(name == "${fullSessionInfo.limitLayerName}"){
                        var llAttributes = node.getElementsByTagName("BoundingBox")[0].attributes;
                        var bbox =  new OpenLayers.Bounds();
                        bbox.extend(new OpenLayers.LonLat( llAttributes.minx.value, llAttributes.miny.value));
                        bbox.extend(new OpenLayers.LonLat( llAttributes.maxx.value, llAttributes.maxy.value));
                            var img = new OpenLayers.Layer.Image("<fmt:message key='showMap.threats' />",
                                                "/resmaps/${fullSessionInfo.imageName}_T_${fullSessionInfo.userSessionId}.png",
                                                bbox,
                                                500,
                                                {isBaseLayer: false, transparent: true, opacity: 0.75 , singleTile: true, ratio: 1,bgcolor: 'transparent' });
                            map.addLayer(img);
                            map.panTo(bbox.getCenterLonLat());
                            map.zoomToExtent(bbox);
                            map.raiseLayer(img, map.getNumLayers()*-1);
                }
            }
        },

        //If XHR call is not successful
        failure: function(oResponse) {
            YAHOO.log("Failed to process XHR transaction.", "info", "example");
        }
    };

    //Make our XHR call using Connection Manager's
    YAHOO.util.Connect.asyncRequest('GET', sUrl, callback);


                first = true;
                bbox = undefined;

                //--------------------------------------------------------------------------

                //Build up all controls
                map.zoomToExtent(initialbounds);
                map.addControl(new OpenLayers.Control.PanZoomBar({
                    position: new OpenLayers.Pixel(2, 15)
                }));
                map.addControl(new OpenLayers.Control.LayerSwitcher({'ascending':false},{'position':OpenLayers.Control}));
                map.addControl(new OpenLayers.Control.Navigation());
                map.addControl(new OpenLayers.Control.Scale($('scale')));
                map.addControl(new OpenLayers.Control.MousePosition({element: $('location')}));
            }


            function exportResult( type ){

                var outputType = document.getElementById('outputType');
                outputType.value = type;

                return true;
            }

        </script>

    </head>
    <body onload="initMap('map')" >
        <div id="Header">
            <!-- Header -->
            <jsp:include page="/common/header.jsp"/>
        </div>
        <div id="contenido" style="width: 100%">

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
            <div id="results" >
                <div id="categoryInfo">
                    <table border="2" class="tabla-contenido">
                        <tr class="celda02"  >
                            <td colspan="2" style="width:350px; font-weight:bold;max-width: 350px; overflow: hidden;"><fmt:message key="showMap.leyend" /></td>
                        </tr>
                        <tr class="celda01"  >
                            <td width="50%" align="left"><span class="textosnegrita"><fmt:message key="showMap.resolution" /></span></td>
                            <td align="center"><span class="textos"><c:out value="${fullSessionInfo.resolution}" /></span></td>
                        </tr>
                    </table>
                    <c:forEach items="${fullSessionInfo.layerList}" var="layer" >
                        <br />
                        <table border="5" class="tabla-contenido">
                            <tr class="celda02">
                                <td colspan="2" style="width:350px; font-weight:bold;max-width: 350px; overflow: hidden;"><c:out value="${layer.displayName}" /></td>
                            </tr>
                            <tr class="celda02">
                            <span class="textosnegrita">
                                <td class="textos" colspan="2" style="font-style:italic;">
                                    <c:choose>
                                        <c:when test="${'AREA' eq layer.type}" >
                                            <fmt:message key="showMap.categories" />
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:message key="showMap.intervals" />
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </span>
                            </tr>
                            <c:forEach items="${layer.categories}" var="category">
                                <c:if test="${category ne null}">
                                    <c:choose>

                                        <c:when test="${'AREA' eq layer.type}" >
                                            <tr class="celda01">
                                                <td style="max-width: 170px; overflow:hidden">
                                                    <span class="textos"><c:out value="${category.value}" /></span>
                                                </td>
                                                <td style="max-width: 170px; overflow:hidden">
                                                    <span class="textos"><c:out value="${category.description}" /></span>
                                                </td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <tr class="celda01" style="text-align:center;">
                                                <td style="max-width: 170px; overflow:hidden" colspan="2">
                                                    <span class="textos" ><c:out value="${category.value}" /></span>
                                                </td>
                                            </tr>
                                        </c:otherwise>

                                    </c:choose>
                                </c:if>
                            </c:forEach>
                        </table>
                    </c:forEach>
                </div>
                <div id="mapResults" >
                    <table  style="height:450px">
                        <tr>
                            <td class="mapTable">
                                <!--
                                <div id="mapImage" >
                                    <img alt="<fmt:message key='maps.resultingMap' />" src="/resmaps/${fullSessionInfo.imageName}_T_${fullSessionInfo.userSessionId}.png" />
                                </div>
                                -->
                                <div id="map" style="border:  1px solid black;"></div>
                            </td>
                            <td class="threat_image_text">
                                <fmt:message key="showMap.highThreat" />
                                <br />
                                <div id="scale_image" ></div>
                                <fmt:message key="showMap.lowThreat" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div id="actions">
                <form:form action="export.html" commandName="exportForm">
                    <form:hidden id="outputType" path="type"  />
                    <input id="exportPNGButton" type="submit" class="button-simple" value='<fmt:message key="showMap.exportPNG"/>' onclick="exportResult('PNG');" />
                    <input id="exportSHPButton" type="submit" class="button-simple" value='<fmt:message key="showMap.exportSHP"/>' onclick="exportResult('SHP');" />
                    <input id="exportPDFButton" type="submit" class="button-simple" value='<fmt:message key="showMap.exportPDF"/>' onclick="exportResult('PDF');" />
                </form:form>
            </div>
        </div>
        <div id="footer">
            <jsp:include page="/common/footer.jsp"/>
        </div>
    </body>
</html>

