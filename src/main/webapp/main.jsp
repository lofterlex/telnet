<%@page contentType="text/html" %>
<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Flowchart</title>
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
                    case 'help':
                        outputArea.append('<p>Available commands:</p><ul><li>help - show this help message</li><li>date - show current date and time</li></ul>');
                        break;
                    case 'date':
                        outputArea.append('<p>' + new Date().toString() + '</p>');
                        break;
                    default:
                        outputArea.append('<p class="terminal-output-error">Command not found: ' + command + '</p>');
                        break;
                }

                outputArea.scrollTop(outputArea[0].scrollHeight);
            });
        });

        function init() {
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
                            strokeWidth: 1.5
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
                [
                    {key: "router1", category: "router", text: "Router 1", loc: "0 0"},
                    {key: "switch1", category: "switch", text: "Switch 1", loc: "150 0"},
                    {key: "host1", category: "host", text: "Host 1", loc: "300 0"},
                    {key: "host2", category: "host", text: "Host 2", loc: "300 100"}
                ],
                [
                    {from: "router1", to: "switch1"},
                    {from: "switch1", to: "host1"},
                    {from: "switch1", to: "host2"}
                ]
            );

            myDiagram.addModelChangedListener(function (event) {
                if (event.isTransactionFinished) {
                    var model = event.model;
                    var newLink = event.object;
                    if (newLink instanceof go.Link) {
                        var existingLinks = model.linkDataArray;
                        for (var i = 0; i < existingLinks.length; i++) {
                            var existingLink = existingLinks[i];
                            if (existingLink.from === newLink.from && existingLink.to === newLink.to) {
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
                }
            }
        }

        function load() {
            init();
        }

        function save() {
            var diagramJson = myDiagram.model.toJson();
            console.log(diagramJson);
        }

        function loadFromSave() {
            var diagramJson = document.getElementById("mySavedModel").value;
            myDiagram.model = go.Model.fromJson(diagramJson);
        }

        // 监听整个文档的右键单击事件
        document.addEventListener("contextmenu", function (e) {
            // 阻止默认右键菜单
            e.preventDefault();
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
                <div class="col-xs-12" style=" height: 100%; border: solid 1px black;">
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
                                    <form class="form-horizontal">
                                        <!-- 第一行 -->
                                        <div class="form-group">
                                            <label for="select1" class="col-sm-2 control-label">拓扑类型</label>
                                            <div class="col-sm-10">
                                                <select class="form-control" id="select1">
                                                    <option value="option1">Static</option>
                                                    <option value="option2">RIP</option>
                                                    <option value="option3">OSFP</option>
                                                </select>
                                            </div>
                                        </div>

                                        <!-- 第二行 -->
                                        <div class="form-group">
                                            <label for="name21" class="col-sm-1 control-label">Name</label>
                                            <div class="col-sm-3">
                                                <input type="text" class="form-control" id="name21">
                                            </div>
                                            <label for="ip21" class="col-sm-1 control-label">IP</label>
                                            <div class="col-sm-3">
                                                <input type="text" class="form-control" id="ip21">
                                            </div>
                                            <label for="port21" class="col-sm-1 control-label">Port</label>
                                            <div class="col-sm-3">
                                                <input type="text" class="form-control" id="port21">
                                            </div>
                                        </div>
                                        <!-- 第三行 -->
                                        <div class="form-group">
                                            <label for="Command2" class="col-sm-2 control-label">Command</label>
                                            <div class="col-sm-10">
                                                <textarea class="form-control" id="Command2" rows="3"></textarea>
                                            </div>
                                        </div>
                                        <!-- 第四行 -->
                                        <div class="form-group">
                                            <label for="name22" class="col-sm-1 control-label">Name</label>
                                            <div class="col-sm-3">
                                                <input type="text" class="form-control" id="name22">
                                            </div>
                                            <label for="ip22" class="col-sm-1 control-label">IP</label>
                                            <div class="col-sm-3">
                                                <input type="text" class="form-control" id="ip22">
                                            </div>
                                            <label for="port22" class="col-sm-1 control-label">Port</label>
                                            <div class="col-sm-3">
                                                <input type="text" class="form-control" id="port22">
                                            </div>
                                        </div>
                                        <!-- 提交按钮 -->
                                        <div class="form-group">
                                            <div class="col-sm-1"></div>
                                            <div class="col-sm-3">
                                                <button type="submit" class="btn btn-info">上传并运行</button>
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
                                    <h3>作业名</h3>
                                    <p>作业描述</p>
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
                                        <tr>
                                            <td>类型1</td>
                                            <td>80</td>
                                            <td>
                                                <button type="button" class="btn btn-primary">查看配置</button>
                                                <button type="button" class="btn btn-default">跳转</button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>类型2</td>
                                            <td>90</td>
                                            <td>
                                                <button type="button" class="btn btn-primary">查看配置</button>
                                                <button type="button" class="btn btn-default">跳转</button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>类型3</td>
                                            <td>70</td>
                                            <td>
                                                <button type="button" class="btn btn-primary">查看配置</button>
                                                <button type="button" class="btn btn-default">跳转</button>
                                            </td>
                                        </tr>
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
                                        <span class="input-group-text">></span>
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
                            <form>
                                <!-- 输入框 -->
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
                            <form>
                                <!-- 输入框 -->
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
                            <form>
                                <!-- 输入框 -->
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
</body>
</html>