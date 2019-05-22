<%--
  Created by IntelliJ IDEA.
  User: 辜建敏
  Date: 2019/5/17
  Time: 17:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>流程图</title>
</head>
<body style="margin: 0px">

<img style="position: absolute;" src="${pageContext.request.contextPath }/showResource/${deploymentId}/${png}.do">
<div style="border-radius:12px;position:absolute;left:${x}px;top:${y }px;width:${width-4 }px;height:${height-4 }px;border:3px red solid;"></div>
</body>
</html>
