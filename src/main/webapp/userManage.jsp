<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html lang="en"> 
<head> 
<meta charset="utf-8" /> 
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /> 
<link rel="stylesheet" href="css/bootstrap.min.css">  
  <script src="js/jquery.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
    <script src="js/echarts.min.js"></script>
<title>学生成绩管理</title>
<style type="text/css"></style>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            display: flex;
            justify-content: space-between;
            width: 90%;
            height: 90%;
            margin-top: 20px;
        }
        .left {
            flex: 1;
            height: 100%;
            margin-right: 20px;
        }
        .right {
            flex: 1;
            height: 100%;
            margin-left: 20px;
        }
        .top {
            width: 100%;
        }
        @media (max-width: 768px) {
            .container {
                flex-direction: column;
            }
            .left, .right {
                margin: 0;
            }
            .top {
                margin-top: 0;
            }
        }
    </style>
</head> 
<body>
<div class="top">
    <nav class="navbar navbar-inverse">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle"
                    data-toggle="collapse"
                    data-target=".navbar-responsive-collapse">
                <span class="sr-only"> </span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        </div>
        <div class="collapse navbar-collapse navbar-responsive-collapse">
            <ul class="nav navbar-nav">
                <li><a href="admin.jsp">任务管理</a></li>
                <li  class="active"><a href="userManage.jsp">成绩管理</a></li>
            </ul>
        </div>
    </nav>
</div>
<div class="container">
    <div class="left">
        <div class="row">
            <div class="col-md-12">
                <h2>成绩管理</h2>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th>学号</th>
                        <th>姓名</th>
                        <th>分数</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>1</td>
                        <td>项目1</td>
                        <td>类别1</td>
                        <td>
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editModal">修改</button>
                            <button type="button" class="btn btn-warning" data-toggle="modal">查看</button>
                        </td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>项目2</td>
                        <td>类别2</td>
                        <td>
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editModal">修改</button>
                            <button type="button" class="btn btn-warning" data-toggle="modal">查看</button>
                        </td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>项目3</td>
                        <td>类别3</td>
                        <td>
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editModal">修改</button>
                            <button type="button" class="btn btn-warning" data-toggle="modal">查看</button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="right">
        <div id="chart" style="width: 600px; height: 400px;"></div>
    </div>
</div>

   <!-- 编辑项目弹窗 -->
   <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
       <div class="modal-dialog" role="document">
           <div class="modal-content">
               <div class="modal-header">
                   <h4 class="modal-title" id="myModalLabel">修改分数</h4>
                   <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
               </div>
               <div class="modal-body">
                   <form>
                       <div class="form-group">
                           <label for="grade">分数</label>
                           <input type="text" class="form-control" id="grade" placeholder="请输入分数">
                       </div>
                   </form>
               </div>
               <div class="modal-footer">
                   <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                   <button type="button" class="btn btn-primary">保存</button>
               </div>
           </div>
       </div>
   </div>

   <script>
       // 模拟学生成绩数据
       const data = [
           { range: '0-59', count: 10 },
           { range: '60-69', count: 20 },
           { range: '70-79', count: 30 },
           { range: '80-89', count: 40 },
           { range: '90-100', count: 50 }
       ];

       // 初始化图表
       const chart = echarts.init(document.getElementById('chart'));

       // 配置项
       const option = {
           title: {
               text: '学生成绩分布'
           },
           tooltip: {},
           xAxis: {
               data: ['0-59', '60-69', '70-79', '80-89', '90-100']
           },
           yAxis: {},
           series: [{
               name: '人数',
               type: 'bar',
               data: data.map(item => item.count)
           }]
       };
       // 使用配置项显示图表
       chart.setOption(option);
   </script>
</body>
</html>