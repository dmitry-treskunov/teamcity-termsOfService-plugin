<%@ page import="jetbrains.buildServer.web.openapi.PlaceId" %>
<%@ page import="jetbrains.buildServer.termsOfService.AcceptTermsOfServiceController" %>
<%@include file="/include-internal.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="newVersionDisplayMode" value="<%=AcceptTermsOfServiceController.DisplayReason.NEW_VERSION%>"/>
<c:set var="notAcceptedDisplayMode" value="<%=AcceptTermsOfServiceController.DisplayReason.NOT_ACCEPTED%>"/>
<%--@elvariable id="pageUrl" type="java.lang.String"--%>
<%--@elvariable id="agreement" type="jetbrains.buildServer.termsOfService.TermsOfServiceManager.Agreement"--%>
<%--@elvariable id="currentUser" type="jetbrains.buildServer.users.SUser"--%>
<%--@elvariable id="displayReason" type="jetbrains.buildServer.termsOfService.AcceptTermsOfServiceController.DisplayReason"--%>
<c:set var="name" value="${agreement.fullName}"/>
<c:set var="pageTitle" value="${name}"/>
<bs:externalPage>
  <jsp:attribute name="page_title">${pageTitle}</jsp:attribute>
  <jsp:attribute name="head_include">
    <bs:linkCSS>
      /css/forms.css
      /css/initialPages.css
      /css/maintenance-initialPages-common.css
      ${teamcityPluginResourcesPath}/termsOfService.css
    </bs:linkCSS>
  </jsp:attribute>
  <jsp:attribute name="body_include">
    <bs:_loginPageDecoration id="agreementPage" title="${name}">
    <div class="agreementPage">
      <div class="agreement">
        <div class="description">
          <div>
            <c:choose>
              <c:when test="${displayReason eq newVersionDisplayMode}">
                  We've updated the <c:out value="${agreement.shortName}"/> agreement<c:if test="${agreement.lastUpdated != null}"> on ${agreement.lastUpdated}</c:if>.
              </c:when>
              <c:when test="${displayReason eq notAcceptedDisplayMode}">
                  You have to accept the <c:out value="${agreement.shortName}"/> agreement before you can continue to use TeamCity
              </c:when>
            </c:choose>
            Review the terms and click "I agree" when you�re ready to continue using TeamCity.
          </div>
        </div>
        ${agreement.html}
      </div>
      <div class="agreementForm clearfix">
        <form action="${pageUrl}" method="post" onsubmit="if (!this.accept.checked) { alert('Please accept the ${name}'); return false; };">
          <div class="consentBlock">
            You are logged in as '${currentUser.descriptiveName}'<c:if test="${fn:length(currentUser.email) > 0}"> (<c:out value="${currentUser.email}"/>)</c:if>.
            Please accept the agreement to proceed.
            <c:forEach var="consent" items="${agreement.consents}">
            <p><forms:checkbox name="${consent.id}" checked="${consent.checkedByDefault}"/><label for="${consent.id}" class="rightLabel">${consent.text}</label></p>
            </c:forEach>
            <ext:includeExtensions placeId="<%=PlaceId.ACCEPT_LICENSE_SETTING%>"/>
          <div>

          <div class="continueBlock">
            <forms:submit label="I agree"/>
            &nbsp;
            <c:url value="/ajax.html?logout=1" var="logoutUrl"/>
            <a class="logout" href="#" onclick="BS.Logout('${logoutUrl}'); return false;">Log out</a>
          </div>
        </form>
      </div>
    </div>
    </bs:_loginPageDecoration>
  </jsp:attribute>
</bs:externalPage>
