<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Flowchart</title>
  <meta charset="UTF-8">
  <script src="https://unpkg.com/gojs/release/go.js"></script>
  <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">  
  <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
  <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
		  // 在此处添加保存模型的代码，例如将diagramJson发送到服务器保存
		  console.log(diagramJson);
		}

    function loadFromSave() {
      var diagramJson = document.getElementById("mySavedModel").value;
      myDiagram.model = go.Model.fromJson(diagramJson);
    }
    
  </script>
</head>
<body onload="load()">
    <div id="myPaletteDiv" style="width: 150px; height: 960px; float: left; border: solid 1px black;"></div>
  <div id="myDiagramDiv" style="width: 1200px; height: 960px; float: left; border: solid 1px black;"></div>
  <div id="detail" style="width: 520px; height: 960px; float: left; border: solid 1px black;">
    <div id="detailPanel" style="width: 520px; height: 480px; float: left; border: solid 1px black;">
     <div class="container">
     	<div class="row">
			 <ul class=" nav nav-pills pull-left">
			        <li class="active"><a href="#">操作面板</a></li>
			        <li><a href="#">作业说明</a></li>
			        <li><a href="#">历史记录</a></li>
			 </ul>
		 </div>
	 </div>
      <form class="form-horizontal col-sm-12" role="form">
        <div class="form-group">
          <label class="col-sm-2 control-label">text1</label>
          <div class="col-sm-8">
            <input class="form-control" id="focusedInput1" type="text" value="">
</div>
        </div>
        <div class="form-group">
          <label class="col-sm-2 control-label">text2</label>
          <div class="col-sm-8">
            <input class="form-control" id="focusedInput2" type="text" value="">
          </div>
        </div>
        <div class="form-group">
          <label class="col-sm-2 control-label">text3</label>
          <div class="col-sm-8">
            <input class="form-control" id="focusedInput3" type="text" value="">
          </div>
        </div>
      </form>
    </div>
    <div id="commandPanel" style="width: 520px; height: 480px; float: left; border: solid 1px black;">
      <form role="form">
        <div class="form-group col-sm-11">
          <label for="name">命令行</label>
          <textarea class="form-control" rows="6"></textarea>
        </div>
      </form>
    </div>
  </div>
</body>
</html>