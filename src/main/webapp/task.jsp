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
    <title>任务列表</title>
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
</nav>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h2>任务列表</h2>
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
                                选择
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>

    $(document).on("click", "#check", function() {
        var taskId = $(this).data("id");
        var userId = ${sessionScope.userId};
        var params = '?taskId=' + taskId + '&userId=' + userId;
        window.location.href = 'toMain'+ params;
    });

</script>
</body>
</html>