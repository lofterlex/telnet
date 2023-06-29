<%@page contentType="text/html" %>
<%@page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
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
                <li><a href="toTask">任务管理</a></li>
                <li class="active"><a href="userManage.jsp">成绩管理</a></li>
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
                    <c:forEach items="${scoreList}" var="score">
                        <tr>
                            <td>${score.studentId}</td>
                            <td>${score.name}</td>
                            <td>${score.score}</td>
                            <td>
                                <button type="button" class="btn btn-primary" data-toggle="modal"
                                        data-target="#editModal" data-id="${score}">修改
                                </button>
                                <button type="button" class="btn btn-warning" data-toggle="modal">查看</button>
                            </td>
                        </tr>
                    </c:forEach>
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
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="updateScoreForm" action="/updateScore" method="post">
                    <input type="hidden" id="id">
                    <div class="form-group">
                        <label for="score">分数</label>
                        <input type="text" class="form-control" id="score" placeholder="请输入分数">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="submit" class="btn btn-primary">保存</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    // 模拟学生成绩数据
    let scoreCount = ${scoreCount};
    const data = [
        {range: '0-59', count: scoreCount[0]},
        {range: '60-69', count: scoreCount[1]},
        {range: '70-79', count: scoreCount[2]},
        {range: '80-89', count: scoreCount[3]},
        {range: '90-100', count: scoreCount[4]}
    ];
    console.log(data);
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

    $(document).ready(function() {
        $('#updateScoreForm').submit(function(event) {
            event.preventDefault(); // 阻止表单默认提交行为
            var id = parseInt($('#id').val());
            var score = parseInt($('#score').val());
            $.ajax({
                url: '/updateScore',
                method: 'POST',
                data: {
                    id: id,
                    score: score
                },
                success: function(response) {
                    // 处理响应
                    console.log(response);
                    // 关闭弹窗
                    $("#editModal").modal("hide");
                    location.reload();
                },
                error: function(error) {
                    // 处理错误
                    console.log(error);
                }
            });
        });
    });
</script>
</body>
</html>