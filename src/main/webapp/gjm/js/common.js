function killerrors() {
    return true
}
	 
window.onerror = killerrors;
var searchReq = createAjaxObj();
function createAjaxObj() {
    var httprequest = false;
    if (window.XMLHttpRequest) {
        httprequest = new XMLHttpRequest();
        if (httprequest.overrideMimeType) {
            httprequest.overrideMimeType("text/xml")
        }
    } else {
        if (window.ActiveXObject) {
            try {
                httprequest = new ActiveXObject("Msxml2.XMLHTTP")
            } catch(e) {
                try {
                    httprequest = new ActiveXObject("Microsoft.XMLHTTP")
                } catch(e) {}
            }
        }
    }
    return httprequest
}
function searchSuggest(sstop, ssleft) {
    if (document.getElementById("company").value.length > 0) {
        var str = escape(document.getElementById("company").value);
        url = "../crm/inc.check.asp?item=" + str + "&t=" + new Date().getTime();
        searchReq.open("get", url);
        searchReq.onreadystatechange = handleSearchSuggest;
        searchReq.send(null)
    } else {
        document.getElementById("ss_suggest").innerHTML = "";
        document.getElementById("ss_suggest").style.display = "none"
    }
}
function handleSearchSuggest() {
    if (searchReq.readyState == 4) {
        var ss = document.getElementById("ss_suggest");
        ss.innerHTML = "";
        s0 = searchReq.responseText.length;
        if (s0 > 0) {
            xmldoc = searchReq.responseXML;
            var message_nodes = xmldoc.getElementsByTagName("message");
            var n_messages = message_nodes.length;
            if (n_messages <= 0) {
                document.getElementById("ss_suggest").innerHTML = "";
                document.getElementById("ss_suggest").style.display = "none"
            } else {
                document.getElementById("ss_suggest").style.display = "block";
                for (i = 0; i < n_messages; i++) {
                    var suggest = '<div onmouseover="javascript:suggestOver(this);"';
                    suggest += 'onmouseout="javascript:sugggestOut(this);"';
                    suggest += 'onclick="javascript:setsearch(this.innerHTML);"';
                    suggest += 'class="suggest_link">' + message_nodes[i].getElementsByTagName("text")[0].firstChild.data + "</div>";
                    ss.innerHTML += suggest
                }
            }
        } else {
            document.getElementById("ss_suggest").innerHTML = "";
            document.getElementById("ss_suggest").style.display = "none"
        }
    } else {}
}
function suggestOver(div_value) {
    div_value.className = "suggest_link_over"
}
function sugggestOut(div_value) {
    div_value.className = "suggest_link"
}
function sugggestclose(div_value) {
    document.getElementById("ss_suggest").style.display = "none"
}
function setsearch(div_value) {
    if (div_value == "关闭") {
        document.getElementById("ss_suggest").innerHTML = "";
        document.getElementById("ss_suggest").style.display = "none"
    } else {
        document.getElementById("company").value = div_value;
        document.getElementById("ss_suggest").innerHTML = "";
        document.getElementById("ss_suggest").style.display = "none"
    }
}

function CheckAll(thisform) {
    for (var i = 0; i < thisform.elements.length; i++) {
        var e = thisform.elements[i];
        if (e.Name != "chkAll" && e.disabled != true) {
            e.checked = thisform.chkAll.checked
        }
    }
}
function createXmlHttp() {
    xmlHttp = false;
    if (window.ActiveXObject) {
        try {
            xmlHttp = new ActiveXObject("Msxml2.XMLHTTP")
        } catch(e) {
            xmlHttp = new ActiveXObject("Microsoft.XMLHTTP")
        }
    } else {
        if (window.XMLHttpRequest) {
            xmlHttp = new XMLHttpRequest()
        }
    }
}

function setCookie(name, value) {
    var Days = 1;
    var exp = new Date();
    exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
    document.cookie = name + "=" + escape(value) + ";expires=" + exp.toGMTString()
}
function getCookie(name) {
    var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
    if (arr = document.cookie.match(reg)) {
        return unescape(arr[2])
    } else {
        return null
    }
}
function delCookie(name) {
    var exp = new Date();
    exp.setTime(exp.getTime() - 1);
    var cval = getCookie(name);
    if (cval != null) {
        document.cookie = name + "=" + cval + ";expires=" + exp.toGMTString()
    }
}

function createxmlhttp() {
    xmlhttpobj = false;
    try {
        xmlhttpobj = new XMLHttpRequest
    } catch(e) {
        try {
            xmlhttpobj = new ActiveXObject("MSXML2.XMLHTTP")
        } catch(e2) {
            try {
                xmlhttpobj = new ActiveXObject("Microsoft.XMLHTTP")
            } catch(e3) {
                xmlhttpobj = false
            }
        }
    }
    return xmlhttpobj
}

function checkcompany(intvalue, oldvalue) {
    var xmlhttpobj = createxmlhttp();
    if (xmlhttpobj) {
        xmlhttpobj.open("GET", "/crm/inc.isok.asp?action=companys&ccompany=" + escape(intvalue) + "&oldvalue=" + escape(oldvalue) + "&number=" + Math.random() + "", true);
        xmlhttpobj.onreadystatechange = function() {
            if (xmlhttpobj.readyState == 4) {
                if (xmlhttpobj.status == 200) {
                    var ResponseText = xmlhttpobj.responseText;
                    if (ResponseText == "") {
                        document.getElementById("check1").innerHTML = ResponseText
                    } else {
                        document.getElementById("check1").innerHTML = ResponseText;
                        if (ResponseText.indexOf("已") > 0) {
                            document.getElementById("submit").disabled = false;
                            document.getElementById("submit").className = "btn2 btnbaocno";
                            document.getElementById("submit").value = "数据重复,无法录入";
                            document.getElementById("bscompany").value = "1";
                            $("#submit").attr("disabled", "disabled")
                        } else {
                            if (ResponseText.indexOf("允许") > 0) {
                                document.getElementById("submit").disabled = true;
                                document.getElementById("submit").className = "btn2 btnbaoc";
                                document.getElementById("submit").value = "保存";
                                document.getElementById("bscompany").value = "0";
                                $("#submit").removeAttr("disabled")
                            }
                        }
                    }
                } else {
                    document.getElementById("check1").innerHTML = "读取错误"
                }
            } else {
                document.getElementById("check1").innerHTML = "正在加载..."
            }
        };
        xmlhttpobj.send(null)
    } else {
        document.getElementById("check1").innerHTML = "浏览器不兼容"
    }
}
function checklinkman(intvalue, oldvalue) {
    var xmlhttpobj = createxmlhttp();
    if (xmlhttpobj) {
        xmlhttpobj.open("GET", "/crm/inc.isok.asp?action=clinkman&linkman=" + escape(intvalue) + "&oldvalue=" + escape(oldvalue) + "&number=" + Math.random() + "", true);
        xmlhttpobj.onreadystatechange = function() {
            if (xmlhttpobj.readyState == 4) {
                if (xmlhttpobj.status == 200) {
                    var ResponseText = xmlhttpobj.responseText;
                    if (ResponseText == "") {
                        document.getElementById("check2").innerHTML = ResponseText
                    } else {
                        document.getElementById("check2").innerHTML = ResponseText;
                        if (ResponseText.indexOf("已") > 0) {
                            document.getElementById("submit").disabled = false;
                            document.getElementById("submit").className = "btn2 btnbaocno";
                            document.getElementById("submit").value = "数据重复,无法录入";
                            document.getElementById("bslinkman").value = "1";
                            $("#submit").attr("disabled", "disabled")
                        } else {
                            document.getElementById("submit").disabled = true;
                            document.getElementById("submit").className = "btn2 btnbaoc";
                            document.getElementById("submit").value = "保存";
                            document.getElementById("bslinkman").value = "0";
                            $("#submit").removeAttr("disabled")
                        }
                    }
                } else {
                    document.getElementById("check2").innerHTML = "读取错误"
                }
            } else {
                document.getElementById("check2").innerHTML = "正在加载..."
            }
        };
        xmlhttpobj.send(null)
    } else {
        document.getElementById("check2").innerHTML = "浏览器不兼容"
    }
}
function checkmobile(intvalue,oldvalue,mobilejz) {

intvalue = intvalue.replace(/(^\s*)|(\s*$)/g, "");
	
if(mobilejz==1){//精准识别
		
var myreg = /^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(16[0-9]{1})|(17[0-9]{1})|(18[0-9]{1})|(19[0-9]{1}))+\d{8})$/; 
if(!myreg.test(intvalue)) 
{
  document.getElementById("check3").innerHTML = "<span id=ck_right3 class=info_error>手机号必须为11位数字</span>";
  
  document.getElementById("submit").disabled = false;
  document.getElementById("submit").className = "btn2 btnbaocno";
  document.getElementById("submit").value = "手机号格式错误";
  document.getElementById("bsmobile").value = "1";
  $("#submit").attr("disabled", "disabled")
  
  return false; 
}



}else if(mobilejz==0){//普通识别


var myreg = /^[\d-]*$/; 
if(!myreg.test(intvalue)||intvalue.length<7) 
{
  document.getElementById("check3").innerHTML = "<span id=ck_right3 class=info_error>手机/电话号格式错误</span>";
  
  document.getElementById("submit").disabled = false;
  document.getElementById("submit").className = "btn2 btnbaocno";
  document.getElementById("submit").value = "手机/电话号格式错误";
  document.getElementById("bsmobile").value = "1";
  $("#submit").attr("disabled", "disabled")
  
  return false; 
}


}
	
    var xmlhttpobj = createxmlhttp();
    if (xmlhttpobj) {
        xmlhttpobj.open("GET", "/crm/inc.isok.asp?action=cmobile&mobile=" + escape(intvalue) + "&oldvalue=" + escape(oldvalue) + "&number=" + Math.random() + "", true);
        xmlhttpobj.onreadystatechange = function() {
            if (xmlhttpobj.readyState == 4) {
                if (xmlhttpobj.status == 200) {
                    var ResponseText = xmlhttpobj.responseText;
                    if (ResponseText != "") {
                        document.getElementById("check3").innerHTML = ResponseText;
                        if (ResponseText.indexOf("已") > 0) {
                            document.getElementById("submit").disabled = false;
                            document.getElementById("submit").className = "btn2 btnbaocno";
                            document.getElementById("submit").value = "数据重复,无法录入";
                            document.getElementById("bsmobile").value = "1";
                            $("#submit").attr("disabled", "disabled")
                        } else {
                            document.getElementById("submit").disabled = true;
                            document.getElementById("submit").className = "btn2 btnbaoc";
                            document.getElementById("submit").value = "保存";
                            document.getElementById("bsmobile").value = "0";
                            $("#submit").removeAttr("disabled")
                        }
                    }
                } else {
                    document.getElementById("check3").innerHTML = "读取错误"
                }
            } else {
                document.getElementById("check3").innerHTML = "正在加载..."
            }
        };
        xmlhttpobj.send(null)
    } else {
        document.getElementById("check3").innerHTML = "浏览器不兼容"
    }
}


function getarea(jinke_diqu) {
    if (jinke_diqu == 0) {
        document.getElementById("squarediv").innerHTML = "<select name='squares' class='int'><option value='' selected>未选择大类</option></select>";
        return
    }
    var xmlhttpobj = createxmlhttp();
    if (xmlhttpobj) {
        xmlhttpobj.open("GET", "/crm/inc.isok.asp?action=area&jinke_diqu=" + escape(jinke_diqu) + "&number=" + Math.random() + "", true);
        xmlhttpobj.onreadystatechange = function() {
            if (xmlhttpobj.readyState == 4) {
                if (xmlhttpobj.status == 200) {
                    var ResponseText = xmlhttpobj.responseText;
                    if (ResponseText == "") {
                        document.getElementById("squarediv").innerHTML = ResponseText
                    } else {
                        document.getElementById("squarediv").innerHTML = ResponseText
                    }
                } else {
                    document.getElementById("squarediv").innerHTML = "读取错误"
                }
            } else {
                document.getElementById("squarediv").innerHTML = "正在加载..."
            }
        };
        xmlhttpobj.send(null)
    } else {
        document.getElementById("squarediv").innerHTML = "浏览器不兼容"
    }
}
function getsquare(str) {
    document.getElementById("square").value = str.value
}
function gettrade(tradedata) {
    if (tradedata == 0) {
        document.getElementById("stradediv").innerHTML = "<select name='strade' class='int'><option value='' selected>未选择大类</option></select>";
        return
    }
    var xmlhttpobj = createxmlhttp();
    if (xmlhttpobj) {
        xmlhttpobj.open("GET", "/crm/inc.isok.asp?action=trade&tradedata=" + escape(tradedata) + "&number=" + Math.random() + "", true);
        xmlhttpobj.onreadystatechange = function() {
            if (xmlhttpobj.readyState == 4) {
                if (xmlhttpobj.status == 200) {
                    var ResponseText = xmlhttpobj.responseText;
                    if (ResponseText == "") {
                        document.getElementById("stradediv").innerHTML = ResponseText
                    } else {
                        document.getElementById("stradediv").innerHTML = ResponseText
                    }
                } else {
                    document.getElementById("stradediv").innerHTML = "读取错误"
                }
            } else {
                document.getElementById("stradediv").innerHTML = "正在加载..."
            }
        };
        xmlhttpobj.send(null)
    } else {
        document.getElementById("stradediv").innerHTML = "浏览器不兼容"
    }
}
function getstrade(str) {
    document.getElementById("strade").value = str.value
};


function guanbi(){
		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭 
}



