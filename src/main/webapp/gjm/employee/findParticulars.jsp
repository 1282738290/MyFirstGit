<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <title>人员信息</title>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/gjm/css/common.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/gjm/css/desktop.css">
    <link rel='stylesheet' type="text/css" href="${pageContext.request.contextPath}/gjm/css/font-awesome.min.css">
    <link rel='stylesheet' type="text/css" href="${pageContext.request.contextPath}/gjm/css/ui-dialog.css">

    <link rel='stylesheet' type="text/css" href='${pageContext.request.contextPath}/gjm/layui/css/layui.css'>

    <script src="${pageContext.request.contextPath}/gjm/js/jquery-3.0.0.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/gjm/js/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/gjm/js/dialog.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/gjm/js/sea.js" type="text/javascript"></script>

    <script src="${pageContext.request.contextPath}/gjm/layui/layui.js"></script>

    <!--PC端样式引用，此处可以继续增加js和css文件引用-->

</head>
<body>
<div class="cssout">

        <div class="cssin">
            <ul>
                <li class="w100 bg" style="text-align: center;">
                    <dd class="isin"><B>人员申请详情信息</B></dd>
                </li>
                <li class="w100">
                    <dd class="isin">
                    </dd>
                </li>
                <!--line-->
                <li class="w12 bg cl tr">
                    <dd class="isin">申请主题: </dd>
                </li>
                <li class="w88">
                    <dd class="isin">
                        ${par.themes}
                    </dd>
                </li>


                <!--line-->
                <li class="w12 bg cl tr">
                    <dd class="isin">招聘部门: </dd>
                </li>
                <li class="w38">
                    <dd class="isin">
                        ${par.dep_name}
                    </dd>
                </li>
                <li class="w12 bg tr">
                    <dd class="isin">招聘岗位: </dd>
                </li>
                <li class="w38">
                    <dd class="isin">
                        ${par.posts}
                    </dd>
                </li>
                <!--end-->

                <!--line-->
                <li class="w12 bg cl tr">
                    <dd class="isin">招聘人数: </dd>
                </li>
                <li class="w38">
                    <dd class="isin">
                        ${par.inv_number}
                    </dd>
                </li>
                <li class="w12 bg tr">
                    <dd class="isin">员工职务: </dd>
                </li>
                <li class="w38">
                    <dd class="isin">
                        ${par.emp_duty}
                    </dd>
                </li>
                <!--end-->
                <!--line-->
                <li class="w12 bg cl tr">
                    <dd class="isin">任务创建时间: </dd>
                </li>
                <li class="w38">
                    <dd class="isin">
                       <fmt:formatDate value="${par.createtime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
                    </dd>
                </li>
                <li class="w12 bg tr">
                    <dd class="isin">创建人: </dd>
                </li>
                <li class="w38">
                    <dd class="isin">
                        ${par.assges}
                    </dd>
                </li>

                <!--line-->
                <li class="w12 bg cl tr" style="height: 106px;">
                    <dd class="isin">岗位要求</dd>
                </li>
                <li class="w88">
                    <dd class="isin">
                        ${par.pos_ask}
                    </dd>
                </li>

                <!--line-->
                <li class="w12 bg cl tr" style="height: 106px;">
                    <dd class="isin">内容明细</dd>
                </li>
                <li class="w88">
                    <dd class="isin">
                        ${par.pos_detail}
                    </dd>
                </li>

                <!--line-->
                <li class="w12 bg cl tr" style="height: 106px;">
                    <dd class="isin">备注</dd>
                </li>
                <li class="w88">
                    <dd class="isin">
                        ${par.remark}
                    </dd>
                </li>
            </ul>
        </div>
        <div class="h50b"></div>
</div>
<!--文件末尾样式引用，此处可以继续增加js和css文件引用-->
</body>
</html>

