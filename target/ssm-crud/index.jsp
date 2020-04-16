<%--
  Created by IntelliJ IDEA.
  User: Shinelon
  Date: 2020/4/14
  Time: 19:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>
<html>
    <head>
        <%
            pageContext.setAttribute("APP_PATH", request.getContextPath());  //request.getContextPath()，以/开始，结尾无/
        %>
        <!--Web路径问题
        不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
        以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)：需要加上项目名
                    http://localhost:3306/crud
        -->
        <!--引入jquery-->
        <script src="${APP_PATH}/static/js/jquery-3.4.1.js"></script>
        <!--引入样式-->
        <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
        <title>员工列表</title>
    </head>
    <body>

    <!-- 员工修改的模态框 -->
    <div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">员工修改</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <p class="form-control-static" id="empName_update_static"></p>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="email_add_input" class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@atguigu.com">
                                <span  class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="email_add_input" class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="email_add_input" class="col-sm-2 control-label">deptName</label>
                            <div class="col-sm-4">
                                <!--部门提交部门id即可-->
                                <select class="form-control" name="dId" id="dept_update_select">

                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
                </div>
            </div>
        </div>
    </div>

        <!-- 员工添加的模态框 -->
        <div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal">
                            <div class="form-group">
                                <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                                <div class="col-sm-10">
                                    <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                                    <span  class="help-block"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="email_add_input" class="col-sm-2 control-label">email</label>
                                <div class="col-sm-10">
                                    <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@atguigu.com">
                                    <span  class="help-block"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="email_add_input" class="col-sm-2 control-label">gender</label>
                                <div class="col-sm-10">
                                    <label class="radio-inline">
                                        <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                                    </label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="email_add_input" class="col-sm-2 control-label">deptName</label>
                                <div class="col-sm-4">
                                    <!--部门提交部门id即可-->
                                    <select class="form-control" name="dId" id="dept_add_select">

                                    </select>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
                    </div>
                </div>
            </div>
        </div>

        <!--搭建显示页面-->
        <div class="container">
            <!--标题-->
            <div class="row">
                <div class="col-md-12">
                    <h1>SSM-CRUD</h1>
                </div>
            </div>
            <!--按钮-->
            <div class="row">
                <div class="col-md-4 col-md-offset-10">
                    <button class="btn btn-success" id="emp_add_modal_btn">新增</button>
                    <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
                </div>
            </div>
            <!--显示表格数据-->
            <div class="row">
                <div class="col-md-12">
                    <table class="table table-hover table-bordered" id="emps_table">
                        <thead>
                            <tr>
                                <th>
                                    <input type="checkbox" id="check_all"/>
                                </th>
                                <th>#</th>
                                <th>empName</th>
                                <th>gender</th>
                                <th>email</th>
                                <th>deptName</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>

                        </tbody>
                    </table>
                </div>
            </div>
            <!--显示分页信息-->
            <div class="row">
                <!--分页文字信息-->
                <div class="col-md-6" id="page_info_area">

                </div>
                <!--分页条-->
                <div class="col-md-6" id="page_nav_area">

                </div>
            </div>
        </div>
        <script type="text/javascript">
            var totalRecord;
            var currentPage;
            <%--页面加载完成后，发起ajax请求，获取json数据--%>

            //1、页面加载完成以后，直接去发送一个ajax请求，要到分页数据
            $(function () {
                to_page(1);
            });

            function to_page(pn) {
                $.ajax({
                    url:"${APP_PATH}/emps",
                    data:"pn="+pn,
                    type:"GET",
                    success:function (result) {
                        //console.log(result);
                        //1、解析并显示员工数据
                        build_emps_table(result);
                        //2、解析并显示分页信息
                        build_page_info(result);
                        //3、解析显示分页条信息
                        build_page_nav(result);
                    }
                });
            }

            //解析并显示员工数据
            function build_emps_table(result) {
                //清空table表格
                $("#emps_table tbody").empty();
                var emps = result.extend.pageInfo.list;
                $.each(emps,function (index,item) {
                    var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>")
                    var empIdTd = $("<td></td>").append(item.empId);
                    var empNameTd = $("<td></td>").append(item.empName);
                    var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
                    var emailTd = $("<td></td>").append(item.email);
                    var deptNameTd = $("<td></td>").append(item.department.deptName);
                    var editBtn = $("<button></button>").addClass("btn btn_primary btn-sm edit_btn")
                                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
                    //为编辑按钮添加一个自定义的属性，表示当前员工的id
                    editBtn.attr("edit-id",item.empId);
                    var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                    //为删除按钮添加一个自定义的属性，表示当前员工的id
                    delBtn.attr("del-id",item.empId)
                    var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                    $("<tr></tr>").append(checkBoxTd).append(empIdTd)
                                    .append(empNameTd)
                                    .append(genderTd)
                                    .append(emailTd)
                                    .append(deptNameTd)
                                    .append(btnTd)
                                    .appendTo("#emps_table tbody");
                })
            }
            //解析显示分页信息
            function build_page_info(result) {
                $("#page_info_area").empty();
                $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页,总共"+
                    result.extend.pageInfo.pages+"页，共"+
                    result.extend.pageInfo.total+"条记录");
                totalRecord = result.extend.pageInfo.total;
                currentPage = result.extend.pageInfo.pageNum;
            }
            //解析并显示分页条
            function build_page_nav(result) {
                //page_nav_area
                $("#page_nav_area").empty();
                var pageInfo = result.extend.pageInfo;
                // 每个导航数字 1 2 3都在li标签里面，所有li在一个ul里面，ul在nav里面
                var ul = $("<ul></ul>").addClass("pagination");
                var nav = $("<nav></nav>").attr("aria-label","Page navigation");
                var firstLi = $("<li></li>").append($("<a></a>").attr("href","#").append("首页"));
                var prevLi = $("<li></li>").append($("<a></a>").attr("href","#").append("&laquo;"));
                // 绑定事件（不在第一页时，点击首页和上一页才发送请求）
                if(pageInfo.hasPreviousPage == false){
                    firstLi.addClass("disabled");
                    prevLi.addClass("disabled")
                }else {
                    firstLi.click(function () {
                        to_page(1);
                    });
                    prevLi.click(function () {
                        to_page(pageInfo.pageNum - 1);
                    });
                }
                ul.append(firstLi).append(prevLi);

                // 遍历此次pageInfo中的导航页，并构建li标签，添加到ul
                $.each(pageInfo.navigatepageNums,function (index,item) {
                    var navLi = $("<li></li>").append($("<a></a>").attr("href","#").append(item));
                    // 遍历到当前显示的页，就高亮，且不能点击
                    if(pageInfo.pageNum == item){
                        navLi.addClass("active");
                    }
                    navLi.click(function () {
                        to_page(item)
                    })
                    ul.append(navLi);
                })

                // 下一页li
                var nextLi = $("<li></li>").append($("<a></a>").attr("href","#").append("&raquo;"));
                // 尾页li
                var lastLi = $("<li></li>").append($("<a></a>").attr("href","#").append("尾页"));
                // 绑定事件（不在最后页时，点击尾页和下一页才发送请求）
                if(pageInfo.hasNextPage == false){
                    nextLi.addClass("disabled");
                    lastLi.addClass("disabled");
                }else{
                    nextLi.click(function () {
                        to_page(pageInfo.pageNum + 1);
                    });
                    lastLi.click(function () {
                        to_page(pageInfo.pages);
                    });
                }
                ul.append(nextLi).append(lastLi);
                // 将ul添加到nav
                nav.append(ul);
                // 将构造好的nav添加到table tbody
                nav.appendTo($("#page_nav_area"));
            }

            //清空表单样式即内容
            function reset_form(ele){
                //清空表单内容
                $(ele)[0].reset();
                //清空表单样式
                $(ele).find("*").removeClass("has-error has-success");
                $(ele).find(".help-block").text("");
            }

            //点击新增按钮弹出模态框
            $("#emp_add_modal_btn").click(function () {
                //清楚表单数据（表单完整重置（表单的数据，表单的样式））
                reset_form("#empAddModal form");
                //$("#empAddModal form")[0].reset();      //取出dom对象，使用reset方法
                //发送ajax请求，查出部门信息，显示在下拉列表中
                getDepts("#empAddModal select");
                //弹出模态框
                $('#empAddModal').modal({
                    backdrop:"static"
                });
            });

            //查出所有的部门信息并显示在下拉列表中
            function getDepts(ele){
                //清空之前下拉列表的值
                $(ele).empty();
                $.ajax({
                    url:"${APP_PATH}/depts",
                    type:"GET",
                    success:function (result) {
                        /**
                         * {"code":100,"msg":"处理成功",
                         * "extend":{"depts":[{"deptId":1,"deptName":"开发部"},{"deptId":2,"deptName":"测试部"}]}}
                         */
                        //console.log(result);
                        // $("#dept_add_select").append("")
                        $.each(result.extend.depts,function () {
                           var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                           optionEle.appendTo(ele);
                        });
                    }
                });
            }

            function validate_add_form(){
                //1、拿到要校验的数据，使用正则表达式
                var empName = $("#empName_add_input").val();
                var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
                if(!regName.test(empName)){
                    //应该清空这个元素之前的样式
                    //alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
                    show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或者6-16位英文和数字的组合");
                    return false;
                }else {
                    show_validate_msg("#empName_add_input","success","");
                }
                var email = $("#email_add_input").val();
                var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                if(!regEmail.test(email)){
                    //alert("邮箱格式不正确");
                    show_validate_msg("#email_add_input","error","邮箱格式不正确")
                    return false;
                }else {
                    show_validate_msg("#email_add_input","success","");
                }
                return true;
            }

            function show_validate_msg(ele,status,msg){
                //清除当前元素的校验
                $(ele).parent().removeClass("has-success has-error");
                $(ele).next("span").text("");
                if("success"==status){
                    $(ele).parent().addClass("has-success");
                    $(ele).next("span").text(msg);
                }else if("error"==status){
                    $(ele).parent().addClass("has-error");
                    $(ele).next("span").text(msg);
                }
            }

            $("#empName_add_input").change(function () {
                //发送ajax请求校验用户名是否可用（与数据库中的是否重复）
                var empName = this.value;
                $.ajax({
                    url:"${APP_PATH}/checkuser",
                    data:"empName="+empName,
                    type:"POST",
                    success:function (result) {
                        if(result.code==100){
                            show_validate_msg("#empName_add_input","success","用户名可用");
                            $("#emp_save_btn").attr("ajax_va","success");
                        }else{
                            show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                            $("#emp_save_btn").attr("ajax_va","error");
                        }
                    }
                })
            });

            //点击保存，保存员工
            $("#emp_save_btn").click(function () {
                //1、模态框中填写的表单数据提交给服务器进行保存
                //1、先对要提交给服务器的数据进行校验
                if(!validate_add_form()){
                    return false;
                };
                //1、判断之前的ajax用户名校验是否成功了。如果成功了。
                if($(this).attr("ajax_va")=="error"){
                    return false;
                }
                //2、发送ajax请求保存员工
                //$("#empAddModal form").serialize();
                $.ajax({
                    url:"${APP_PATH}/emp",
                    method:"POST",
                    data:$("#empAddModal form").serialize(),
                    success:function(result) {
                        //alert(result.msg);
                        if(result.code==100){
                            //员工保存成功：
                            //1、关闭模态框
                            $("#empAddModal").modal('hide');
                            //2、来到最后一页，显示刚才保存的数据
                            //发送ajax请求显示最后一页数据即可
                            to_page(totalRecord);
                        }else {
                            //显示失败信息
                            //console.log(result);
                            //有哪个字段的错误信息就显示哪个字段的
                            if(undefined != result.extend.errorFields.email){
                                //显示邮箱错误信息
                                show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                            }
                            if(undefined != result.extend.errorFields.empName){
                                //显示员工名字的错误信息
                                show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
                            }
                        }
                    }
                })
            });

            //1、如果用.click，按钮创建之前就绑定了click，所以绑定不上
            //1）、可以在创建按钮的时候绑定。  2）、绑定单击.live()
            //jquery新版没有live，使用on替代
            $(document).on("click",".edit_btn",function () {
                //alert("edit");
                //1、查出部门信息，并显示部门列表
                getDepts("#empUpdateModal select");
                //2、查出员工信息，并显示员工信息
                getEmp($(this).attr("edit-id"));
                //3、把员工的id传递给模态框的更新按钮
                $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
                //打开模态框
                $("#empUpdateModal").modal({
                    backdrop:"static"
                });
            });

            function getEmp(id) {
                $.ajax({
                    url:"${APP_PATH}/emp/"+id,
                    type:"GET",
                    success:function (result) {
                        //console.log(result);
                        var empData = result.extend.emp;
                        $("#empName_update_static").text(empData.empName);
                        $("#email_update_input").val(empData.email);
                        $("#empUpdateModal input[name=gender]").val([empData.gender]);
                        $("#empUpdateModal select").val([empData.dId]);
                    }
                });
            }

            //点击更新，更新员工信息
            $("#emp_update_btn").click(function () {
                //1、验证邮箱是否合法
                var email = $("#email_update_input").val();
                var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                if(!regEmail.test(email)){
                    show_validate_msg("#email_update_input","error","邮箱格式不正确")
                    return false;
                }else {
                    show_validate_msg("#email_update_input","success","");
                }
                //2、发送ajax请求保存更新的员工数据
                $.ajax({
                    url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
                    type:"PUT",
                    data:$("#empUpdateModal form").serialize(),
                    success:function (result) {
                        //alert(result.msg);
                        //1、关闭模态框
                        $("#empUpdateModal").modal("hide");
                        to_page(currentPage);
                    }
                });
            });

            /**
             * 单个删除
             */
            $(document).on("click",".delete_btn",function () {
                //1、弹出是否确认删除
                var empName = $(this).parents("tr").find("td:eq(2)").text();
                var empId = $(this).attr("del-id");
                if(confirm("确认删除["+empName+"]吗?")){
                    //确认，发送ajax请求删除即可
                    $.ajax({
                        url:"${APP_PATH}/emp/"+empId,
                        type:"DELETE",
                        success:function (result) {
                            alert(result.msg);
                            //回到本页
                            to_page(currentPage);
                        }
                    });
                }
            })

            //完成全选
            $("#check_all").click(function () {
                //attr获取checked是undefined
                //dom原生的属性用prop，自定义的用attr
                //用prop修改和读取dom原生属性的值
                $(".check_item").prop("checked",$(this).prop("checked"));
            });

            $(document).on("click",".check_item",function () {
                //判断当前选中元素是否为5个
                var flag = $(".check_item:checked").length==$(".check_item").length;
                $("#check_all").prop("checked",flag);
            })

            //点击全部删除，就批量删除
            $("#emp_delete_all_btn").click(function () {
                var empNames = "";
                var del_idstr = "";
                $.each($(".check_item:checked"),function () {
                    empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
                    del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
                })
                //去除emps多余的,
                empNames = empNames.substring(0,empNames.length-1);
                del_idstr = del_idstr.substring(0,del_idstr.length-1);
                if(confirm("确认删除"+empNames+"吗?")){
                    $.ajax({
                        url:"${APP_PATH}/emp/"+del_idstr,
                        type:"DELETE",
                        success:function (result) {
                            alert(result.msg);
                            //回到本页
                            to_page(currentPage);
                        }
                    });
                }
            })

        </script>
    </body>
</html>