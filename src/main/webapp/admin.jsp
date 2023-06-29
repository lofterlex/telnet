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
    <title>任务管理</title>
    <style type="text/css"></style>
</head>
<body>
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
            <li class="active"><a href="toTask">任务管理</a></li>
            <li><a href="userManage.jsp">用户管理</a></li>
        </ul>
    </div>
</nav>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h2>任务管理
                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addModal">新建任务
                </button>
            </h2>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>任务名称</th>
                    <th>任务详情</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${taskList}" var="task">
                    <tr>
                        <td>${task.name}</td>
                        <td>${task.description}</td>
                        <td>
                            <button type="button" class="btn btn-warning" data-toggle="modal" id="check" data-id="${task.id}">
                                查看
                            </button>
                            <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteModal" data-id="${task.id}">
                                删除
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- 新建项目弹窗 -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">新建任务</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="addTaskForm" method="post" action="/addTask">
                    <div class="form-group">
                        <label for="name">任务名称</label>
                        <input type="text" class="form-control" id="name" placeholder="请输入任务名称">
                    </div>
                    <div class="form-group">
                        <label for="description">任务详情</label>
                        <input type="text" class="form-control" id="description" placeholder="请输入任务详情">
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="submit" class="btn btn-primary">创建</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 编辑项目弹窗 -->
<%--<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">--%>
<%--    <div class="modal-dialog" role="document">--%>
<%--        <div class="modal-content">--%>
<%--            <div class="modal-header">--%>
<%--                <h4 class="modal-title" id="myModalLabel">编辑任务</h4>--%>
<%--                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>--%>
<%--                </button>--%>
<%--            </div>--%>
<%--            <div class="modal-body">--%>
<%--                <form>--%>
<%--                    <div class="form-group">--%>
<%--                        <label for="name">任务名称</label>--%>
<%--                        <input type="text" class="form-control" id="nameU" placeholder="请输入任务名称">--%>
<%--                    </div>--%>
<%--                    <div class="form-group">--%>
<%--                        <label for="category">任务详情</label>--%>
<%--                        <input type="text" class="form-control" id="category" placeholder="请输入任务详情">--%>
<%--                    </div>--%>
<%--                </form>--%>
<%--            </div>--%>
<%--            <div class="modal-footer">--%>
<%--                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>--%>
<%--                <button type="button" class="btn btn-primary">保存</button>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>

<!-- 删除项目弹窗 -->
<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">确认删除</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">×</span></button>
            </div>
            <div class="modal-body">
                <p>确定要删除该任务吗？</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger" id="deleteBtn">删除</button>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $('#addTaskForm').submit(function (event) {
            event.preventDefault(); // 阻止表单默认提交行为
            var name = $('#name').val();
            var description = $('#description').val();
            $.ajax({
                url: '/addTask',
                method: 'POST',
                data: {
                    name: name,
                    description: description,
                },
                success: function (response) {
                    // 处理响应
                    console.log(response);
                    // 关闭弹窗
                    $("#addModal").modal("hide");
                    location.reload();
                },
                error: function (error) {
                    // 处理错误
                    console.log(error);
                }
            });
        });
    });

    $(document).on("click", ".btn-danger", function() {
        var id = $(this).data("id");
        $("#deleteModal").data("id", id);
    });

    $(document).on("click", "#deleteBtn", function() {
        var id = $("#deleteModal").data("id");
        console.log(id);
        $.ajax({
            url: "/deleteTask",
            method: "POST",
            data: {
                id: id // 将数据作为请求参数传递给后端
            },
            success: function(response) {
                // 处理响应
                console.log(response);
                // 关闭弹窗
                $("#deleteModal").modal("hide");
                location.reload();
            },
            error: function(error) {
                // 处理错误
                console.log(error);
            }
        });
    });

    $(document).on("click", "#check", function() {
        var id = $(this).data("id");
        window.location.href = 'toScore?id='+id;
    });
</script>
</body>
</html>