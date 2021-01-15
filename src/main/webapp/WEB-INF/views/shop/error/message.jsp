<%@page import="com.project.cinderella.common.MessageData"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
   MessageData messageData= (MessageData)request.getAttribute("messageData");
%>

    <%@ include file="../inc/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
<script type="text/javascript">
   alert("<%=messageData.getMsg()%>");
   <%if(messageData.getResultCode()==1){%>
      location.href="<%=messageData.getUrl()%>";
   <%}else{%>
      history.back();
   <%}%>
</script>
</head>
<body>
    <%@ include file="../inc/footer.jsp" %>
    <%@ include file="../inc/bottom.jsp" %>
</body>
</html>