<!DOCTYPE html>
<html>
<head>
  <title>Flowchart</title>
  <meta charset="UTF-8">
  <script src="js/go.js"></script>
  <link rel="stylesheet" href="css/bootstrap.min.css">  
  <script src="js/jquery.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script id="code">
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
            new go.Binding("text").makeTwoWay())
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
            new go.Binding("text").makeTwoWay())
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
            new go.Binding("text").makeTwoWay())
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
        { category: "router" },
        { category: "switch" },
        { category: "host" }
      ];

      // Model data
      myDiagram.model = new go.GraphLinksModel(
        [
          { key: "router1", category: "router", text: "Router 1", loc: "0 0" },
          { key: "switch1", category: "switch", text: "Switch 1", loc: "150 0" },
          { key: "host1", category: "host", text: "Host 1", loc: "300 0" },
          { key: "host2", category: "host", text: "Host 2", loc: "300 100" }
        ],
        [
          { from: "router1", to: "switch1" },
          { from: "switch1", to: "host1" },
          { from: "switch1", to: "host2" }
        ]
      );
      
      myDiagram.addModelChangedListener(function(event) {
		    if (event.isTransactionFinished) {
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
		}

    function loadFromSave() {
      var diagramJson = document.getElementById("mySavedModel").value;
      myDiagram.model = go.Model.fromJson(diagramJson);
    }
    
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
											<h4>操作面板</h4>
										</a>
									</h4>
								</div>
								<div id="collapseOne" class="panel-collapse collapse in">
									<div class="panel-body">
											<form>
							            <!-- 输入框 -->
							            <div class="form-group">
							                <label for="name"><h4>文本</h4></label>
							                <input type="text" class="form-control" id="text1">
							            </div>
							            <div class="form-group">
							                <label for="pwd"><h4>文本</h4></label>
							                <input type="text" class="form-control" id="text2">
							            </div>
							            <!-- 提交按钮 -->
							            <button type="submit" class="btn btn-info">提交</button>
							        </form>
									</div>
								</div>
							</div>
							<div class="panel panel-default">
								<div class="panel-heading">
									<h4 class="panel-title">
										<a data-toggle="collapse" data-parent="#accordion" 
										   href="#collapseTwo">
											<h4>作业说明</h4>
										</a>
									</h4>
								</div>
								<div id="collapseTwo" class="panel-collapse collapse">
									<div class="panel-body">
											<form>
							            <!-- 输入框 -->
							            <div class="form-group">
							                <label for="name"><h4>文本</h4></label>
							                <input type="text" class="form-control" id="text1">
							            </div>
							            <div class="form-group">
							                <label for="pwd"><h4>文本</h4></label>
							                <input type="text" class="form-control" id="text2">
							            </div>
							            <!-- 提交按钮 -->
							            <button type="submit" class="btn btn-info">提交</button>
							        </form>
									</div>
								</div>
							</div>
							<div class="panel panel-default">
								<div class="panel-heading">
									<h4 class="panel-title">
										<a data-toggle="collapse" data-parent="#accordion" 
										   href="#collapseThree">
											<h4>历史记录</h4>
										</a>
									</h4>
								</div>
								<div id="collapseThree" class="panel-collapse collapse">
									<div class="panel-body">
											<form>
							            <!-- 输入框 -->
							            <div class="form-group">
							                <label for="name"><h4>文本</h4></label>
							                <input type="text" class="form-control" id="text1">
							            </div>
							            <div class="form-group">
							                <label for="pwd"><h4>文本</h4></label>
							                <input type="text" class="form-control" id="text2">
							            </div>
							            <!-- 提交按钮 -->
							            <button type="submit" class="btn btn-info">提交</button>
							        </form>
									</div>
								</div>
							</div>
						</div>
          </div>
        </div>
        <div class="row" style="height: 40%;">
          <div class="col-xs-12" style=" height: 100%; border: solid 1px black;">
            <form role="form">
              <div class="form-group col-sm-11">
                <label for="name"><h3>命令行</h3></label>
                <textarea class="form-control" rows="6"></textarea>
                <br/>
                <button type="submit" class="btn btn-info">提交</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>