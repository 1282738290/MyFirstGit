<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>

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
  <div class="menuboxs">
    <ul>
      <li ><a href="${pageContext.request.contextPath}/my_taskload.do">
        <i class="layui-icon" style="font-weight: bold;">&#xe857;</i>&nbsp;
        当前任务</a></li>
      <li><a href="${pageContext.request.contextPath}/end_taskload/${processDefinitionId}.do">
        <i class="layui-icon" style="font-weight: bold;">&#xe600;</i>&nbsp;
        任务跟踪</a></li>
      <li  style="background-color: red;"><a href="${pageContext.request.contextPath}/per_shenqing.do">
        <i class="layui-icon" style="font-weight: bold;">&#xe654;</i>&nbsp;
        人员申请</a></li>
    </ul>
    <div style=" min-width:250px; float:left;background:none; padding-left:5px; margin-top:5px;">

    </div>
    <div class="clear"></div>
  </div>
</div>
<!----------------------------------------新增员工开始---------------------------------------->
<div class="cssout">
  <form action="${pageContext.request.contextPath}/personnel.do" id="myform" method="post">
    <div class="cssin">
      <ul>
        <li class="w100 bg" style="text-align: center;">
          <dd class="isin"><B>人员申请信息</B></dd>
        </li>
        <li class="w100">
          <dd class="isin">
           </dd>
        </li>
        <!--line-->
        <li class="w12 bg cl tr">
          <dd class="isin"><span style="color: red;">*</span>申请主题</dd>
        </li>
        <li class="w88">
          <dd class="isin">
            <input name="themes" type="text" class="bor int" size="170%">
            <span class="info_help vtip" titles="录入后不可修改">&nbsp;</span></dd>
        </li>

        
        <!--line-->
        <li class="w12 bg cl tr">
          <dd class="isin">招聘部门</dd>
        </li>
        <li class="w38">
          <dd class="isin">
            <input name="dep_name" type="text" class="bor int" id="dep_name" size="30" value="${user.dep.dep_name}" readonly>
          </dd>
        </li>
        <li class="w12 bg tr">
          <dd class="isin"><span style="color: red;">*</span>招聘岗位</dd>
        </li>
        <li class="w38">
          <dd class="isin">
            <input name="posts" type="text" class="bor int" id="posts" size="30">
          </dd>
        </li>
        <!--end-->

        <!--line-->
        <li class="w12 bg cl tr">
          <dd class="isin"><span style="color: red;">*</span>招聘人数</dd>
        </li>
        <li class="w38">
          <dd class="isin">
            <input name="inv_number" type="number" class="bor int" id="inv_number" size="30">
          </dd>
        </li>
        <li class="w12 bg tr">
          <dd class="isin"><span style="color: red;">*</span>员工职务</dd>
        </li>
        <li class="w38">
          <dd class="isin">
            <input name="emp_duty" type="text" class="bor int" id="emp_duty" size="30">
          </dd>
        </li>
        <!--end-->

          <!--line-->
          <li class="w12 bg cl tr" style="height: 106px;">
              <dd class="isin">岗位要求</dd>
          </li>
          <li class="w38">
              <dd class="isin">
                <textarea name="pos_ask" cols="180%" rows="6" style="overflow-y: hidden;">

                </textarea>
              </dd>
          </li>

        <!--line-->
        <li class="w12 bg cl tr" style="height: 106px;">
          <dd class="isin">内容明细</dd>
        </li>
        <li class="w38">
          <dd class="isin">
                <textarea name="pos_detail" cols="180%" rows="6" style="overflow-y: hidden;">

                </textarea>
          </dd>
        </li>

        <!--line-->
        <li class="w12 bg cl tr" style="height: 106px;">
          <dd class="isin">备注</dd>
        </li>
        <li class="w38">
          <dd class="isin">
                <textarea name="remark" cols="180%" rows="6" style="overflow-y: hidden;">

                </textarea>
          </dd>
        </li>

      </ul>
    </div>
    <div class="h50b"></div>
    <div class="fixed_bg_B">
      <input type="submit" class="btn2 btnbaoc" value="保存">
      <input name="Back" type="button" id="Back" class="btn2 btnguanb" value="返回" onClick="location='/my_taskload.do';">
    </div>
  </form>
</div>
<script type="text/javascript">
    function showff(context) {
        var d = dialog({
            title:"提示",
            content: context,
            cancel: false
        });
        d.width(180);
        d.showModal();
        setTimeout(function () {
            d.close().remove();
        }, 2000);
    }

    $("#myform").submit(function () {
        var themes = $("[name='themes']").val();
        var posts = $("[name='posts']").val();
        var inv_number = $("[name='inv_number']").val();
        var emp_duty = $("[name='emp_duty']").val();

        if (themes == null || themes == "") {
            showff("申请主题不能为空！");
            return false;
        }
        else if (posts == null || posts == "") {
            showff("岗位不能为空！");
            return false;
        }
        else if (inv_number == null || inv_number == "") {
            showff("职务不能为空！");
            return false;
        }
        else if (emp_duty == null || emp_duty == "") {
            showff("人数不能为空！");
            return false;
        }
        else {
            return true;
        }
    });

</script>
 
<!--文件末尾样式引用，此处可以继续增加js和css文件引用-->
</body>
</html>

