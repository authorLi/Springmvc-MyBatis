<%--
  Created by IntelliJ IDEA.
  User: deepin
  Date: 18-11-4
  Time: 上午10:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <!--web路径
    不以/开始的相对路径，找资源，以当前的资源路径基准，经常容易出问题
    以/开始的路径相对路径，找资源，以服务器的路径为标准

    -->

    <title>员工列表</title>
    <!-- -引入JQuery文件-->
    <script type="text/javascript"
            src="${pageContext.request.contextPath }bootstrap/js/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <!-- 引入bootstrap样式-->
    <link href="${pageContext.request.contextPath }bootstrap/bootstrap-3.3.7-dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <script src="${pageContext.request.contextPath }bootstrap/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<!-- 员工修改的模态框-->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input"
                                   placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gende" id="gender1_update_input" value="M" checked="checked">男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gende" id="gender2_update_input" value="F">女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!-- 部门提交部门id即可-->
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
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input"
                                   placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gende" id="gender1_add_input" value="M" checked="checked">男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gende" id="gender2_add_input" value="F">女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!-- 部门提交部门id即可-->
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

<!-- 搭建显示页面-->
<div class="container">
    <!-- 标题行-->
    <div class="row">
        <div class="col-md-12"><h1>SSM-CRUD</h1></div>
    </div>
    <!-- 按钮-->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <!-- 显示表格数据-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_tables">
                <thead>
                <tr>
                    <th><input type="checkbox" id="check_all"></th>
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
    <!-- 显示分页信息-->
    <div class="row">
        <!-- 分页文字信息-->
        <div class="col-md-6" id="page_info_area">

        </div>
        <!-- 分页条信息-->
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<script type="text/javascript">

    var totalRecord,currentPage;

    //1.页面加载完成后直接去发送一个ajax请求，要到分页数据
    $(function () {
        //去首页
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url: "${pageContext.request.contextPath }/emps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                console.log(result);
                //1.在页面解析并显示员工数据
                build_emp_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                //3.显示分页条数据
                build_page_nav(result);
            }
            , error: function (err) {
                console.log("err:" + err);
            }
        });
    }

    function build_emp_table(result) {

        //清空表格数据
        $("#emps_tables tbody").empty();

        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item' /></td>")
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var gendeTd = $("<td></td>").append(item.gende == 'M' ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加一个自定义的属性,来表示当前员工的id
            editBtn.attr("edit_id",item.empId);

            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            //为删除按钮添加一个自定义属性来表示当前删除的员工Id
            delBtn.attr("del_id",item.empId);
            var btnTd = $("<td></td>").append(editBtn).append("     ") .append(delBtn);
            //append方法执行完成后还是返回原来的元素
            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(gendeTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_tables tbody");
        });
    }

    //解析显示分页信息
    function build_page_info(result) {

        //清空分页信息
        $("#page_info_area").empty();

        $("#page_info_area").append("当前第" + result.extend.pageInfo.pageNum
            + " 页，总共" + result.extend.pageInfo.pages + " 页,总共"
            + result.extend.pageInfo.total + " 条记录");
        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }

    //解析显示分页条数据
    function build_page_nav(result) {

        //清空分页条数据
        $("#page_nav_area").empty();

        var ul = $("<ul></ul>").addClass("pagination");

        //构建元素
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            //为元素绑定事件
            firstPageLi.click(function () {
                to_page(1);
            });

            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }

        //构建元素
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href", "#"));
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            //为元素绑定事件
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }

        //添加首页和前一页的提示
        ul.append(firstPageLi).append(prePageLi);

        //遍历给ul中添加页码提示
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        //添加下一页和尾页的提示
        ul.append(nextPageLi).append(lastPageLi);

        //把ul添加到nav标签中
        var navEle = $("<nav></nav>").append(ul);

        //将nav标签应用于标签中
        navEle.appendTo("#page_nav_area")
    }

    //表单的重置方法
    function reset_form(ele) {
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }


    //点击新增按钮弹出模态框
    $("#emp_add_modal_btn").click(function () {

        //清除表单数据(表单完整重置(数据及样式))
        reset_form("#empAddModal form");
        // $("#empAddModal form")[0].reset();
        //发送ajax请求查出部门信息，显示在下拉列表中
        getDEpts("#empAddModal select");

        //弹出模态框
        $("#empAddModal").modal({
            backdrop: "static"
        });
    });

    //查出所有部门信息，显示在部门列表中
    function getDEpts(ele) {
        //清空之前下拉列表的值
        $(ele).empty();

        $.ajax({
            url: "${pageContext.request.contextPath }/depts",
            type: "GET",
            success: function (result) {
                // console.log(result);

                //显示部门信息在下拉列表中
                // $("#dept_add_select").append();
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    $("#emp_save_btn").click(function () {
        //1.模态框中的数据应该提交到服务器进行保存
        //1.先对要提交的数据进行校验
        if (!validate_add_form()) {
            return false;
        }
        //1.判断之前的ajax用户名校验是否成功.成功了才往下走
        if ($(this).attr("ajax_va") == "error") {
            return false;
        }
        //2.发送ajax请求保存员工
        $.ajax({
            url: "${pageContext.request.contextPath }/emp",
            type: "POST",
            data: $("#empAddModal form").serialize(),
            success: function (result) {
                // alert(result.message);
                if (result.code ==  100) {
                    //员工保存成功后应该 1.先关闭增加员工的框，然后
                    $("#empAddModal").modal('hide');
                    // 2.跳到最后一页展示给用户,那就发送ajax请求来显示最后一页的数据即可
                    to_page(totalRecord);
                } else {
                    //失败了，显示失败信息
                    // console.log(result);
                    //有哪个字段的错误信息就显示哪个字段
                    if (result.extend.errorFieldMap.email != undefined) {
                        //显示员工名字的错误信息
                        show_validate_msg("#empName_add_input", "error", result.extend.errorFieldMap.empName);
                    }
                    if (result.extend.errorFieldMap.empName != undefined) {
                        //显示邮箱错误信息
                        show_validate_msg("#email_add_input", "error", result.extend.errorFieldMap.email);
                    }
                }

            }
        });
    });

    //校验提交信息
    function validate_add_form() {
        //1.拿到要校验的信息
        var empName = $("#empName_add_input").val()
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {
            // alert("用户名可以是2-5位中文或者6-16位英文字母下划线短横杠和数字的组合！");
            show_validate_msg("#empName_add_input", "error", "用户名可以是2-5位中文或者6-16位英文字母下划线短横杠和数字的组合！")
            return false;
        } else {
            show_validate_msg("#empName_add_input", "success", "");
        }
        return true;

        //2.校验邮箱信息
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            // alert("邮箱格式不正确");
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
        }
        return true;
    }

    //显示校验的错误信息
    function show_validate_msg(ele, status, msg) {
        //清空这个元素之前的样式
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if (status == "success") {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if (status == "error") {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    $("#empName_add_input").blur(function () {
        //发送ajax请求验证用户名是否重复
        var empName = this.value;
        $.ajax({
            url: "${pageContext.request.contextPath }/checkuser",
            type: "GET",
            data: "empName=" + empName,
            success: function (result) {
                if (result.code == 100) {
                    show_validate_msg("#empName_add_input", "success", "用户名可用");
                    $("#emp_save_btn").attr("ajax_va", "success");
                } else {
                    show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax_va", "error");
                }
            }
        });
    });


    //RestletClient,FeHelper
    $(document).on("click", ".edit_btn", function () {
        // alert("edit");

        //查出部门信息，并显示部门列表
        getDEpts("#empUpdateModal select");

        //查出员工信息，显示员工信息
        getEmp($(this).attr("edit_id"));

        //把员工的id传递给模态框的更新按钮
        $("#emp_update_btn").attr("edit_id",$(this).attr("edit_id"));
        $("#empUpdateModal").modal({
            backdrop: "static"
        });

    });
    
    function getEmp(id) {
        $.ajax({
            url:"${pageContext.request.contextPath }/emp/" + id,
            type:"GET",
            success:function (result) {
                // console.log(result);
                var empEle = result.extend.emp;
                $("#empName_update_static").text(empEle.empName);
                $("#email_update_input").val(empEle.email);
                $("#empUpdateModal input[name=gender]").val([empEle.gender]);
                $("#empUpdateModal select").val([empEle.dId]);
            }
        });
    }


    //点击更新员工信息
    $("#emp_update_btn").click(function () {
        //1.验证邮箱是否合法
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            // alert("邮箱格式不正确");
            show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "");
        }

        //2.发送ajax请求保存员工信息,Tomcat遇到put请求就不会把数据封装了，
        // 所以下面的请求是post并且发送的data后面加了一段_method=put才能完成发送模拟put
        //也可以直接发送put请求，只要在过滤器中配置一个过滤put请求的过滤器HttpPutFormContentFilter即可
        $.ajax({
            url:"${pageContext.request.contextPath }/emp/" + $(this).attr("edit_id"),
            type:"POST",
            data:$("#empUpdateModal form").serialize() + "&_method=PUT",
            success:function (result) {
                // alert(result.message);
                //1.关闭对话框
                $("#empUpdateModal").modal("hide");
                //2.关闭本页面
                to_page(currentPage);
            }
        })
    });

    //单个用户删除
    $(document).on("click",".delete_btn",function () {
        //1.弹出是否确认删除对话框
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("del_id");
        if(confirm("确认删除[" + empName + "]？")){
            //确认，发送ajax请求
            $.ajax({
                url:"${pageContxt.request.contextPath }/emp/" + empId,
                type:"DELETE",
                success:function (result) {
                    alert(result.message);
                    to_page(currentPage);
                }
            })
        }
    })

    //完成全选，全不选
    $("#check_all").click(function () {
        //attr获取checked的是undefined
        //dom原生属性,attr是用来获取自定义属性的值
        //prop用来修改或读取dom原生属性的值
        // alert($(this).prop("checked"));
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    $(document).on("click",".check_item",function () {
        //判断当前页面中的元素是否都被选择，如果都被选择则使全选框也被选中
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked",flag);
    });

    //点击全部删除就批量删除
    $("#emp_delete_all_btn").click(function () {
        var empNames = "";
        var del_idstrs = "";
        $.each($(".check_item:checked"),function () {
           empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
           //组装员工id字符串
            del_idstrs += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });

        //去除empNames多余的,和-
        empNames = empNames.substring(0,empNames.length - 1);
        del_idstrs = del_idstrs.substring(0,del_idstrs.length - 1);
        if(empNames == ""||del_idstrs == ""){
            return ;
        }
        if(confirm("确认删除[" + empNames + "]吗")){
            //发送ajax请求删除
            $.ajax({
                url:"${pageContext.request.contextPath }/emp/" + del_idstrs,
                type:"DELETE",
                success:function (result) {
                    alert(result.message);

                    //回到当前页面
                    to_page(currentPage);
                }
            });
        }
    });
</script>
</body>
</html>
