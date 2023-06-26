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
    <div class="col-md-6">
      <h2>表名</h2>
    </div>
    <div class="col-md-6 text-right">
      <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">新建项目</button>
    </div>
  </div>
  <div class="row">
    <div class="col-md-12">
      <table class="table table-bordered">
        <thead>
        <tr>
          <th>id</th>
          <th>名称</th>
          <th>类别</th>
          <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <tr>
          <td>1</td>
          <td>项目1</td>
          <td>类别1</td>
          <td>
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editModal">编辑</button>
            <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteModal">删除</button>
          </td>
        </tr>
        <tr>
          <td>2</td>
          <td>项目2</td>
          <td>类别2</td>
          <td>
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editModal">编辑</button>
            <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteModal">删除</button>
          </td>
        </tr>
        <tr>
          <td>3</td>
          <td>项目3</td>
          <td>类别3</td>
          <td>
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editModal">编辑</button>
            <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteModal">删除</button>
          </td>
        </tr>
        </tbody>
      </table>
    </div>
  </div>
</div>

<!-- 新建项目弹窗 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">新建项目</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
            <label for="name">名称</label>
            <input type="text" class="form-control" id="name" placeholder="请输入名称">
          </div>
          <div class="form-group">
            <label for="category">类别</label>
            <input type="text" class="form-control" id="category" placeholder="请输入类别">
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

<!-- 编辑项目弹窗 -->
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">编辑项目</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
            <label for="name">名称</label>
            <input type="text" class="form-control" id="name" placeholder="请输入名称">
          </div>
          <div class="form-group">
            <label for="category">类别</label>
            <input type="text" class="form-control" id="category" placeholder="请输入类别">
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

<!-- 删除项目弹窗 -->
<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">确认删除</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
      </div>
      <div class="modal-body">
        <p>确定要删除该项目吗？</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="button" class="btn btn-danger">删除</button>
      </div>
    </div>
  </div>
</div>
</body>
</html>