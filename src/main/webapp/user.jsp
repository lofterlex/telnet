<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="css/bootstrap.min.css">  
  <script src="js/jquery.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <title>用户界面</title>
</head>

<body>
<div class="container">
  <div class="row">
    <div class="col-md-12">
      <h2>用户信息  <button type="button" class="btn btn-success" data-toggle="modal" data-target="#myModal">新增用户</button></h2>
    </div>
  </div>
  <div class="row">
    <div class="col-md-12">
      <table class="table table-bordered">
        <thead>
        <tr>
          <th>学工号</th>
          <th>姓名</th>
          <th>用户类别</th>
          <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${map.data}" var="user">
          <tr>
            <td>${user.studentId}</td>
            <td>${user.name}</td>
            <td>${user.type}</td>
            <td>
              <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editModal">编辑</button>
              <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteModal">删除</button>
            </td>
          </tr>
        </c:forEach>
<%--        <tr>--%>
<%--          <td>2</td>--%>
<%--          <td>项目2</td>--%>
<%--          <td>类别2</td>--%>
<%--          <td>--%>
<%--            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editModal">编辑</button>--%>
<%--            <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteModal">删除</button>--%>
<%--          </td>--%>
<%--        </tr>--%>
<%--        <tr>--%>
<%--          <td>3</td>--%>
<%--          <td>项目3</td>--%>
<%--          <td>类别3</td>--%>
<%--          <td>--%>
<%--            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editModal">编辑</button>--%>
<%--            <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteModal">删除</button>--%>
<%--          </td>--%>
<%--        </tr>--%>
        </tbody>
      </table>
    </div>
  </div>
</div>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">新增用户</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
            <label for="user-type">用户类型</label>
            <select class="form-control" id="user-type">
              <option value="0">0-管理员</option>
              <option value="1">1-普通用户</option>
            </select>
          </div>
          <div class="form-group">
            <label for="id">学号</label>
            <input type="text" class="form-control" id="id" placeholder="请输入学工号">
          </div>
          <div class="form-group">
            <label for="name">姓名</label>
            <input type="text" class="form-control" id="name" placeholder="请输入姓名">
          </div>
          <div class="form-group">
            <label for="password">密码</label>
            <input type="password" class="form-control" id="password" placeholder="请输入密码">
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="button" class="btn btn-primary">创建</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">修改用户信息</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
            <label for="id">学号</label>
            <input type="text" class="form-control" id="id" placeholder="请输入学工号">
          </div>
          <div class="form-group">
            <label for="name">姓名</label>
            <input type="text" class="form-control" id="name" placeholder="请输入姓名">
          </div>
          <div class="form-group">
            <label for="password">密码</label>
            <input type="password" class="form-control" id="password" placeholder="请输入密码">
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

<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">确认删除</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">
        <p>确定要删除该用户信息吗？</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="button" class="btn btn-danger">删除</button>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
  $.ajax({
    type: "get",
    url: "/user/list",
    data: {

    },
    dataType: "json",
    success: function (data) {
      console.log(data);
    }
  });
</script>
</body>
</html>