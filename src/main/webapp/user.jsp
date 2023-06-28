<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <c:forEach items="${userList}" var="user">
          <tr>
            <td>${user.studentId}</td>
            <td>${user.name}</td>
            <td>${user.type}</td>
            <td>
              <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editModal" data-id="${user}">编辑</button>
              <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteModal" data-id="${user.id}">删除</button>
            </td>
          </tr>
        </c:forEach>
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
        <form id="addUserForm" action="/addUser" method="post">
          <div class="form-group">
            <label for="type">用户类型</label>
            <select class="form-control" id="type">
              <option value="0">0-管理员</option>
              <option value="1" selected>1-普通用户</option>
            </select>
          </div>
          <div class="form-group">
            <label for="studentId">学号</label>
            <input type="text" class="form-control" id="studentId" placeholder="请输入学工号">
          </div>
          <div class="form-group">
            <label for="name">姓名</label>
            <input type="text" class="form-control" id="name" placeholder="请输入姓名">
          </div>
          <div class="form-group">
            <label for="password">密码</label>
            <input type="password" class="form-control" id="password" placeholder="请输入密码">
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            <button type="submit" class="btn btn-primary">创建</button>
          </div>
        </form>
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
        <form id="updateUserForm" action="/updateUser" method="post">
          <input type="hidden" id="idU">
          <input type="hidden" id="typeU">
          <div class="form-group">
            <label for="studentId">学号</label>
            <input type="text" class="form-control" id="studentIdU" placeholder="请输入学工号">
          </div>
          <div class="form-group">
            <label for="name">姓名</label>
            <input type="text" class="form-control" id="nameU" placeholder="请输入姓名">
          </div>
          <div class="form-group">
            <label for="password">密码</label>
            <input type="password" class="form-control" id="passwordU" placeholder="请输入密码">
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
        <button type="button" class="btn btn-danger" id="deleteBtn">删除</button>
      </div>
    </div>
  </div>
</div>
<script>
  $('#editModal').on('shown.bs.modal', function (event) {
    var button = $(event.relatedTarget) // 触发模态框的按钮
    var userStr = button.data('id').toString() // 从按钮中获取user
    var matches = userStr.match(/(\w+)=(\w+)/g);
    var jsonStr = '{' + matches.map(function(match) {
      var parts = match.split('=');
      return '"' + parts[0] + '":"' + parts[1] + '"';
    }).join(',') + '}';
    var user = JSON.parse(jsonStr);
    console.log(user.id);

    document.getElementById('studentIdU').value = user.studentId;
    document.getElementById('nameU').value = user.name;
    document.getElementById('passwordU').value = user.password;
    document.getElementById('typeU').value = user.type;
    document.getElementById('idU').value = user.id;
  })

  $(document).ready(function() {
    $('#updateUserForm').submit(function(event) {
      event.preventDefault(); // 阻止表单默认提交行为
      var studentId = parseInt($('#studentIdU').val());
      var name = $('#nameU').val();
      var password = $('#passwordU').val();
      var id = parseInt($('#idU').val());
      var type = parseInt($('#typeU').val());
      $.ajax({
        url: '/updateUser',
        method: 'POST',
        data: {
          studentId: studentId,
          name: name,
          password: password,
          id: id,
          type: type
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

  $(document).on("click", ".btn-danger", function() {
    var id = $(this).data("id");
    $("#deleteModal").data("id", id);
  });

  $(document).on("click", "#deleteBtn", function() {
    var id = $("#deleteModal").data("id");
    $.ajax({
      url: "/deleteUser",
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

  $(document).ready(function() {
    $('#addUserForm').submit(function(event) {
      event.preventDefault(); // 阻止表单默认提交行为
      var type = parseInt($('#type').val());
      var studentId = parseInt($('#studentId').val());
      var name = $('#name').val();
      var password = $('#password').val();
      $.ajax({
        url: '/addUser',
        method: 'POST',
        data: {
          studentId: studentId,
          name: name,
          password: password,
          type: type,
        },
        success: function(response) {
          // 处理响应
          console.log(response);
          // 关闭弹窗
          $("#myModal").modal("hide");
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