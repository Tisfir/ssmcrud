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

<!-- =========================员工添加的模态框======================================================== -->
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
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">  <!--label for指定为那个id输入进来-->
                        <label  class="col-sm-2 control-label">电子邮件</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@crud.com">
                            <span class="help-block"></span>
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
                            <select class="form-control" name="d_id"  id="depts_add_select">
                            </select>
                        </div>
                    </div>
                </form>
                <%--表单结束=========================================--%>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="submit" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<%--添加模态框===========================================================--%>

<!-- =========================员工编辑的模态框======================================================== -->
<div class="modal fade" id="empUpdateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabe2">员工修改</h4>
            </div>
            <div class="modal-body">
                <%--表单的设置============================--%>
                <form class="form-horizontal">
                    <div class="form-group">  <!--label for指定为那个id输入进来,没有也没事  name对应domain里面的属性还值，进行封装-->
                        <label  class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="emp_update_name">张三</p>
                        </div>
                    </div>
                    <div class="form-group">  <!--label for指定为那个id输入进来-->
                        <label  class="col-sm-2 control-label">电子邮件</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@crud.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">  <!--label for指定为那个id输入进来-->
                        <label  class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="W"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">  <!--label for指定为那个id输入进来-->
                        <label  class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-5" >
                            <%--查出来，在构建，部门提交部门ID--%>
                            <select class="form-control" name="d_id"  id="depts_update_select">
                            </select>
                        </div>
                    </div>
                </form>
                <%--表单结束=========================================--%>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="submit" class="btn btn-primary" id="emp_update_btn">修改</button>
            </div>
        </div>
    </div>
</div>
<%--编辑模态框===========================================================--%>


<div class="container">
    <!--=================================================标题=======================================================-->
    <div class="row">
        <div class="col-lg-12">
            <h1>SSM_CRUD</h1>
        </div>
    </div>
    <%--=====================================================按钮================================================--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_model_btn">增加</button>
            <button class="btn btn-danger" id="emp_del_model_btn">删除</button>
        </div>
    </div>

    <%--=================================================显示表格数据=============================================--%>
    <div class="row">
        <div class="col-md-12 ">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr id="picked">
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>员工ID</th>
                    <th>名称</th>
                    <th>性别</th>
                    <th>email</th>
                    <th>所在部门</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
    <%--==================================================显示的表格数据结束====================================%>

    <%--================================================分页数据==================================================--%>
    <div class="row">
        <%--==========================================分页文字信息==============================================--%>
        <div class="col-md-6" id="build_page_deail">
        </div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav">
        </div>
    </div>
    <%--=================================================分页数据结束==============================================--%>
</div>
<script type="text/javascript">

    <%--=============================1.页面加载完成以后，直接发送一个ajax请求，要到json的数据，直接从页面当中要数据。
    controller返回json数据到页面。然后页面调用json数据进行展示==============================================--%>
  var totalRecord; //保存下来总记录条数
  var currentPage;
    $(function () {
      to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/employee/emps",
            data:"pn="+pn,
            type:"GET",
            success:function (result) {
                $("#check_all").prop("checked",false); //取出上次全选后的状态
                //可以取出之后，检查-network中有pn=1等等内容，解析数据
                // console.log(result);对照json数据的来弄
                //1.解析并显示员工数据
                build_emps_table(result);

                //2.解析并显示分页信息
                build_page_detail(result);

                //调用分页条信息数据
                build_page_nav(result);
                //调用build方法一下

            }
        }); //用ajax请求发送，调取json数据
    }

    //=====================================显示员工的表格数据==================================================
    function build_emps_table(result) {
        //清空table表格，如果不清空，当页面刷新的时候新的数据不会覆盖旧数据，造成页面混乱
        $("#emps_table tbody").empty();
        //获取所有员工数据
        var emps = result.extend.pageinfo.list;
        //遍历员工数据
        $.each(emps, function (index, item) {
            //在员工数据的最左边加上多选框
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.emp_id);
            var empNameTd = $("<td></td>").append(item.emp_name);
            var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.dept_name);
            //编辑按钮
            var editBtn = $("<button></button>").addClass("btn btn-info btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑"));
            //为编辑按钮添加一个自定义的属性，来表示当前员工id,为了获取他的值，方便查询
            editBtn.attr("edit-id", item.emp_id);
            //删除按钮
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash").append("删除"));
            //为删除按钮添加一个自定义的属性，来表示当前员工id
            delBtn.attr("del-id", item.emp_id);
            //把两个按钮放到一个单元格中，并且按钮之间留点空隙
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            //append方法执行完成以后还是会返回原来的元素，所以可以一直.append添加元素，
            //将上面的td添加到同一个tr里
            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");//将tr添加到tbody标签中
        });
    }

    //========================================显示分页信息=========================================================
    function build_page_detail(result) {
        $("#build_page_deail").empty();  //清空数据，否则旧数据会覆盖新数据
        var page =result.extend.pageinfo;
        $("#build_page_deail").append("当前第"+page.pageNum+"页，总"+page.pages+"页，总共"+page.total+"条记录数");
        totalRecord=page.total;
        currentPage=page.pageNum;
    }

    //======================================显示分页条的数据===================================================
    function build_page_nav(result) {
        //清空分页条，如果不清空，当页面刷新的时候新的数据不会覆盖旧数据，造成页面混乱

        $("#page_nav").empty();

        var ul = $("<ul></ul>").addClass("pagination");

        //构建首页和上一页的标签
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));

        //如果没有上一页，就设置首页和上一页的按钮不可用
        if (result.extend.pageinfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {

            //如果有上一页，才绑定单击事件
            //为首页标签添加单击事件
            firstPageLi.click(function () {
                to_page(1);
            });

            //为上一页标签添加单击事件
            prePageLi.click(function () {
                to_page(result.extend.pageinfo.pageNum - 1);
            });
        }

        //下一页和尾页
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href", "#"));

        //如果没有下一页，就设置下一页和尾页按钮不可用
        if (result.extend.pageinfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {

            //如果有下一页，才绑定单击事件
            //为下一页标签添加单击事件
            nextPageLi.click(function () {
                to_page(result.extend.pageinfo.pageNum + 1);
            });

            //为尾页标签添加单击事件
            lastPageLi.click(function () {
                to_page(result.extend.pageinfo.pages);
            });
        }

        //添加首页和前一页到ul标签中
        ul.append(firstPageLi).append(prePageLi);

        //遍历，给ul中添加页码
        $.each(result.extend.pageinfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));

            //绑定单击事件，点击页码进行跳转
            numLi.click(function () {
                to_page(item);
            })

            //当前页数高亮显示
            if (result.extend.pageinfo.pageNum == item) {
                numLi.addClass("active");
            }
            ul.append(numLi);
        })

        //添加下一页和尾页到ul标签中
        ul.append(nextPageLi).append(lastPageLi);

        //把ul添加到nav标签中
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav");
    }



    <%--==========================员工增加的弹出框代码，static控制模态框的弹出有背景,并获取部门信息================================--%>
//清空表单样式的方法
    function reset_form(yuansu){
        $(yuansu)[0].reset();
        $(yuansu).find("*").removeClass("has-success has-error");
        $(yuansu).find(".help-block").text("");
    }
    $("#emp_add_model_btn").click(function () {
//发送ajax请求，查出部门信息，四暗示在下拉列表中
      /*  //清除表单数据（表单重置）,清除父类状态
        $("#empAddModel form")[0].reset();
        $("#emp_name_add_input").parent().removeClass("has-success has-error");
        //提示信息默认为空
        $("#emp_name_add_input").next("span").text("");
        $("#email_add_input").parent().removeClass("has-success has-error");
        $("#email_add_input").next("span").text("");*/
      //以上建立了一个新的清空方法function reset_form();
        reset_form("#empAddModel form");
        getDepts("#depts_add_select");  //获取部门信息

        //弹出模态框
        $("#empAddModel").modal({
            backdrop:"static"
        });
    });
//获取部门信息的方法书写
    function getDepts(dept) {
        //清空下拉菜单信息，如果不清空，当页面刷新的时候新的数据不会覆盖旧数据，造成页面混乱
        $(dept).empty();
        $.ajax({
            url:"${APP_PATH}/dedepartment/dept_findall",
            type:"GET",
            success:function (result) {
                // console.log(result)
                //显示部门信息在下拉列表里
                // $("#depts_add_select").append("<option></option>").app
                $.each(result.extend.depts,function () {
                    var optionEle=$("<option></option>").append(this.dept_name).attr("value",this.dept_id);
                    optionEle.appendTo(dept);
                });
            }
        });
    }



    // ==============================校验表单方法的函数书写=====================================================
    function validate_add_form(){
        //1.拿到要校验的数据，使用增则表达式
        var emp_name=$("#emp_name_add_input").val();
        var regName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
        if( !regName.test(emp_name)){
            //应该清空这个元素之前的一遗留

            // alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
            //用botstrapt的方法进行校验状态的书写
            /*$("#emp_name_add_input").parent().addClass("has-error");//已经添加到父元素，然后在input框下面，书写《span>案例
            $("#emp_name_add_input").next("span").text("用户名可以是2-5位中文或者6-16位英文和数字的组合");*/
            show_validate_msg("#emp_name_add_input", "error", "用户名必须是6-16位数字，字母或者_-，也可以是2-5位中文组成");
            return false;
        }else {
            /*$("#emp_name_add_input").parent().addClass("has-success");
            $("#emp_name_add_input").next("span").text("");*/
            show_validate_msg("#emp_name_add_input", "success", "");
        };
        //2.校验邮箱信息
        var email=$("#email_add_input").val();
        var regemail=/^\w+@[a-zA-Z0-9]{2,10}(?:\.[a-z]{2,4}){1,3}$/;
        if (!regemail.test(email)){
            // show_validate_msg("#email_add_input","error",message);
            // $("#email_add_input").parent().addClass("has-error");//已经添加到父元素，然后在input框下面，书写《span>案例
            // $("#email_add_input").next("span").text("邮箱格式不正确，应如：1580322@163.com");
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确，应如：1580322@163.com");
            return false;
        }else{
            show_validate_msg("#email_add_input", "success", "");

        };
        return true;

    }

    // =========================================这里将校验结果的提示信息全部抽取出来=============================
    function show_validate_msg(ele, status, message) {
        // 当一开始输入不正确的用户名之后，会变红。
        // 但是之后输入了正确的用户名却不会变绿，
        // 因为has-error和has-success状态叠加了。
        // 所以每次校验的时候都要清除当前元素的校验状态。
        $(ele).parent().removeClass("has-success has-error");
        //提示信息默认为空
        $(ele).next("span").text("");
        if("success" == status){
            //如果校验成功
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(message);
        }else if("error" == status){
            //如果校验失败
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(message);
        }
    }


    //=======================================校验邮箱是否可用，是否重复=========================

    $("#email_add_input").change(function () {
        //发送ajax请求，查询邮箱是否可用
        var email = this.value;
        $.ajax({
            url:"${APP_PATH}/employee/checkemail",
            data:"email=" + email,
            type:"POST",
            success:function (result) {
                if(result.code==100){
                    show_validate_msg("#email_add_input", "success", "邮箱可用");
                    $("#emp_save_btn").attr("ajax-value", "success");
                }else{
                    show_validate_msg("#email_add_input", "error",result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-value", "error");
                }

            }
        });
    });
//=================================================保存数据按钮单击事件============================
    $("#emp_save_btn").click(function () {
        //1.将模态框填写的表单数据，提交给服务器进行保存
        //==============================进行校验，确认合法才可以进行保存==========================================
        if(!validate_add_form()){
            return false;
        };
        //检查油箱是否重复，可用
        if($(this).attr("ajax-value")=="error"){
            return false;
        }
        //2.发送ajax请求，保存员工
        $.ajax({
           url:"${APP_PATH}/employee/saveEmployee",
           type:"POST",
           data:$("#empAddModel form ").serialize(),
           success:function(result) {
               // alert(result.message);  页面不出提示信息
               //员工保存成功，
               //==============加了JSR303校验之后，添加这些信息。进行校验，前端校验完之后，此时进行后端校验
               //非法绕过前端之后，后端也能进行校验
               if(result.code==100){
                   $('#empAddModel').modal('hide')
                   //2.来到最后一页，显示刚才保存的数据
                   //发送ajax请求，显示最后一页
                   to_page(totalRecord);
               }else {
                        //校验失败之后就显示失败信息
                   console.log(result);
                   //有哪个字段的错误信息，就显示哪个字段
                   if (undefined !== result.extend.errorField.email) {
                       show_validate_msg("#email_add_input", "error",result.extend.errorField.email);

                       //现实错误信息
                   }
                   if (undefined !== result.extend.errorField.emp_name) {
                       //现实错误信息
                       show_validate_msg("#emp_name_add_input", "error",result.extend.errorField.emp_name);
                   }

               }
               //=========================================
              /* //1.关闭模态框
               $('#empAddModel').modal('hide')
               //2.来到最后一页，显示刚才保存的数据
               //发送ajax请求，显示最后一页
               to_page(totalRecord);*/ //不加JSR303校验数据的之前

           }
        });
    });


    //======================================绑定编辑按钮的单击事件=============================================
    //我们是按钮创建之前就绑定了click,所以绑定不上。
    //解决办法一、可以在创建按钮的时候，绑定事件  二、绑定点击.live()
    //jquery新版没有live，使用on进行替代
    $(document).on("click",".edit_btn",function () {
        // alert("绑定成功");
        //0.查出员工信息，显示员工信息
        //1.查出部门信息，并显示部门列表
        //弹出模态框
        getDepts("#depts_update_select");
        //将ID传递到这个编辑框上面，根据这个传递过去的，进行获取信息
        getEmp($(this).attr("edit-id"));    //这个属性值是从控制台看的。右键--检察元素--eliment（属性值）
        //把员工ID传递到更新按钮上面
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
        // --或者network（console）

        $("#empUpdateModel").modal({
            backdrop:"static"
        });
    });

    //编辑框中查询员工信息，并显示的方法
    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/employee/find/"+id,
            type:"GET",
            success:function (result) {
                // console.log(result);
                var empData=result.extend.emp;
                $("#emp_update_name").text(empData.emp_name);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModel input[name=gender]").val([empData.gender]);
                $("#depts_update_select").val([empData.d_id]);
            }

        });
    }

    //点击更更新，更新员工信息
    $("#emp_update_btn").click(function () {
        //验证邮箱时候是否可用
        var email=$("#email_update_input").val();
        var regemail=/^\w+@[a-zA-Z0-9]{2,10}(?:\.[a-z]{2,4}){1,3}$/;
        if (!regemail.test(email)){
            show_validate_msg("#email_update_input", "error", "邮箱格式不正确，应如：1580322@163.com");
            return false;
        }else{
            show_validate_msg("#email_update_input", "success", "");

        };
    //发送ajax请求，保存更新的员工数据
        $.ajax({
            url:"${APP_PATH}/employee/update/"+$(this).attr("edit-id"),
            type:"PUT",
            data:$("#empUpdateModel form").serialize(),
            success:function (result) {
                // alert(result.message);

                //1.关闭对话框
                $("#empUpdateModel").modal("hide");
                //2.回到页面
                to_page(currentPage);
            }

        });


    });


    //--------------------------------------------员工删除按钮的单击绑定事件--------------------------
    $(document).on("click",".delete_btn",function () {
        //1.弹出确认删除的对话框
        // alert($(this).parents("tr").find("td:eq(2)").text()); //它的祖先节点只有一个tr元素，删除的按钮,找这里面的第二个td
        var emp_name=$(this).parents("tr").find("td:eq(2)").text();
        <%--//2.--%>
        //拿到当前员工的id
        var empId = $(this).attr("del-id");
        //弹出确认框，点击确认就删除
        if(confirm("确认删除 [" + emp_name + "] 吗？")){
            //    确认，发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/employee/del_emp/" + empId,
                type:"DELETE",
                success:function (res) {
                    // alert(res.message);
                    //回到本页
                    to_page(currentPage);
                }
            })
        }
    });

    //--------------------------------设计删除全选框---------------------------------------------------

    $("#check_all").click(function () {
        //   attr获取checked是undefined，因为我们没有定义checked属性，attr获取的是自定义属性值
        //    而我们这些dom原生的属性，可以用prop来获取这些值,$(this).prop("checked")这个是全选按钮的状态
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    //    当本页面所有复选框都选上时，自动将全选复选框选上
    $(document).on("click", ".check_item", function () {
        //判断当前选择中的元素是否是当前页面所有check_item的个数
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked", flag);
    })

    //点击全部删除，就批量删除
    $("#emp_del_model_btn").click(function () {
        var emp_names="";
        var del_idstr="";
        // $(".check_item:checked")  找到每一个没选中的框
        $.each($(".check_item:checked"),function () {
           // alert($(this).parents("tr").find("td:eq(2)").text());
            emp_names+=$(this).parents("tr").find("td:eq(2)").text()+",";
            del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        //取出emps多余的逗号
        empName=emp_names.substring(0,emp_names.length-1);
        //取出多余的员工ID“-”
        del_idstr=del_idstr.substring(0,del_idstr.length-1);

        if (confirm("确认删除【"+empName+del_idstr+"】的信息吗？")){
            //发送ajax请求
            $.ajax({
                url:"${APP_PATH}/employee/delete_emp/"+del_idstr,
                type:"DELETE",
                success:function(result) {
                    alert("删除成功");
                    to_page(currentPage);
            }
            });
        }
    });

</script>
</body>
</html>
