<%@page contentType="text/html" %>
<%@page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>拓扑详情</title>
    <meta charset="UTF-8">
    <script src="js/go.js"></script>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <style>
        .terminal {
            background-color: #000;
            color: #fff;
            font-family: monospace;
            height: 100%;
            overflow-y: scroll;
            padding: 10px;
        }

        .terminal-header {
            border-bottom: 1px solid #fff;
            margin-bottom: 10px;
            padding-bottom: 5px;
        }

        .terminal-header-text {
            font-size: 18px;
        }

        .terminal-input-form {
            margin-top: 10px;
        }

        .terminal-input {
            background-color: transparent;
            border: none;
            color: #fff;
            font-family: monospace;
            font-size: 16px;
            outline: none;
        }

        .terminal-input:focus {
            box-shadow: none;
        }

        .terminal-output {
            margin-bottom: 10px;
        }

        .terminal-output p {
            margin: 0;
        }

        .terminal-output-command {
            color: #0f0;
        }

        .terminal-output-error {
            color: #f00;
        }
    </style>
    <script id="code">
        var curModel = { "class": "GraphLinksModel",
            "nodeDataArray": [],
            "linkDataArray": []};
        var nodes = [];
        let taskId = ${taskDesc.id};
        let userId = ${userId};
        $(function () {
            // 获取输入表单和输出区域
            var inputForm = $('.terminal-input-form');
            var outputArea = $('.terminal-output');
            inputForm.submit(function (event) {
                event.preventDefault();
                var command = $('.terminal-input').val();
                $('.terminal-input').val('');

                // 将命令添加到输出区域中
                outputArea.append('<p><span class="terminal-output-command">$ ' + command + '</span></p>');

                switch (command) {
                    case 'enable':
                        document.getElementById("command").innerHTML = 'Router#';
                        break;
                    case 'hostname R1':
                        document.getElementById("command").innerHTML = 'R1(config)#';
                        outputArea.append('<p></p>');
                        break;
                    case 'configure terminal':
                        outputArea.append('<p>Enter configuration commands, one per line.</p><p>End with CNTL/Z.</p>');
                        document.getElementById("command").innerHTML = 'Router(config)#';
                        break;
                    case 'interface g0/0':
                        document.getElementById("command").innerHTML = 'R1(config-if)#';
                        break;
                    case 'exit':
                        document.getElementById("command").innerHTML = 'R1(config)#';
                        break;
                    default:
                        outputArea.append('<p></p>');
                        break;
                }

                outputArea.scrollTop(outputArea[0].scrollHeight);
            });
        });

        function init() {
            document.getElementById("command").innerHTML = "Router>";
            if (window.goSamples) goSamples();
            var $ = go.GraphObject.make;

            myDiagram =
                $(go.Diagram, "myDiagramDiv",
                    {
                        initialContentAlignment: go.Spot.Center,
                        "undoManager.isEnabled": true
                    });

            // Define the Node templates
            myDiagram.nodeTemplateMap.add("router",
                $(go.Node, "Auto",
                    $(go.Shape, "RoundedRectangle",
                        {
                            fill: "lightblue",
                            stroke: "gray",
                            desiredSize: new go.Size(80, 40),
                            portId: "",
                            fromLinkable: true,
                            toLinkable: true,
                            cursor: "pointer"
                        }),
                    $(go.TextBlock,
                        {
                            margin: 8,
                            editable: true,
                            text: "Router",
                            textAlign: "center",
                            font: "bold 12px sans-serif"
                        },
                        new go.Binding("text").makeTwoWay()),
                    {
                        // 添加右键点击事件
                        contextMenu: $(go.Adornment),
                        contextClick: function (e, obj) {
                            showContextMenu(e, obj.part);
                        }
                    }
                ));

            myDiagram.nodeTemplateMap.add("switch",
                $(go.Node, "Auto",
                    $(go.Shape, "Rectangle",
                        {
                            fill: "lightgreen",
                            stroke: "gray",
                            desiredSize: new go.Size(80, 40),
                            portId: "",
                            fromLinkable: true,
                            toLinkable: true,
                            cursor: "pointer"
                        }),
                    $(go.TextBlock,
                        {
                            margin: 8,
                            editable: true,
                            text: "Switch",
                            textAlign: "center",
                            font: "bold 12px sans-serif"
                        },
                        new go.Binding("text").makeTwoWay()),
                    {
                        // 添加右键点击事件
                        contextMenu: $(go.Adornment),
                        contextClick: function (e, obj) {
                            showContextMenu(e, obj.part);
                        }
                    }
                ));

            myDiagram.nodeTemplateMap.add("host",
                $(go.Node, "Auto",
                    $(go.Shape, "Circle",
                        {
                            fill: "lightyellow",
                            stroke: "gray",
                            desiredSize: new go.Size(80, 80),
                            portId: "",
                            fromLinkable: true,
                            toLinkable: true,
                            cursor: "pointer"
                        }),
                    $(go.TextBlock,
                        {
                            margin: 8,
                            editable: true,
                            text: "Host",
                            textAlign: "center",
                            font: "bold 12px sans-serif"
                        },
                        new go.Binding("text").makeTwoWay()),
                    {
                        // 添加右键点击事件
                        contextMenu: $(go.Adornment),
                        contextClick: function (e, obj) {
                            showContextMenu(e, obj.part);
                        }
                    }
                ));

            // Define the Link template
            myDiagram.linkTemplate =
                $(go.Link,
                    $(go.Shape,
                        {
                            stroke: "gray",
                            strokeWidth: 1.0
                        })
                );

            // Create the palette
            myPalette =
                $(go.Palette, "myPaletteDiv",
                    {
                        nodeTemplateMap: myDiagram.nodeTemplateMap,
                        layout: $(go.GridLayout)
                    });

            // Add nodes to the palette
            myPalette.model.nodeDataArray = [
                {category: "router"},
                {category: "switch"},
                {category: "host"}
            ];

            // Model data
            myDiagram.model = new go.GraphLinksModel(
                curModel.nodeDataArray,
                curModel.linkDataArray
            );
            myDiagram.addModelChangedListener(function (event) {
                if (event.isTransactionFinished) {
                    var model = event.model;
                    var newLink = event.object;
                    if (newLink instanceof go.Link) {
                        var existingLinks = model.linkDataArray;
                        for (var i = 0; i < existingLinks.length; i++) {
                            var existingLink = existingLinks[i];
                            if ((existingLink.from === newLink.from && existingLink.to === newLink.to)
                                || (existingLink.from === newLink.to && existingLink.to === newLink.from)) {
                                // 新链接与已有链接起点和终点相同，说明存在重复边
                                alert("存在重复边");
                                // 可以选择取消添加新链接或者删除已有的重复链接
                                model.removeLinkData(existingLink);
                                break;
                            }
                        }
                    }
                    save();
                }
            });
        }

        function showContextMenu(e, obj) {
            // Retrieve the event object
            if (!e) e = window.event;

            // Cancel the default right-click menu
            if (e.preventDefault) e.preventDefault();
            e.returnValue = false;

            // Determine whether the clicked object is a node or the diagram
            var node = obj.part;
            if (node instanceof go.Node) {
                // Get the node data
                var data = node.data;
                // Get the configuration window element based on the node's category
                var configWindow = document.getElementById(data.category + "ConfigWindow");

                if (configWindow) {
                    // Show the configuration window (using Bootstrap modal)
                    $(configWindow).modal('show');
                    var inputField = document.getElementById(data.category.charAt(0) + "Id");
                    if (inputField) {
                        inputField.value = data.key;
                    }
                }
            }
        }

        function load() {
            init();
        }

        function save() {
            var diagramJson = myDiagram.model.toJson();
            console.log(diagramJson);
            curModel = diagramJson;
        }

        function loadFromSave() {
            myDiagram.model = go.Model.fromJson(curModel);
        }

        // 监听整个文档的右键单击事件
        document.addEventListener("contextmenu", function (e) {
            // 阻止默认右键菜单
            e.preventDefault();
        });

        $(document).ready(function () {
            $('#addNodeH').submit(function (event) {
                event.preventDefault();
                var id = $('#hId').val();
                var ip = $('#hIp').val();
                var port = $('#hPort').val();
                var name = $('#hName').val();
                console.log(myDiagram.model.nodeDataArray.length);
                nodes.push({'port':port, 'ip': ip, 'name': name, 'key': id, type: 2});
                updatePage();
                console.log(nodes.length);
                for(var i = 0;i < myDiagram.model.nodeDataArray.length;i++){
                    if(myDiagram.model.nodeDataArray[i].key == id){
                        let temp = myDiagram.model.nodeDataArray;
                        temp[i].text = name;
                        console.log(temp);
                        myDiagram.model.nodeDataArray = temp;
                        console.log(myDiagram.model.nodeDataArray);
                        save();
                        loadFromSave();
                        break;
                    }
                }
                $("#hostConfigWindow").modal("hide");
            })
        });

        $(document).ready(function () {
            $('#addNodeS').submit(function (event) {
                event.preventDefault();
                var id = $('#sId').val();
                var ip = $('#sIp').val();
                var port = $('#sPort').val();
                var name = $('#sName').val();
                console.log(myDiagram.model.nodeDataArray.length);
                nodes.push({'port':port, 'ip': ip, 'name': name, 'key': id, 'type': 1});
                updatePage();
                console.log(nodes.length);
                for(var i = 0;i < myDiagram.model.nodeDataArray.length;i++){
                    if(myDiagram.model.nodeDataArray[i].key == id){
                        let temp = myDiagram.model.nodeDataArray;
                        temp[i].text = name;
                        console.log(temp);
                        myDiagram.model.nodeDataArray = temp;
                        console.log(myDiagram.model.nodeDataArray);
                        save();
                        loadFromSave();
                        break;
                    }
                }
                $("#switchConfigWindow").modal("hide");
            })
        });

        $(document).ready(function () {
            $('#addNodeR').submit(function (event) {
                event.preventDefault();
                var id = $('#rId').val();
                var ip = $('#rIp').val();
                var port = $('#rPort').val();
                var name = $('#rName').val();
                console.log(myDiagram.model.nodeDataArray.length);
                nodes.push({'port':port, 'ip': ip, 'name': name, 'key': id, 'type': 0});
                updatePage();
                console.log(nodes.length);
                for(var i = 0;i < myDiagram.model.nodeDataArray.length;i++){
                    if(myDiagram.model.nodeDataArray[i].key == id){
                        let temp = myDiagram.model.nodeDataArray;
                        temp[i].text = name;
                        console.log(temp);
                        myDiagram.model.nodeDataArray = temp;
                        console.log(myDiagram.model.nodeDataArray);
                        save();
                        loadFromSave();
                        break;
                    }
                }
                $("#routerConfigWindow").modal("hide");
            })
        });

        function updatePage() {
            // 获取用于显示数据的容器
            var nodeContainer = document.getElementById("nodeContainer");
            // 清空容器中的内容
            nodeContainer.innerHTML = "";
            // 遍历新数据，将其添加到容器中
            console.log(nodes);
            for (var i = 0; i < nodes.length; i++) {
                var node = nodes[i];
                console.log(node);
                var html = '<div class="form-group">' +
                    '<label for="name" class="col-sm-1 control-label">Name</label>' +
                    '<div class="col-sm-3">' +
                    '<input type="text" class="form-control" id="name" disabled="disabled" value="' + node.name + '">' +
                    '</div>' +
                    '<label for="ip" class="col-sm-1 control-label">IP</label>' +
                    '<div class="col-sm-3">' +
                    '<input type="text" class="form-control" id="ip" disabled="disabled" value="' + node.ip + '">' +
                    '</div>' +
                    '<label for="port" class="col-sm-1 control-label">Port</label>' +
                    '<div class="col-sm-3">' +
                    '<input type="text" class="form-control" id="port" disabled="disabled" value="' + node.port + '">' +
                    '</div>' +
                    '</div>';
                nodeContainer.innerHTML += html;
            }
        }

        $(document).ready(function () {
            $('#addTopology').submit(function (event) {
                var type = parseInt($('#select1').val());
                console.log(nodes);
                $.ajax({
                    url: "/addTopology",
                    method: "POST",
                    contentType: 'application/json',
                    data: JSON.stringify({
                        type: type,
                        taskId: taskId,
                        userId: userId,
                        nodes: nodes,
                        config: JSON.parse(curModel)
                    }),
                    success: function (response) {
                        // 处理响应
                        $('#alert').fadeIn();
                        setTimeout(function() {
                            $('#alert').fadeOut();
                        }, 3000);
                        window.location.href = 'toUserTask';
                    },
                    error: function (error) {
                        console.log(this.data);
                        // 处理错误
                        console.log(error);
                    }
                });
            })
        });
    </script>
</head>
<body onload="load()">
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-1" style="height: 100vh;">
            <div id="myPaletteDiv" style="width: 100%; height: 100%; border: solid 1px black;"></div>
        </div>
        <div class="col-xs-7" style="height: 100vh;">
            <div id="myDiagramDiv" style="width: 100%; height: 100%; border: solid 1px black;"></div>
        </div>
        <div class="col-xs-4" style="; height: 100vh; ">
            <div class="row" style="height: 60%;">
                <div class="col-xs-12" style=" height: 100%; border: solid 1px black; overflow:auto;">
                    <div class="panel-group" id="accordion">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <a data-toggle="collapse" data-parent="#accordion"
                                       href="#collapseOne">
                                        <h5>操作面板</h5>
                                    </a>
                                </h4>
                            </div>
                            <div id="collapseOne" class="panel-collapse collapse in">
                                <div class="panel-body">
                                    <form class="form-horizontal" id="addTopology">
                                        <!-- 第一行 -->
                                        <div class="form-group">
                                            <label for="select1" class="col-sm-2 control-label">拓扑类型</label>
                                            <div class="col-sm-10">
                                                <select class="form-control" id="select1">
                                                    <option value="0" selected>Static</option>
                                                    <option value="1">RIP</option>
                                                    <option value="2">OSFP</option>
                                                </select>
                                            </div>
                                        </div>

                                        <!-- 第二行 -->
                                        <div id="nodeContainer">
<%--                                                <div class="form-group">--%>
<%--                                                    <label for="name" class="col-sm-1 control-label">Name</label>--%>
<%--                                                    <div class="col-sm-3">--%>
<%--                                                        <input type="text" class="form-control" id="name" disabled="disabled" value="${node.name}">--%>
<%--                                                    </div>--%>
<%--                                                    <label for="ip" class="col-sm-1 control-label">IP</label>--%>
<%--                                                    <div class="col-sm-3">--%>
<%--                                                        <input type="text" class="form-control" id="ip" disabled="disabled" value="${node.ip}">--%>
<%--                                                    </div>--%>
<%--                                                    <label for="port" class="col-sm-1 control-label">Port</label>--%>
<%--                                                    <div class="col-sm-3">--%>
<%--                                                        <input type="text" class="form-control" id="port" disabled="disabled" value="${node.port}">--%>
<%--                                                    </div>--%>
<%--                                                </div>--%>
                                        </div>
                                        <!-- 提交按钮 -->
                                        <div class="form-group">
                                            <div class="col-sm-1"></div>
                                            <div class="col-sm-3">
                                                <button type="button" class="btn btn-info">上传并运行</button>
                                            </div>
                                            <div class="col-sm-6">
                                                <button type="submit" class="btn btn-info">提交</button>
                                            </div>
                                            <div class="col-sm-2"></div>
                                        </div>
                                    </form>

                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <a data-toggle="collapse" data-parent="#accordion"
                                       href="#collapseTwo">
                                        <h5>作业说明</h5>
                                    </a>
                                </h4>
                            </div>
                            <div id="collapseTwo" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <h3>${taskDesc.name}</h3>
                                    <p>${taskDesc.description}</p>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <a data-toggle="collapse" data-parent="#accordion"
                                       href="#collapseThree">
                                        <h5>历史记录</h5>
                                    </a>
                                </h4>
                            </div>
                            <div id="collapseThree" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <table class="table table-bordered">
                                        <thead>
                                        <tr>
                                            <th>类型</th>
                                            <th>分数</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${historyList}" var="history">
                                            <tr>
                                                <td>
                                                    <c:if test="${history.type=='0'}">
                                                        <c:out value="STATIC"/>
                                                    </c:if>
                                                    <c:if test="${history.type=='1'}">
                                                        <c:out value="RIP"/>
                                                    </c:if>
                                                    <c:if test="${history.type=='2'}">
                                                        <c:out value="OSPF"/>
                                                    </c:if>
                                                </td>
                                                <td>${history.score}</td>
                                                <td>
                                                    <button type="button" class="btn btn-primary">查看配置</button>
                                                    <button type="button" class="btn btn-default">跳转</button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row" style="height: 40%;">
                <div class="col-xs-12" style=" height: 100%; border: solid 1px black;">
                    <div class="terminal">
                        <div class="terminal-header">
                            <span class="terminal-header-text">命令行</span>
                        </div>
                        <div class="terminal-body">
                            <div class="terminal-output">
                                <p>请输入命令来选择路由，例如：Router RouterA</p>
                            </div>
                            <form class="terminal-input-form">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" id="command"></span>
                                        <input type="text" class="form-control terminal-input"
                                               placeholder="Type command here...">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div id="routerConfigWindow" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <!-- 配置窗口内容 -->
                        <div class="modal-body">
                            <h4>Router 配置</h4>
                            <form id="addNodeR">
                                <!-- 输入框 -->
                                <input type="hidden" id="rId">
                                <div class="form-group">
                                    <h4>Name <input type="text" class="form-control" id="rName"></h4>
                                </div>
                                <div class="form-group">
                                    <h4>IP <input type="text" class="form-control" id="rIp"></h4>
                                </div>
                                <div class="form-group">
                                    <h4>Port <input type="text" class="form-control" id="rPort"></h4>
                                </div>
                                <!-- 提交按钮 -->
                                <button type="submit" class="btn btn-info">保存</button>
                                <!-- 取消按钮 -->
                                <button type="button" class="btn btn-danger" data-dismiss="modal">取消</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Switch 配置窗口 -->
            <div id="switchConfigWindow" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <!-- 配置窗口内容 -->
                        <div class="modal-body">
                            <h4>Switch 配置</h4>
                            <form id="addNodeS">
                                <!-- 输入框 -->
                                <input type="hidden" id="sId">
                                <div class="form-group">
                                    <h4>Name <input type="text" class="form-control" id="sName"></h4>
                                </div>
                                <div class="form-group">
                                    <h4>IP <input type="text" class="form-control" id="sIp"></h4>
                                </div>
                                <div class="form-group">
                                    <h4>Port <input type="text" class="form-control" id="sPort"></h4>
                                </div>
                                <!-- 提交按钮 -->
                                <button type="submit" class="btn btn-info">保存</button>
                                <!-- 取消按钮 -->
                                <button type="button" class="btn btn-danger" data-dismiss="modal">取消</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div id="hostConfigWindow" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <!-- 配置窗口内容 -->
                        <div class="modal-body">
                            <h4>Host 配置</h4>
                            <form id="addNodeH">
                                <!-- 输入框 -->
                                <input type="hidden" id="hId">
                                <div class="form-group">
                                    <h4>Name <input type="text" class="form-control" id="hName"></h4>
                                </div>
                                <div class="form-group">
                                    <h4>IP <input type="text" class="form-control" id="hIp"></h4>
                                </div>
                                <div class="form-group">
                                    <h4>Port <input type="text" class="form-control" id="hPort"></h4>
                                </div>
                                <!-- 提交按钮 -->
                                <button type="submit" class="btn btn-info">保存</button>
                                <!-- 取消按钮 -->
                                <button type="button" class="btn btn-danger" data-dismiss="modal">取消</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="alert" class="alert alert-success" style="display:none;">
    保存成功！
</div>
</body>
</html>