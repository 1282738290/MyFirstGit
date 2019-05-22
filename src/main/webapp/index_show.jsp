<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>G.net综合信息服务管理平台</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css" type="text/css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css" type="text/css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/menu.css" type="text/css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.0.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/kandtabs/kandytabs.pack.js"></script>
    <script type="text/javascript" src="j${pageContext.request.contextPath}/s/easing.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/kandtabs/kandytabs.css" type="text/css" />
    <script src="${pageContext.request.contextPath}/js/autoheight.js" type="text/javascript"></script>
    <link href="${pageContext.request.contextPath}/css/lanrenzhijia.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        var tab,index=0;
        $(function() {
            tab=$("#slide").KandyTabs({
                del:true,
                scroll:true,
                trigger:'click',
                custom:function(b,c,i){
                    $("p",c).fadeOut();
                    c.eq(i).find("p").slideDown(1500);
                    index=i;
                },
                done: function(btn,cont,tab){
                    $("#slide .tabbtn").each(function(i)
                    {
                        if($(this).text().indexOf("我的桌面")>-1)//如果当前选项卡是我的桌面
                        {
                            $(this).css({"background":"#027be4","border-bottom":"1px solid #027be4","font-weight":"bold","color":"#ffffff"});//修改选项景色
                            $(this).find('.tabdel').text("");//	去除关闭按钮
                        }
                    });
                    setIframeH();//前台设定IFRAME高度 最好在在登录时把高度获取存放到session供其他IFRAME使用
                }
            });
        });


    </script>
</head>

<body style="overflow: hidden;" scroll="no">
<!-- header -->
<div class="header" region="north" border="true" >
    <div class="logo fleft"><img src="images/logo.png" width="344" height="49" /></div>
    <div class="header_right">
        <ul>
            <li><a href="#" onclick="addTab('center.jsp','我的首页');" title="首页" id="home"></a></li>
            <li><a href="#" title="更换皮肤" id="theme"></a></li>
            <li><a href="#" title="设置" id="Setup"></a></li>
            <li><a href="#" title="刷新" id="refresh"></a></li>
            <li><a href="${pageContext.request.contextPath}/logoutexit.do" title="退出系统" id="logout" onclick="return confirm('是否退出系统!');"></a></li>
        </ul>
    </div>
</div>

<dl id="slide" >
    <dt>我的桌面</dt>
    <dd><iframe id=centerFrame name="centerFrame" class="centerFrame" frameborder="0" style="width: 100%;height:100px; overflow-x: hidden; overflow-y:auto" noresize="noresize" scrolling="auto" src="center.jsp"></iframe></dd>
</dl>

<!-- footer -->
<div id="footer">
    <!-- 菜单 -->
    <div class="menu">
        <ul>
            <li><a class="hide" href="#"><img src="images/menu.jpg" width="66" height="31" /></a>
                <ul  class="category" style="width:321px; background:url(images/menu_bg.jpg) repeat-y; padding-top:10px; border:2px solid #0059a5; border-bottom:none;">
                    <div class="people blue"><span><img src="${user.head_image }" width="29" height="29" /></span><strong>${user.name }</strong></div>
                    <c:forEach items="${user.menus}" var="m">
                        <shiro:hasPermission name="${m.percode}">
                            <li><a href="#" onclick="addTab('${pageContext.request.contextPath}/${m.url}','${m.NAME}')" class="icon_a">${m.NAME}</a>
                            <ul style="position:relative; bottom:30px;">
                                <c:forEach items="${m.subMenus}" var="s">
                                    <shiro:hasPermission name="${s.percode}">
                                        <li><a href="#" onclick="addTab('${pageContext.request.contextPath}/${s.url}','${s.NAME}')" class="icon_a">${s.NAME}</a></li>
                                    </shiro:hasPermission>
                                </c:forEach>
                            </ul>
                            </li>
                        </shiro:hasPermission>
                    </c:forEach>
                    <li><a href="#" class="icon_a">打卡</a></li>
                    <li><a href="#" class="icon_b">万年历</a></li>
                    <li><a href="#" class="icon_c">日程安排</a></li>
                    <li><a href="#" class="icon_d">个人中心</a></li>
                    <li><a href="#" class="icon_e">内部通讯</a></li>
                    <li><a href="#" class="icon_f">回收站</a></li>
                    <div class="out_quit"><a title="--" class="logout">--</a><a href="${pageContext.request.contextPath}/logoutexit.do" title="退出" class="quit" onclick="return confirm('是否退出系统!');">退出</a></div>
                </ul>
            </li>
        </ul>
    </div>
    <!-- -->
    <div class="footer_right"><span class="number">在线人数<strong><span id="num">${num}</span></strong>人</span>
        <a href="#" class="tixing"><img src="images/tixing.png" width="16" height="16" /></a>
        <a href="#" class="xiaoxi"><img src="images/youjian.png" width="20" height="13" /></a>
        <a href="#" class="liaotian"><img src="images/liaotian.png" width="27" height="19" /></a>
    </div>
    <div class="clear"></div>
</div>
<script>
    function ff() {
       $.post('loadcont.do',{},function (data) {
           $("#num").text(data);
       });
    }
    setInterval(ff,10000);
</script>
</body>
</html>
    