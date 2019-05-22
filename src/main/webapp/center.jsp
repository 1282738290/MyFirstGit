<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>G.net综合信息服务管理平台</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css" type="text/css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css" type="text/css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/menu.css" type="text/css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/cfcoda.js" language="javascript"></script>
<script src="${pageContext.request.contextPath}/js/time.js" language="javascript"></script>
<link href="${pageContext.request.contextPath}/css/lanrenzhijia.css" rel="stylesheet" type="text/css" />
</head>
<body style="overflow: hidden;" scroll="no">
<!-- content -->
<div  style="position:relative;">
  
  
     
   <div id="frame">
   <div id="scroller">
    <div id="content">
       <div class="section" id="pane-0">
        <div class="page1">
           <div class="content">
            <div class="first_screen">
               <div class="weather">
                <div class="today"> <img src="images/icon_tianqi.png" width="70" height="60" /> <span>31~20°C</span> </div>
                <div class="city"><a href="#">郑州</a></div>
                <div class="clear"></div>
                <div class="refresh"><span class="fleft">更新时间15:30</span><a href="#" class="fright">刷新</a></div>
              </div>
               <div class="time"> <span id="h1"></span> <span id="h2"></span><strong>:</strong> <span id="m1"></span> <span id="m2"></span><strong>:</strong> <span id="s1"></span> <span id="s2"></span> </div>
               <div class="date" id="currentime"></div>
               <div class="welcome_wz"><img src="images/welcome_wz.png" width="400" height="112" /></div>
             </div>
          </div>
         </div>
      </div>
     </div>
  </div>
  
   <div class="clear"></div>
   <!-- -->
   <div class="main_desktop">
    <ul class="desktop_wrap">
       <li>
        <p>打卡</p>
        <a href="500error.jsp"><img src="images/icon_2.png" width="56" height="58" /></a></li>
       <li>
        <p>工作任务</p>
        <a href="#" onclick="parent.addTab('#','工作任务')"><img src="images/icon_3.png" width="64" height="57" /></a></li>
       <li>
        <p>个人中心</p>
        <a href="#" onclick="parent.addTab('#','人事管理')"><img src="images/icon_4.png" width="64" height="62" /></a></li>
       <li>
        <p>请假申请</p>
           <%--关联组任务--%>
           <%--${pageContext.request.contextPath}/loading.do--%>
        <a href="#" onclick="parent.addTab('#','控制面板')"><img src="images/icon_5.png" width="60" height="58" /></a></li>
       <li>
        <p>日程安排</p>
        <a href="#" onclick="parent.addTab('#','及时提醒')"><img src="images/icon_6.png" width="61" height="63" /></a></li>
     </ul>
  </div>
 </div>
 </div>
</body>
</html>
