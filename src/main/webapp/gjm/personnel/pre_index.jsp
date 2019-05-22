<%--
  Created by IntelliJ IDEA.
  User: 辜建敏
  Date: 2019/5/14
  Time: 14:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <title>我的工作</title>

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
            <li style="background-color: red;"><a href="${pageContext.request.contextPath}/showPersonTask.do">
                <i class="layui-icon" style="font-weight: bold;">&#xe857;</i>&nbsp;
                待办任务</a></li>
            <li ><a href="${pageContext.request.contextPath}/task_picking.do">
                <i class="layui-icon" style="font-weight: bold;">&#xe600;</i>&nbsp;
                任务拾取</a></li>
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
                <td width="5%" nowrap class="td_l_c">编号</td>
                <td width="10%" nowrap class="td_l_c">任务名称</td>
                <td width="10%" nowrap class="td_l_c">开始时间</td>
                <td width="20%" nowrap class="td_l_c">需求主题</td>
                <td width="10%" nowrap class="td_l_c">招聘部门</td>
                <td width="10%" nowrap class="td_l_c">申请人</td>
                <td width="15%" nowrap class="td_l_c">工作流程</td>
                <td width="20%" nowrap class="td_l_c">相关操作</td>
            </tr>
            <c:if test="${list.size()==0}">
                <tr class="tr">
                    <td colspan="8" width="100%" nowrap class="td_l_c">当前暂无人员申请任务</td>
                </tr>
            </c:if>
            <c:forEach items="${list}" var="s" varStatus="v">
                <tr class="tr" >
                    <td nowrap class="td_l_c">${v.count}</td>
                    <td nowrap class="td_l_c">${s.taskName}</td>
                    <Td nowrap class="td_l_c"><fmt:formatDate pattern="yyyy-MM-dd" value="${s.createtime }"/></Td>
                    <td nowrap class="td_l_c">${s.themes}</td>
                    <td nowrap class="td_l_c">${s.dep_name}</td>
                    <td nowrap class="td_l_c">${s.assges}</td>
                    <td nowrap class="td_l_c">
                        <a class="fbtn i-sms" href="#" onclick="parent.addTab('${pageContext.request.contextPath }/showActiveMap/${s.processInstanceId}.do','流程图')">
                            <i class="layui-icon" style="font-weight: bold;">&#xe64a;</i>
                            查看流程图&nbsp;</a>
                        <a class="fbtn i-sms" href="#" onclick="parent.addTab('${pageContext.request.contextPath }/showHistoryTask/${s.pre_id}.do','流程进度')">
                            <i class="layui-icon" style="font-weight: bold;">&#xe62c;</i>
                            流程跟踪&nbsp;</a>
                    </td>
                    <td nowrap="nowrap" class="td_l_c">
                        <a class="fbtn i-sms" href="${pageContext.request.contextPath}/audit/${s.taskId}/${s.pre_id}/${s.taskDefKey}.do">
                            <i class="layui-icon" style="font-weight: bold;">&#xe609;</i>
                            任务审批&nbsp;</a>
                        <a class="fbtn i-edit" href="${pageContext.request.contextPath}/tasksend/${s.taskId}.do">
                            <i class="layui-icon" style="font-weight: bold;">&#xe64c;</i>
                            任务退回&nbsp;</a>
                    </td>
                </tr>
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


