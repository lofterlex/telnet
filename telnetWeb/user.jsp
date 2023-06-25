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
    <h1>用户信息</h1>

    <!-- 新建按钮 -->

    <!-- 读取 -->
    <h2>List      <button type="button" class="btn btn-primary mb-3" data-toggle="modal" data-target="#createModal">新建</button></h2>
    <table class="table">
      <thead>
        <tr>
          <th>#</th>
          <th>名称</th>
          <th>描述</th>
          <th>操作</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>1</td>
          <td>项目1</td>
          <td>这是项目1的描述</td>
          <td>
            <a href="main.jsp" class="btn btn-primary">编辑</a>
            <button type="button" class="btn btn-danger" onclick="openDeleteModal(1)">删除</button>
          </td>
        </tr>
        <!-- 其他数据行 -->
      </tbody>
    </table>

    <!-- 新建弹窗 -->
    <div class="modal fade" id="createModal" tabindex="-1" role="dialog" aria-labelledby="createModalLabel"
      aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="createModalLabel">创建项目</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <form>
              <div class="form-group">
                <label for="create-name">名称</label>
                <input type="text" class="form-control" id="create-name" placeholder="输入名称">
              </div>
              <div class="form-group">
                <label for="create-description">描述</label>
                <textarea class="form-control" id="create-description" placeholder="输入描述"></textarea>
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-primary" onclick="createItem()">创建</button>
            <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
          </div>
        </div>
      </div>
    </div>

    <!-- 删除确认弹窗 -->
    <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel"
      aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="deleteModalLabel">确认删除</h5>
<button type="button" class="close" data-dismiss="modal" aria-label="Close">
<span aria-hidden="true">×</span>
</button>
</div>
<div class="modal-body">
<p>确认删除该项目吗？</p>
</div>
<div class="modal-footer">
<button type="button" class="btn btn-danger" onclick="deleteItem()">删除</button>
<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
</div>
</div>
</div>
</div>

  </div>
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
  <script>
    function openDeleteModal(id) {
      // 根据id显示确认删除弹窗
      $('#deleteModal').modal('show');
    }

    function createItem() {
      // 获取创建表单数据并进行提交逻辑
      // 然后关闭新建弹窗
      $('#createModal').modal('hide');
    }

    function deleteItem() {
      // 进行删除逻辑
      // 然后关闭删除确认弹窗
      $('#deleteModal').modal('hide');
    }
  </script>
</body>
</html>