<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>登陆页面</title>
    <!-- 调用CSS，JS -->
    <link href="images/style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        <!--
        body {
            margin-left: 0px;
            margin-top: 0px;
            /*background-image: url(login1_08.gif);*/
            background-repeat: repeat-x;
            margin-bottom: 0px;
            font-family: "宋体";
            font-size: 12px;
            line-height: 1.5;
            font-weight: normal;
            color: #546D87;
            background-color: #BBD9F5;
        }
        -->
    </style>
</head>
<body>
<table width="990" height="650" border="0" align="left" cellpadding="0" cellspacing="0">
    <tr>
        <td width="318" valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td height="299" align="right"><img src="images/login1_01.gif" width="318" height="299" /></td>
                </tr>
                <tr>
                    <td height="351" align="right"><img src="images/login1_04.gif" width="318" height="351" /></td>
                </tr>
            </table>
        </td>
        <td width="366" valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td height="299" background="images/login_6.gif"><img src="images/login1_02.gif" width="366" height="299" /></td>
                </tr>
                <tr>
                    <td height="96" valign="top" background="images/login_9.gif">
                        <form action="${pageContext.request.contextPath}/login.do" method="post">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="25%" height="25">&nbsp;</td>
                                    <td width="48%" valign="top">
                                        <label>
                                            <input name="username" type="text" class="txt" size="25" />
                                        </label>
                                    </td>
                                    <td width="27%" rowspan="2">
                                        <input type="image" src="images/login_2.gif"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td>
                                        <input name="password" type="password" class="txt" size="25" />
                                    </td>
                                </tr>
                                <tr>
                                    <td height="36">&nbsp;</td>
                                    <td style="color:red;">
                                        ${msg}
                                    </td>
                                    <td>&nbsp;</td>
                                </tr>
                            </table>
                        </form>
                    </td>
                </tr>
                <tr>
                    <td height="255" background="images/login1_07.gif">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td height="129">&nbsp;</td>
                            </tr>

                        </table>
                    </td>
                </tr>
            </table>
        </td>
        <td width="318" valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td height="299" align="left" background="images/login1_03.gif">&nbsp;</td>
                </tr>
                <tr>
                    <td height="351" align="left" background="images/login1_06.gif">&nbsp;</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>
</html>

