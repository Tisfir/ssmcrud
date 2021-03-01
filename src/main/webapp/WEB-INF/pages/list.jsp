<%--
  Created by IntelliJ IDEA.
  User: liz
  Date: 2021/2/22
  Time: 14:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>员工查询列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
       <%--web路径：--%>
            <%--不以/开始的相对路径，找资源是以当前资源的路径为基准，经常容易出问题--%>
            <%--而以/开始的相对路径，是以服务器的路径为标注的（http://localhost:3306），需要加上项目名--%>
                    <%--http://localhost:3306/crud--%>
    <%--引入jQuery--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery.min.js"></script>
    <%--这里有一个需要注意的地方，就是script书写的时候，必须是上面这种方式--%>
    <%--引入bootstrap样式--%>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
    <!--标题-->
    <div class="row">
        <div class="col-lg-12">
            <h1>SSM_CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_model_btn">增加</button>

<!-- 员工添加的模态框======================================================== -->
            <div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">员工添加</h4>
                        </div>
                        <div class="modal-body">
                            <%--表单的设置============================--%>
                            <form class="form-horizontal">
                                <div class="form-group">  <!--label for指定为那个id输入进来,没有也没事  name对应domain里面的属性还值，进行封装-->
                                    <label  class="col-sm-2 control-label">姓名</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="emp_name" class="form-control" id="emp_name_add_input" placeholder="emp_name">
                                    </div>
                                </div>
                                <div class="form-group">  <!--label for指定为那个id输入进来-->
                                    <label  class="col-sm-2 control-label">电子邮件</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@crud.com">
                                    </div>
                                </div>
                                <div class="form-group">  <!--label for指定为那个id输入进来-->
                                    <label  class="col-sm-2 control-label">性别</label>
                                    <div class="col-sm-10">
                                        <label class="radio-inline">
                                            <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                                        </label>
                                        <label class="radio-inline">
                                            <input type="radio" name="gender" id="gender2_add_input" value="W"> 女
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group">  <!--label for指定为那个id输入进来-->
                                    <label  class="col-sm-2 control-label">部门</label>
                                    <div class="col-sm-5" >
                                        <%--查出来，在构建，部门提交部门ID--%>
                                        <select class="form-control" name="d_id" >
                                            <c:forEach items="${department}" var="dept">
                                                <option value="${dept.dept_id}">${dept.dept_name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </form>
                            <%--表单结束=========================================--%>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                            <button type="submit" class="btn btn-primary">保存</button>
                        </div>
                    </div>
                </div>
            </div>
<%--添加模态框===========================================================--%>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>

    <%--显示表格数据=======================================================--%>
    <div class="row">
        <div class="col-md-12 ">
            <table class="table table-hover">
                <tr>
                    <th>员工ID</th>
                    <th>名称</th>
                    <th>性别</th>
                    <th>email</th>
                    <th>所在部门</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${pageinfo.list}" var="emp">
                    <tr>
                        <th>${emp.emp_id}</th>
                        <th>${emp.emp_name}</th>
                        <th>${emp.gender=="M"?"男":"女"}</th>
                        <th>${emp.email}</th>
                        <th>${emp.department.dept_name }</th>
                        <%--//通过注解的方式，进行的一对一的查询--%>
                        <%--<th>${emp.dept_name}</th> 如果是使用的继承类的方式，则在controller中就用
                        继承类的findAllOfIt方法，然后这里的调用就是直接.属性名称--%>
                        <th>
                            <button class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                增加
                            </button>
                            <button class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                删除</button>
                        </th>
                    </tr>
                </c:forEach>

            </table>
        </div>
    </div>
    <%--显示的表格数据结束====================================%>

    <%--分页数据=====================================================--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6">
            当前${pageinfo.pageNum }页，总${pageinfo.pages }页，总共${pageinfo.total }条记录数
        </div>
        <%--分页条信息--%>
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li><a href="${APP_PATH}/employee/findAll?pn=1">首页</a></li>

                    <c:if test="${pageinfo.hasPreviousPage}">
                        <li>
                            <a href="${APP_PATH}/employee/findAll?pn=${pageinfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>

                    <c:forEach items="${pageinfo.navigatepageNums}" var="page_Num">
                        <%--加一个判断将当前页码做一个高亮显示--%>
                        <c:if test="${page_Num == pageinfo.pageNum}">
                            <li class="active"><a href="#">${page_Num }</a></li>
                        </c:if>
                        <c:if test="${page_Num != pageinfo.pageNum}">
                            <li><a href="${APP_PATH}/employee/findAll?pn=${page_Num}">${page_Num }</a></li>
                        </c:if>
                    </c:forEach>

                    <c:if test="${pageinfo.hasNextPage}">
                        <li>
                            <a href="${APP_PATH}/employee/findAll?pn=${pageinfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>

                    </c:if>
                    <li><a href="${APP_PATH}/employee/findAll?pn=${pageinfo.pages}">末页</a></li>
                </ul>
            </nav>
        </div>
    </div>
    <%--分页数据结束===================================================--%>
</div>
<script type="text/javascript">
    <%--员工增加的弹出框代码，static控制模态框的弹出有背景--%>
    $("#emp_add_model_btn").click(function () {
        $("#empAddModel").modal({
            backdrop:"static"
        });
    });


</script>
</body>
</html>
