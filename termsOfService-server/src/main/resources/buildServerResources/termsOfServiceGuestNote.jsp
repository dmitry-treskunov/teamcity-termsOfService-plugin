<%@include file="/include-internal.jsp" %>
<%--@elvariable id="guestNotice" type="jetbrains.buildServer.termsOfService.TermsOfServiceManager.GuestNotice"--%>
<c:if test="${guestNotice != null}">
    <bs:linkCSS>
        ${teamcityPluginResourcesPath}/termsOfService.css
    </bs:linkCSS>

    <div id="guestNotice" style="display: none;">
        <div class="content">
            <div class="caption">${guestNotice.title}</div>
            <c:if test="${not empty guestNotice.note}">
                <div class="note">${guestNotice.note}</div>
            </c:if>
            <div class="actions"><input class="btn btn_primary submitButton" type="button" value="Review now..." onclick="BS.TermsOfServicesGuestNoteDialog.showCentered(); return false;"/></div>
        </div>
    </div>


    <bs:dialog dialogId="agreementDialog" closeCommand="BS.TermsOfServicesGuestNoteDialog.close();" title="${guestNotice.title}" dialogClass="modalDialog agreementDialog">
        <div style="max-height: 35em; overflow: scroll;" >
            ${guestNotice.html}

            <div class="popupSaveButtonsBlock">
                <forms:submit label="I agree" onclick="BS.TermsOfServicesGuestNoteDialog.accept();"/>
                <forms:cancel onclick="BS.TermsOfServicesGuestNoteDialog.close();"/>
            </div>
        </div>

    </bs:dialog>


    <script type="text/javascript">
        BS.TermsOfServicesGuestNoteDialog = OO.extend(BS.AbstractModalDialog, {

            getContainer: function () {
                return $('agreementDialog');
            },

            accept: function () {
                BS.Cookie.set("${guestNotice.cookieName}", "true", ${guestNotice.cookieDurationDays});
                BS.Util.hide("guestNotice");
                this.close();
            }
        });

        $j(document).ready(function() {
            if (!BS.Cookie.get("${guestNotice.cookieName}")) {
                BS.Util.show("guestNotice");
            }
        });
    </script>
</c:if>




