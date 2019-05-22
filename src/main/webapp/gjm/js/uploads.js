(function($) {
    $(function(){
        var $wrap = $("#uploader"),
        $queue = $('<ul class="filelist"></ul>').appendTo($wrap.find(".queueList")),
        $statusBar = $wrap.find(".statusBar"),
        $info = $statusBar.find(".info"),
        $upload = $wrap.find(".uploadBtn"),
        $placeHolder = $wrap.find(".placeholder"),
        $progress = $statusBar.find(".progress").hide(),
        fileCount = 0,
        fileSize = 0,
        ratio = window.devicePixelRatio || 1,
        thumbnailWidth = 110 * ratio,
        thumbnailHeight = 110 * ratio,
        state = "pedding",
        percentages = {},
        isSupportBase64 = (function() {
            var data = new Image();
            var support = true;
            data.onload = data.onerror = function() {
                if (this.width != 1 || this.height != 1) {
                    support = false
                }
            };
            data.src = "data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw==";
            return support
        })(),
        flashVersion = (function() {
            var version;
            try {
                version = navigator.plugins["Shockwave Flash"];
                version = version.description
            } catch(ex) {
                try {
                    version = new ActiveXObject("ShockwaveFlash.ShockwaveFlash").GetVariable("$version")
                } catch(ex2) {
                    version = "0.0"
                }
            }
            version = version.match(/\d+/g);
            return parseFloat(version[0] + "." + version[1], 10)
        })(),
        supportTransition = (function() {
            var s = document.createElement("p").style,
            r = "transition" in s || "WebkitTransition" in s || "MozTransition" in s || "msTransition" in s || "OTransition" in s;
            s = null;
            return r
        })(),
        uploader;
        if (!WebUploader.Uploader.support("flash") && WebUploader.browser.ie) {
            if (flashVersion) { (function(container) {
                    window["expressinstallcallback"] = function(state) {
                        switch (state) {
                        case "Download.Cancelled":
                            alert("您取消了更新！");
                            break;
                        case "Download.Failed":
                            alert("安装失败");
                            break;
                        default:
                            alert("安装已成功，请刷新！");
                            break
                        }
                        delete window["expressinstallcallback"]
                    };
                    var swf = "./expressInstall.swf";
                    var html = '<object type="application/' + 'x-shockwave-flash" data="' + swf + '" ';
                    if (WebUploader.browser.ie) {
                        html += 'classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" '
                    }
                    html += 'width="100%" height="100%" style="outline:0">' + '<param name="movie" value="' + swf + '" />' + '<param name="wmode" value="transparent" />' + '<param name="allowscriptaccess" value="always" />' + "</object>";
                    container.html(html)
                })($wrap)
            } else {
                $wrap.html('<a href="http://www.adobe.com/go/getflashplayer" target="_blank" border="0"><img alt="get flash player" src="http://www.adobe.com/macromedia/style_guide/images/160x41_Get_Flash_Player.jpg" /></a>')
            }
            return
        } else {
            if (!WebUploader.Uploader.support()) {
                alert("Web Uploader 不支持您的浏览器！");
                return
            }
        }
        uploader = WebUploader.create({
            pick: {
                id: "#filePicker",
                label: "点击选择图片"
            },
            formData: {
                uid: 123
            },
            dnd: "#dndArea",
            paste: "#uploader",
            chunked: false,
            chunkSize: 512 * 1024,
            swf: "/include/uploads/Uploader.swf",
            server: "/include/inc/upload.asp?dopost=image",
            accept: {
                title: "Images",
                extensions: "gif,jpg,jpeg,bmp,png",
                mimeTypes: "image/*"
            },
            disableGlobalDnd: true,
            fileNumLimit: 300,
            fileSizeLimit: 200 * 1024 * 1024,
            fileSingleSizeLimit: 50 * 1024 * 1024
        });
        uploader.on("dndAccept",
        function(items) {
            var denied = false,
            len = items.length,
            i = 0,
            unAllowed = "text/plain;application/javascript ";
            for (; i < len; i++) {
                if (~unAllowed.indexOf(items[i].type)) {
                    denied = true;
                    break
                }
            }
            return ! denied
        });
        uploader.addButton({
            id: "#filePicker2",
            label: "继续添加"
        });
        uploader.on("ready",
        function() {
            window.uploader = uploader
        });
        function addFile(file) {
            var $li = $('<li id="' + file.id + '">' + '<p class="title">' + file.name + "</p>" + '<p class="imgWrap"></p>' + '<p class="progress"><span></span></p>' + "</li>"),
            $btns = $('<div class="file-panel">' + '<span class="cancel">删除</span>' + '<span class="rotateRight">向右旋转</span>' + '<span class="rotateLeft">向左旋转</span></div>').appendTo($li),
            $prgress = $li.find("p.progress span"),
            $wrap = $li.find("p.imgWrap"),
            $info = $('<p class="error"></p>'),
            showError = function(code) {
                switch (code) {
                case "F_DUPLICATE":
                    text = "该文件已经被选择了!";
                    break;
                case "Q_EXCEED_NUM_LIMIT":
                    text = "上传文件数量超过限制!";
                    break;
                case "F_EXCEED_SIZE":
                    text = "文件大小超过限制!";
                    break;
                case "Q_EXCEED_SIZE_LIMIT":
                    text = "所有文件总大小超过限制!";
                    break;
                case "Q_TYPE_DENIED":
                    text = "文件类型不正确或者是空文件!";
                    break;
                default:
                    text = "未知错误!";
                    break
                }
                $info.text(text).appendTo($li)
            };
            if (file.getStatus() === "invalid") {
                showError(file.statusText)
            } else {
                $wrap.text("预览中");
                uploader.makeThumb(file,
                function(error, src) {
                    var img;
                    if (error) {
                        console.log(file);
                        switch (file.ext) {
                        case "txt":
                            img = $('<img src="/include/uploads/images/txt.png">');
                            break;
                        case "docx" || "doc": img = $('<img src="/include/uploads/images/word.png">');
                            break;
                        case "xlsx" || "xls": img = $('<img src="/include/uploads/images/excel.png">');
                            break;
                        case "pptx" || "ppt": img = $('<img src="/include/uploads/images/word.png">');
                            break;
                        case "mp3" || "wma": img = $('<img src="/include/uploads/images/music.png">');
                            break;
                        case "mp4":
                            img = $('<img src="/include/uploads/images/video.png">');
                            break;
                        default:
                            img = $('<img src="/include/uploads/images/file.png">');
                            break
                        }
                        $wrap.empty().append(img);
                        return
                    }
                    if (isSupportBase64) {
                        img = $('<img src="' + src + '">');
                        $wrap.empty().append(img)
                    } else {
                        $.ajax("../../server/preview.php", {
                            method: "POST",
                            data: src,
                            dataType: "json"
                        }).done(function(response) {
                            if (response.result) {
                                img = $('<img src="' + response.result + '">');
                                $wrap.empty().append(img)
                            } else {
                                $wrap.text("预览出错")
                            }
                        })
                    }
                },
                thumbnailWidth, thumbnailHeight);
                percentages[file.id] = [file.size, 0];
                file.rotation = 0
            }
            file.on("statuschange",
            function(cur, prev) {
                if (prev === "progress") {
                    $prgress.hide().width(0)
                } else {
                    if (prev === "queued") {}
                }
                if (cur === "error" || cur === "invalid") {
                    console.log(file.statusText);
                    showError(file.statusText);
                    percentages[file.id][1] = 1
                } else {
                    if (cur === "interrupt") {
                        showError("interrupt")
                    } else {
                        if (cur === "queued") {
                            percentages[file.id][1] = 0
                        } else {
                            if (cur === "progress") {
                                $info.remove();
                                $prgress.css("display", "block")
                            } else {
                                if (cur === "complete") {
                                    $li.append('<span class="success"></span>')
                                }
                            }
                        }
                    }
                }
                $li.removeClass("state-" + prev).addClass("state-" + cur)
            });
            $li.on("mouseenter",
            function() {
                $btns.stop().animate({
                    height: 30
                })
            });
            $li.on("mouseleave",
            function() {
                $btns.stop().animate({
                    height: 0
                })
            });
            $btns.on("click", "span",
            function() {
                var index = $(this).index(),
                deg;
                switch (index) {
                case 0:
                    uploader.removeFile(file);
                    return;
                case 1:
                    file.rotation += 90;
                    break;
                case 2:
                    file.rotation -= 90;
                    break
                }
                if (supportTransition) {
                    deg = "rotate(" + file.rotation + "deg)";
                    $wrap.css({
                        "-webkit-transform": deg,
                        "-mos-transform": deg,
                        "-o-transform": deg,
                        "transform": deg
                    })
                } else {
                    $wrap.css("filter", "progid:DXImageTransform.Microsoft.BasicImage(rotation=" + (~~ ((file.rotation / 90) % 4 + 4) % 4) + ")")
                }
            });
            $li.appendTo($queue)
        }
        function removeFile(file) {
            var $li = $("#" + file.id);
            delete percentages[file.id];
            updateTotalProgress();
            $li.off().find(".file-panel").off().end().remove()
        }
        function updateTotalProgress() {
            var loaded = 0,
            total = 0,
            spans = $progress.children(),
            percent;
            $.each(percentages,
            function(k, v) {
                total += v[0];
                loaded += v[0] * v[1]
            });
            percent = total ? loaded / total: 0;
            spans.eq(0).text(Math.round(percent * 100) + "%");
            spans.eq(1).css("width", Math.round(percent * 100) + "%");
            updateStatus()
        }
        function updateStatus() {
            var text = "",
            stats;
            if (state === "ready") {
                text = "选中" + fileCount + "张图片，共" + WebUploader.formatSize(fileSize) + "。"
            } else {
                if (state === "confirm") {
                    stats = uploader.getStats();
                    if (stats.uploadFailNum) {
                        text = "已成功上传" + stats.successNum + "张图片，" + stats.uploadFailNum + '张照片上传失败，<a class="retry" href="#">重新上传</a>失败图片或<a class="ignore" href="#">忽略</a>'
                    }
                } else {
                    stats = uploader.getStats();
                    text = "共" + fileCount + "张（" + WebUploader.formatSize(fileSize) + "），已上传" + stats.successNum + "张";
                    if (stats.uploadFailNum) {
                        text += "，失败" + stats.uploadFailNum + "张"
                    }
                }
            }
            $info.html(text)
        }
        function setState(val) {
            var file, stats;
            if (val === state) {
                return
            }
            $upload.removeClass("state-" + state);
            $upload.addClass("state-" + val);
            state = val;
            switch (state) {
            case "pedding":
                $placeHolder.removeClass("element-invisible");
                $queue.hide();
                $statusBar.addClass("element-invisible");
                uploader.refresh();
                break;
            case "ready":
                $placeHolder.addClass("element-invisible");
                $("#filePicker2").removeClass("element-invisible");
                $queue.show();
                $statusBar.removeClass("element-invisible");
                uploader.refresh();
                break;
            case "uploading":
                $("#filePicker2").addClass("element-invisible");
                $progress.show();
                $upload.text("暂停上传");
                break;
            case "paused":
                $progress.show();
                $upload.text("继续上传");
                break;
            case "confirm":
                $progress.hide();
                $("#filePicker2").removeClass("element-invisible");
                $upload.text("开始上传");
                stats = uploader.getStats();
                if (stats.successNum && !stats.uploadFailNum) {
                    setState("finish");
                    return
                }
                break;
            case "finish":
                stats = uploader.getStats();
                if (stats.successNum) {
                    alert("上传成功")
                } else {
                    state = "done";
                    location.reload()
                }
                break
            }
            updateStatus()
        }
        uploader.onUploadProgress = function(file, percentage) {
            var $li = $("#" + file.id),
            $percent = $li.find(".progress span");
            $percent.css("width", percentage * 100 + "%");
            percentages[file.id][1] = percentage;
            updateTotalProgress()
        };
        uploader.onFileQueued = function(file) {
            fileCount++;
            fileSize += file.size;
            if (fileCount === 1) {
                $placeHolder.addClass("element-invisible");
                $statusBar.show()
            }
            addFile(file);
            setState("ready");
            updateTotalProgress()
        };
        uploader.onFileDequeued = function(file) {
            fileCount--;
            fileSize -= file.size;
            if (!fileCount) {
                setState("pedding")
            }
            removeFile(file);
            updateTotalProgress()
        };
        uploader.on("all",
        function(type) {
            var stats;
            switch (type) {
            case "uploadFinished":
                setState("confirm");
                break;
            case "startUpload":
                setState("uploading");
                break;
            case "stopUpload":
                setState("paused");
                break
            }
        });
        uploader.onError = function(code) {
            switch (code) {
            case "F_DUPLICATE":
                text = "该文件已经被选择了!";
                break;
            case "Q_EXCEED_NUM_LIMIT":
                text = "上传文件数量超过限制!";
                break;
            case "F_EXCEED_SIZE":
                text = "文件大小超过限制!";
                break;
            case "Q_EXCEED_SIZE_LIMIT":
                text = "所有文件总大小超过限制!";
                break;
            case "Q_TYPE_DENIED":
                text = "文件类型不正确或者是空文件!";
                break;
            default:
                text = "未知错误!";
                break
            }
            alert(text)
        };
        $upload.on("click",
        function() {
            if ($(this).hasClass("disabled")) {
                return false
            }
            if (state === "ready") {
                uploader.upload()
            } else {
                if (state === "paused") {
                    uploader.upload()
                } else {
                    if (state === "uploading") {
                        uploader.stop()
                    }
                }
            }
        });
        $info.on("click", ".retry",
        function() {
            uploader.retry()
        });
        $info.on("click", ".ignore",
        function() {
            alert("todo")
        });
        uploader.on("uploadSuccess",
        function(file, json) {
            var name = $wrap.data("name");
            $("#" + file.id).append("<input name='" + name + "[]' value='" + json.data[0].fileUrl + "'>");
            console.log(file);
            console.log(json)
        });
        $upload.addClass("state-" + state);
        updateTotalProgress()
    })
})(jQuery); 
(function($, window) {
    var applicationPath = window.applicationPath === "" ? "": window.applicationPath || "../..";
    function SuiJiNum() {
        return (((1 + Math.random()) * 65536) | 0).toString(16).substring(1)
    }
    function initWebUpload(item, options) {
        if (!WebUploader.Uploader.support()) {
            var error = "上传控件不支持您的浏览器！请尝试升级flash版本或者使用Chrome引擎的浏览器。<a target='_blank' href='http://se.360.cn'>下载页面</a>";
            if (window.console) {
                window.console.log(error)
            }
            $(item).text(error);
            return
        }
        var defaults = {
            auto: true,
            server: "/include/inc/upload.asp",
            hiddenInputId: "uploadifyHiddenInputId",
            onAllComplete: function(event) {},
            onComplete: function(event) {},
            innerOptions: {},
            accept: {},
            fileNumLimit: undefined,
            fileSizeLimit: undefined,
            fileSingleSizeLimit: undefined,
            PostbackHold: false
        };
        var opts = $.extend(defaults, options);
        var hdFileData = $("#" + opts.hiddenInputId);
        var target = $(item);
        var pickerid = "";
        if (typeof guidGenerator36 != "undefined") {
            pickerid = guidGenerator36()
        } else {
            pickerid = (((1 + Math.random()) * 65536) | 0).toString(16).substring(1)
        }
        var uploaderStrdiv = '<div class="webuploader">';
        if (opts.auto) {
            uploaderStrdiv = '<div id="Uploadthelist" class="uploader-list"></div>' + '<div class="btns">' + '<div id="' + pickerid + '">选择文件</div>' + "</div>"
        } else {
            uploaderStrdiv = '<div  class="uploader-list"></div>' + '<div class="btns">' + '<div id="' + pickerid + '">选择文件</div>' + '<button class="layui-btn">开始上传</button>' + "</div>"
        }
        uploaderStrdiv += '<div style="display:none" class="UploadhiddenInput" >                         </div>';
        uploaderStrdiv += "</div>";
        target.append(uploaderStrdiv);
        var $list = target.find(".uploader-list"),
        $btn = target.find(".webuploadbtn"),
        state = "pending",
        $hiddenInput = target.find(".UploadhiddenInput"),
        uploader;
        var jsonData = {
            fileList: []
        };
        var webuploaderoptions = $.extend({
            swf: "/include/uploads/Uploader.swf",
            server: opts.server,
            pick: "#" + pickerid,
            resize: false,
            accept: opts.accept,
            fileNumLimit: opts.fileNumLimit,
            fileSizeLimit: opts.fileSizeLimit,
            fileSingleSizeLimit: opts.fileSingleSizeLimit
        },
        opts.innerOptions);
        var uploader = WebUploader.create(webuploaderoptions);
        var fileDataStr = hdFileData.val();
        if (fileDataStr && opts.PostbackHold) {
            jsonData = JSON.parse(fileDataStr);
            $.each(jsonData.fileList,
            function(index, fileData) {
                var newid = SuiJiNum();
                fileData.queueId = newid;
                $list.append('<div id="' + newid + '" class="item">' + '<div class="info">' + fileData.name + "</div>" + '<div class="state">已上传</div>' + '<div class="del"></div>' + "</div>")
            });
            hdFileData.val(JSON.stringify(jsonData))
        }
        if (opts.auto) {
            uploader.on("fileQueued",
            function(file) {
                $list.append('<div id="' + $(item)[0].id + file.id + '" class="item">' + '<span class="webuploadinfo">' + file.name + "</span>" + '<span class="webuploadstate">正在上传...</span>' + '<div class="webuploaddelbtn">删除</div> ' + "</div>");
                uploader.upload()
            })
        } else {
            uploader.on("fileQueued",
            function(file) {
                $list.append('<div id="' + $(item)[0].id + file.id + '" class="item">' + '<span class="webuploadinfo">' + file.name + "</span>" + '<span class="webuploadstate">等待上传...</span>' + '<div class="webuploaddelbtn">删除</div> ' + "</div>")
            })
        }
        uploader.on("uploadProgress",
        function(file, percentage) {
            var $li = target.find("#" + $(item)[0].id + file.id),
            $percent = $li.find(".progress .bar");
            if (!$percent.length) {
                $percent = $('<span class="progress">' + '<span  class="percentage"><span class="text"></span>' + '<span class="bar" role="progressbar" style="width: 0%">' + "</span></span>" + "</span>").appendTo($li).find(".bar")
            }
            $li.find("span.webuploadstate").html("上传中");
            $li.find(".text").text(Math.round(percentage * 100) + "%");
            $percent.css("width", percentage * 100 + "%")
        });
        uploader.on("uploadSuccess",
        function(file, response) {
            if (response.code != 0) {
                target.find("#" + $(item)[0].id + file.id).find("span.webuploadstate").html(response.message)
            } else {
                target.find("#" + $(item)[0].id + file.id).find("span.webuploadstate").html("已上传");
				$hiddenInput.append('<input type="text" name="' + $(item)[0].id + '_title" id="hiddenInput_title' + $(item)[0].id + file.id + '_title" class="hiddenInput_title" value="' + file.name + '" />');
                $hiddenInput.append('<input type="text" name="' + $(item)[0].id + '" id="hiddenInput' + $(item)[0].id + file.id + '" class="hiddenInput" value="' + response.data.src + '" />');
            }
        });
        uploader.on("uploadError",
        function(file) {
            target.find("#" + $(item)[0].id + file.id).find("span.webuploadstate").html("上传出错")
        });
        uploader.on("uploadComplete",
        function(file) {
            target.find("#" + $(item)[0].id + file.id).find(".progress").fadeOut()
        });
        uploader.on("all",
        function(type) {
            if (type === "startUpload") {
                state = "uploading"
            } else {
                if (type === "stopUpload") {
                    state = "paused"
                } else {
                    if (type === "uploadFinished") {
                        state = "done"
                    }
                }
            }
            if (state === "uploading") {
                $btn.text("暂停上传")
            } else {
                $btn.text("开始上传")
            }
        });
        uploader.on("fileDequeued",
        function(file) {
            var fullName = $("#hiddenInput" + $(item)[0].id + file.id).val();
            if (fullName != null) {}
            $("#" + $(item)[0].id + file.id).remove();
            $("#hiddenInput" + $(item)[0].id + file.id).remove()
        });
        $btn.on("click",
        function() {
            if (state === "uploading") {
                uploader.stop()
            } else {
                uploader.upload()
            }
        });
        $list.on("click", ".webuploaddelbtn",
        function() {
            var $ele = $(this);
            var id = $ele.parent().attr("id");
            var id = id.replace($(item)[0].id, "");
            var file = uploader.getFile(id);
            uploader.removeFile(file)
        });
        return uploader
    }
    $.fn.GetFilesAddress = function(options) {
        var ele = $(this);
        var filesdata = ele.find(".UploadhiddenInput");
        var filesAddress = [];
        filesdata.find(".hiddenInput").each(function() {
            filesAddress.push($(this).val())
        });
        return filesAddress
    };
    $.fn.powerWebUpload = function(options) {
        var ele = this;
        if (typeof WebUploader == "undefined") {
            var casspath = "/include/uploads/webuploader.css";
            $("<link>").attr({
                rel: "stylesheet",
                type: "text/css",
                href: casspath
            }).appendTo("head");
            var jspath = "/include/uploads/webuploader.min.js";
            $.getScript(jspath).done(function() {
                initWebUpload(ele, options)
            }).fail(function() {
                alert("请检查webuploader的路径是否正确!")
            })
        } else {
            return initWebUpload(ele, options)
        }
    }
})(jQuery, window);