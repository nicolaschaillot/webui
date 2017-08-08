<!--
@license
(C) Copyright Keendoo SAS (http://www.keendoo.com/)
-->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List"%>
<%@ page import="org.nuxeo.common.Environment"%>
<%@ page import="org.nuxeo.runtime.api.Framework"%>
<%@ page import="org.nuxeo.ecm.web.resources.api.Resource"%>
<%@ page import="org.nuxeo.ecm.web.resources.api.ResourceContextImpl"%>
<%@ page import="org.nuxeo.ecm.web.resources.api.service.WebResourceManager"%>
<%@ page import="org.nuxeo.ecm.core.api.repository.RepositoryManager"%>
<%@ page import="org.nuxeo.common.utils.UserAgentMatcher"%>

<% WebResourceManager wrm = Framework.getService(WebResourceManager.class); %>
<% RepositoryManager rm = Framework.getService(RepositoryManager.class); %>
<% String ua = request.getHeader("user-agent"); %>

<!DOCTYPE html>
<html lang="">

<head>
  <meta charset="UTF-8">
  <meta name="description" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <title><%= Framework.getProperty(Environment.PRODUCT_NAME) %></title>

  <!-- Chrome for Android theme color -->
  <meta name="theme-color" content="#2E3AA1">

  <!-- Web Application Manifest -->
  <link rel="manifest" href="manifest.json" crossOrigin="use-credentials">

  <!-- Tile color for Win8 -->
  <meta name="msapplication-TileColor" content="#3372DF">

  <!-- Add to homescreen for Chrome on Android -->
  <meta name="mobile-web-app-capable" content="yes">
  <meta name="application-name" content="Nuxeo">
  <link rel="icon" sizes="192x192" href="images/touch/chrome-touch-icon-192x192.png">

  <!-- Add to homescreen for Safari on iOS -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="Nuxeo">
  <link rel="apple-touch-icon" href="images/touch/apple-touch-icon.png">

  <!-- Tile icon for Win8 (144x144) -->
  <meta name="msapplication-TileImage" content="images/touch/ms-touch-icon-144x144-precomposed.png">

  <link rel="stylesheet" href="vendor/select2.css">

  <%-- Load full polyfill in IE for compatibility --%>
  <% if (UserAgentMatcher.isMSIE10OrMore(ua) || UserAgentMatcher.isMSEdge(ua)) { %>
  <script src="bower_components/webcomponentsjs/webcomponents.min.js"></script>
  <% } else { %>
  <script src="bower_components/webcomponentsjs/webcomponents-lite.min.js"></script>
  <% } %>

  <script>
    window.Polymer = {
      lazyRegister: true
    };
  </script>

  <script src="vendor/jquery.js"></script>
  <script src="vendor/select2.js"></script>
  <script src="vendor/moment-with-locales.js"></script>
  <script src="vendor/alloy-editor.js"></script>

  <% for (Resource resource : wrm.getResources(new ResourceContextImpl(), "web-ui", "import")) { %>
  <link rel="import" href="<%= request.getContextPath() %>/<%= resource.getURI() %>">
  <% } %>

  <%--import dynamic user layouts--%>
  <link rel="import" href="nuxeo-user-group-management/nuxeo-view-user.html">
  <link rel="import" href="nuxeo-user-group-management/nuxeo-edit-user.html">

</head>

<body unresolved class="fullbleed layout vertical">
  <nuxeo-connection url="<%= request.getContextPath() %>"
                    repository-name="<%= rm.getDefaultRepositoryName() %>"></nuxeo-connection>
  <nuxeo-app base-url="<%= request.getRequestURI() %>"
             product-name="<%= Framework.getProperty(Environment.PRODUCT_NAME) %>"></nuxeo-app>
</body>

</html>
