<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en"> 
<head> 
<meta charset="utf-8" /> 
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /> 
  <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">  
  <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
  <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>拓扑管理</title> 
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
					<li class="active"><a href="admin.jsp">拓扑管理</a></li>
					<li><a href="userManage.jsp">用户管理</a></li>
			  </ul>
		 </div>	
		 </nav>
		 <h4 align="center">拓扑管理  <button type="button" class="btn btn-primary mb-3" data-toggle="modal" data-target="#createModal">新建</button></h4>
	<table width="1000" align="center" border="1" cellpadding="0" cellspacing="0">
	<tr><td>id</td><td>拓扑名称</td><td>种类</td><td>信息</td><td>编辑</td><td>删除</td></tr>
	<c:forEach items="${tps }" var="tp">
	<tr><td>${tp.mid }</td><td>${tp.mname }</td><td>${tp.getTypename() }</td><td>${tp.showtime }</td><td><a href="Update?id=${tp.id }" class="btn btn-primary">编辑</a></td>
		<td><a href="Delete?id=${tp.id }" class="btn btn-danger">删除</a></td></tr>
	</c:forEach>
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
</body>
</html>