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
        var curModel = ${config};
        var nodes = ${nodes};

        function init() {
            if (window.goSamples) goSamples();
            var $ = go.GraphObject.make;

            updatePage();

            myDiagram =
                $(go.Diagram, "myDiagramDiv",
                    {
                        initialContentAlignment: go.Spot.Center,
                        "undoManager.isEnabled": true
                    });
            loadFromSave();
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
            myDiagram.isReadOnly = true;
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
    </script>
</head>
<body onload="load()">
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-8" style="height: 100vh;">
            <div id="myDiagramDiv" style="width: 100%; height: 100%; border: solid 1px black;"></div>
        </div>
        <div class="col-xs-4" style="; height: 100vh; ">
            <div class="row" style="height: 100%;">
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
                                                    <button type="button" class="btn btn-primary" id="checkConfigure" data-id="${history.id}">查看配置</button>
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
        </div>
    </div>
</div>
</body>
</html>