<%--
  Created by IntelliJ IDEA.
  User: 辜建敏
  Date: 2019/5/17
  Time: 18:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <title>流程进度</title>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/gjm/css/common.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/gjm/css/desktop.css">
    <link rel='stylesheet' type="text/css" href='${pageContext.request.contextPath}/gjm/css/font-awesome.min.css'>
    <link rel='stylesheet' type="text/css" href="${pageContext.request.contextPath}/gjm/css/ui-dialog.css">


    <link rel='stylesheet' type="text/css" href='${pageContext.request.contextPath}/gjm/layui/css/layui.css'>

    <script src="${pageContext.request.contextPath}/gjm/js/common.js"></script>
    <script src="${pageContext.request.contextPath}/gjm/js/jquery-3.0.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/gjm/js/uploads.js"></script>
    <script src="${pageContext.request.contextPath}/gjm/js/layer.js"></script>
    <script src="${pageContext.request.contextPath}/gjm/js/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/gjm/js/dialog.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/gjm/js/sea.js" type="text/javascript"></script>


    <script src="${pageContext.request.contextPath}/gjm/layui/layui.js"></script>

    <script src="${pageContext.request.contextPath}/js/cfcoda.js" language="javascript"></script>
    <script src="${pageContext.request.contextPath}/js/time.js" language="javascript"></script>
    <link href="${pageContext.request.contextPath}/css/lanrenzhijia.css" rel="stylesheet" type="text/css" />

    <!--PC端样式引用，此处可以继续增加js和css文件引用-->
    <style type="text/css">

        td{
            text-align: center;
        }
    </style>
</head>
<body>
<div class="cssout">
    <div class="menuboxs">
        <ul>
            <li ><a href="${pageContext.request.contextPath}/my_taskload.do">
                <i class="layui-icon" style="font-weight: bold;">&#xe857;</i>&nbsp;
                当前任务</a></li>
            <li style="background-color: red;"><a href="${pageContext.request.contextPath}/end_taskload/${processDefinitionId}.do">
                <i class="layui-icon" style="font-weight: bold;">&#xe600;</i>&nbsp;
                任务跟踪</a></li>
            <li ><a href="${pageContext.request.contextPath}/per_shenqing.do">
                <i class="layui-icon" style="font-weight: bold;">&#xe654;</i>&nbsp;
                人员申请</a></li>
        </ul>
        <div style=" min-width:250px; float:left;background:none; padding-left:5px; margin-top:5px;">

        </div>
        <div class="clear"></div>
    </div>
</div>

<ul class="xhing">
    <div class="cssout topnavsou">
        <div class="cssin">
            <span class="ksss">快速搜索：</span>
            <input name="S201_mhsou_keywords" id="S201_mhsou_keywords" type="text" class="bor int mhsouint" size="40" value='' placeholder="任务、办理人、时间...">
            <input type="button" name="Submit" class="btn1 btnsou" value="快速搜索">
            <div class="clear"></div>
        </div>
    </div>
    <div class="searchss"><a id="zkgb"><i class='ficon fa-search'></i>展开高级搜索</a></div>
    <div class="cssout">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" CLASS="table_1">
            <tr class="tr_t">
                <td width="10%" nowrap class="td_l_c">编号</td>
                <td width="20%" nowrap class="td_l_c">需求主题</td>
                <td width="10%" nowrap class="td_l_c">申请人</td>
                <td width="15%" nowrap class="td_l_c">开始时间</td>
                <td width="15%" nowrap class="td_l_c">结束时间</td>
                <td width="10%" nowrap class="td_l_c">审核状态</td>
                <td width="20%" nowrap class="td_l_c">工作流程</td>
            </tr>
            <c:if test="${list.size()==0}">
                <tr class="tr">
                    <td colspan="7" width="100%" nowrap class="td_l_c">当前暂无历史信息</td>
                </tr>
            </c:if>
            <c:forEach items="${list}" var="s" varStatus="v">
                <c:if test="${s.deleteReason eq null}">
                    <tr class="tr" >
                        <td nowrap class="td_l_c">${v.count}</td>
                        <td nowrap class="td_l_c">${s.themes}</td>
                        <td nowrap class="td_l_c">${s.assges}</td>
                        <td nowrap class="td_l_c"><fmt:formatDate pattern="yyyy-MM-dd" value="${s.starttime2 }"/></Td>
                        <td nowrap class="td_l_c"><fmt:formatDate pattern="yyyy-MM-dd" value="${s.endtime2 }"/></Td>
                        <td nowrap class="td_l_c">
                            <c:if test="${s.endtime2 eq null}">
                                <a class="fbtn i-sms" style="background-color: lightgrey;">
                                    <i class="layui-icon" style="font-weight: bold;">&#xe64d;</i>
                                    审批中&nbsp;</a>
                            </c:if>
                            <c:if test="${s.endtime2 ne null}">
                                <a class="fbtn i-edit">
                                    <i class="layui-icon" style="font-weight: bold;">&#x1002;</i>
                                    审批已完成&nbsp;</a>
                            </c:if>
                        </td>
                        <td nowrap class="td_l_c">
                            <c:if test="${s.endtime2 eq null}">
                                <a class="fbtn i-sms" href="#" onclick="parent.addTab('${pageContext.request.contextPath }/showActiveMap/${s.processInstanceId}.do','流程图')">
                                    <i class="layui-icon" style="font-weight: bold;">&#xe64a;</i>
                                    查看流程图&nbsp;</a>
                                <a class="fbtn i-sms" href="#" onclick="parent.addTab('${pageContext.request.contextPath }/showHistoryTask/${s.pre_id}.do','流程进度')">
                                    <i class="layui-icon" style="font-weight: bold;">&#xe62c;</i>
                                    流程跟踪&nbsp;</a>
                            </c:if>
                            <c:if test="${s.endtime2 ne null}">
                                <a class="fbtn i-sms" href="#" onclick="parent.addTab('${pageContext.request.contextPath }/showHistoryTask/${s.pre_id}.do','流程进度')">
                                    <i class="layui-icon" style="font-weight: bold;">&#xe62c;</i>
                                    流程跟踪&nbsp;</a>
                            </c:if>

                        </td>
                    </tr>
                </c:if>
            </c:forEach>
        </table>

    </div>
    <div class="h50b"></div>
    <div class="clear"></div>
    <div class="fixed_bg">

        <!--分页代码开始-->
        <div class="pagenums">
            页次 : 1/1 页   每页 : 10 条  总数 : 1 条 <a class=disabled>上一页</a>
            <a class='nums on' href='#'>1</a><a class=disabled>下一页</a>
            <input class=pagenum id=geturl value='' title='输入跳转页码'>
            <a class=nums href='#'>跳转</a>

        </div>
        <!--分页代码结束-->

    </div>
</ul>
</body>
</html>
