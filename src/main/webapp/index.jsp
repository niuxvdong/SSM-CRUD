<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--转发方式弃用！--%>
<%--<jsp:forward page="/emps"/>--%>

<html>
<head>
    <title>员工列表</title>

    <!--Jquery-->
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

    <%
        request.setAttribute("ctp", request.getContextPath());
    %>

</head>
<body>

    <!-- Modal-员工添加的模态框 -->
    <div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">员工添加</h4>
                </div>
                <%--表单显示--%>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <%--empName--%>
                        <div class="form-group">
                            <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <%--email--%>
                        <div class="form-group">
                            <label for="email_add_input" class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="email" name="email" class="form-control" id="email_add_input" placeholder="xxx@gmail.com">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <%--gender--%>
                        <div class="form-group">
                            <label for="email_add_input" class="col-sm-2 control-label">gender</label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                        <%--deptName--%>
                        <div class="form-group">
                            <label for="email_add_input" class="col-sm-2 control-label">email</label>
                            <div class="col-sm-4">
                                <%--部门提交id即可--%>
                                <select class="form-control" name="dId"></select>
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

    <!-- Modal-员工修改的模态框 -->
    <div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="">员工修改</h4>
                </div>
                <%--表单显示--%>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <%--empName--%>
                        <div class="form-group">
                            <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <p class="form-control-static" id="empName_update_static"></p>
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <%--email--%>
                        <div class="form-group">
                            <label for="email_add_input" class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="email" name="email" class="form-control" id="email_update_input" placeholder="xxx@gmail.com">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <%--gender--%>
                        <div class="form-group">
                            <label for="email_add_input" class="col-sm-2 control-label">gender</label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="F"> 女
                            </label>
                        </div>
                        <%--deptName--%>
                        <div class="form-group">
                            <label for="email_add_input" class="col-sm-2 control-label">email</label>
                            <div class="col-sm-4">
                                <%--部门提交id即可--%>
                                <select class="form-control" name="dId"></select>
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

    <div class="container">
        <%--标题行--%>
        <div class="row">
            <div class="col-md-12">
                <h1>SSM-CRUD</h1>
            </div>
        </div>
        <%--两个按钮--%>
        <div class="row">
            <%--新增和删除按钮--%>
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-primary" id="emp_add_btn">新增</button>
                <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
            </div>
        </div>
        <%--显示表格数据--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-bordered table-hover" id="emp_table">
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
                    <tbody></tbody>
                </table>
            </div>
        </div>
        <%--显示分页信息--%>
        <div class="row">
            <%--分页文字信息--%>
            <div class="col-md-6" id="page_info_area"></div>
            <%--分页条信息--%>
            <div class="col-md-6" id="page_nav_area"></div>
        </div>
    </div>

    <script type="application/javascript">

        var totalRecord, currentPage;

        // 1. 页面加载完成发起ajax请求，得到分页数据
        $(function (){
            to_page(1);
        });

        // 2. 分页数据展示
        function to_page(p){
            // 切换页面将check_all清空
            $("#check_all").prop("checked", false);

            $.ajax({
                url: "${ctp}/emps",
                data: "p=" + p,
                type: "get",
                success: function (res){
                    // console.log(res);
                    // 解析并显示员工数据
                    build_emps_table(res);
                    // 解析并显示分页信息
                    build_page_info(res);
                    // 解析并显示分页条
                    build_page_nav(res);
                }
            });
        }

        // 2.1 解析并显示员工数据
        function build_emps_table(res){
            // 清空元素
            $("#emp_table tbody").empty();

            var emps = res.extend.pageInfo.list;
            $.each(emps, function (index, item){
                // console.log(item);
                var checkboxTd = $("<td><input type='checkbox' class='check_item'/></td>");
                var empIdTd = $("<td></td>").append(item.empId);
                var empNameTd = $("<td></td>").append(item.empName);
                var genderTd = $("<td></td>").append(item.gender == "M" ? "男" : "女");
                var emailTd = $("<td></td>").append(item.email);
                var deptNameTd = $("<td></td>").append(item.department.deptName);

                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                    .append("编辑");

                // 为员工添加自定义属性，id
                editBtn.attr("edit_id", item.empId);

                var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                    .append("删除");

                // 为员工添加自定义属性，id
                delBtn.attr("delete_id", item.empId);

                var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);

                $("<tr></tr>").append(checkboxTd).append(empIdTd).append(empNameTd)
                    .append(genderTd).append(emailTd).append(deptNameTd)
                    .append(btnTd).appendTo("#emp_table tbody");
            });
        }

        // 2.2 解析并显示分页信息
        function build_page_info(res){
            // 清空信息
            $("#page_info_area").empty();

            $("#page_info_area").append("当前第 " +  res.extend.pageInfo.pageNum +
                " 页，总 " + res.extend.pageInfo.pages +" 页，总 " + res.extend.pageInfo.total + " 条记录");
            // 为全局总记录数赋值
            totalRecord = res.extend.pageInfo.total;
            // 为全局当前页赋值
            currentPage = res.extend.pageInfo.pageNum;
        }

        // 2.3 解析并显示分页条
        function build_page_nav(res){
            // 清空元素
            $("#page_nav_area").empty();

            var ul = $("<ul></ul>").addClass("pagination");

            //构建元素
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
            if(res.extend.pageInfo.hasPreviousPage == false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else{
                //为元素添加点击翻页的事件
                firstPageLi.click(function(){
                    to_page(1);
                });
                prePageLi.click(function(){
                    to_page(res.extend.pageInfo.pageNum -1);
                });
            }

            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
            if(res.extend.pageInfo.hasNextPage == false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else{
                nextPageLi.click(function(){
                    to_page(res.extend.pageInfo.pageNum +1);
                });
                lastPageLi.click(function(){
                    to_page(res.extend.pageInfo.pages);
                });
            }

            //添加首页和前一页的提示
            ul.append(firstPageLi).append(prePageLi);
            //1,2,3遍历给ul中添加页码提示
            $.each(res.extend.pageInfo.navigatepageNums,function(index,item){

                var numLi = $("<li></li>").append($("<a></a>").append(item));
                if(res.extend.pageInfo.pageNum == item){
                    numLi.addClass("active");
                }
                numLi.click(function(){
                    to_page(item);
                });
                ul.append(numLi);
            });
            //添加下一页和末页 的提示
            ul.append(nextPageLi).append(lastPageLi);

            //把ul加入到nav
            var navEle = $("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav_area");
        }

        // 3. 清空表单样式及内容！
        function form_reset(ele){
            // js原生重置方法
            $(ele)[0].reset();
            // 清空样式
            $(ele).find("*").removeClass("has-success has-error");
            $(ele).find(".help-block").text("");
        }

        //==================新增按钮逻辑=========================

        // 4. 新增按钮显示模态框
        $("#emp_add_btn").click(function (){
            // 弹出模态框，重置表单信息(样式和数据)，防止跳过ajax请求插入无效数据
            form_reset("#empAddModal form");

            // 查询出所有部门信息显示在下拉列表中
            // 提前查询出dept信息！
            getDepts("#empAddModal select");

            $("#empAddModal").modal({
                backdrop: "static" // 点击空白处不会关闭模态框
            });
        });

        // 4.1 查询出所有部门信息显示在下拉列表中
        function getDepts(ele){
            // 每次查询都清空下拉列表
            $(ele).empty();

            $.ajax({
                url: "${ctp}/depts",
                type: "get",
                async: false,
                success: function (res){
                    // console.log(res);
                    $.each(res.extend.depts,function(){
                        $("<option></option>").append(this.deptName)
                            .attr("value", this.deptId)
                            .appendTo(ele);
                    });
                }
            });
        }

        // 4.2 展示表单提示信息
        function show_validate_msg(ele, status, msg){
            // 操作前清除当前样式
            $(ele).parent().removeClass("has-success, has-error");
            $(ele).next("span").text("");

            if(status == "success"){
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
            }else{
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }
        }

        // 4.3 校验表单数据
        function validate_add_form(){
            // 校验用户名
            var empName = $("#empName_add_input").val();
            var regName = /(^[a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
            if(!regName.test(empName)){
                show_validate_msg("#empName_add_input", "error", "用户名可以是2-5位中文或者5-16位英文和数字的组合！")
                return false;
            }else{
                show_validate_msg("#empName_add_input", "success", "");
            }

            // 校验邮箱
            var email = $("#email_add_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if(!regEmail.test(email)){
                show_validate_msg("#email_add_input", "error", "邮箱格式不正确！");
                return false;
            }else{
                show_validate_msg("#email_add_input", "success", "");
            }
            return true;
        }

        // 4.4 后端校验用户名是否可用
        $("#empName_add_input").change(function (){
            var empName = this.value;
            $.ajax({
                url: "${ctp}/checkEmpName",
                data: "empName="+empName,
                type: "POST",
                success: function (res){
                    if(res.code == 100){
                        show_validate_msg("#empName_add_input", "success", "用户名可用!");
                        $("#emp_save_btn").attr("ajax-validate", "success");
                    }else{
                        show_validate_msg("#empName_add_input", "error", res.extend.inValid_empName);
                        $("#emp_save_btn").attr("ajax-validate", "error");
                    }
                }
            });
        });

        // 4.5 保存员工信息
        $("#emp_save_btn").click(function (){

            // 1. 校验数据
           /* if(!validate_add_form()){
                return false;
            }*/

            // 后端校验用户名是否存在
            if($(this).attr("ajax-validate") == "error"){
                return false;
            }

            // 校验成功，发送ajax请求保存员工
            $.ajax({
                url: "${ctp}/emp",
                data: $("#empAddModal form").serialize(), // 可以自动序列化表单数据
                type: "POST",
                success: function (res){

                    if(res.code == 100){
                        // 1. 关闭模态框
                        $("#empAddModal").modal('hide');
                        // 2. 来到最后一页显示
                        // 传入一个极大值，用总记录数当总页数，分页插件自动处理最后一页溢出问题！
                        to_page(totalRecord);
                    }else{
                        // JSR303校验失败
                        if(undefined != res.extend.errorFields.email){
                            // 显示邮箱错误信息
                            show_validate_msg("#email_add_input", "error", res.extend.errorFields.email);
                        }
                        if(undefined != res.extend.errorFields.empName){
                            // 显示邮箱错误信息
                            show_validate_msg("#empName_add_input", "error", res.extend.errorFields.empName);
                        }
                    }

                }
            });
        });


        //==================编辑按钮逻辑=========================

        //1、我们是按钮创建之前就绑定了click，所以绑定不上。
        // 1)、可以在创建按钮的时候绑定。2)、绑定点击.live()
        // jquery 新版没有live，使用on进行替代
        $(document).on("click", ".edit_btn", function (){

            // 1. 查询部门信息并显示
            getDepts("#empUpdateModal select");
            // 2. 查询员工信息并显示(这一步会用到上一步数据)
            getEmp($(this).attr("edit_id"));

            // 两个ajax请求会应为加载速度问题，造成显示不太正确，
            // 需要关闭异步请求，给getDepts 加上 async:false

            // 将员工id传递给更新按钮！
            $("#emp_update_btn").attr("edit-id", $(this).attr("edit_id"));

            // 3. 显示模态框
            $("#empUpdateModal").modal({
                backdrop: "static" // 点击空白处不会关闭模态框
            });

        });


        //==================单选删除按钮逻辑=========================

        // 单个删除员工信息
        $(document).on("click", ".delete_btn", function (){
            // 弹出确认信息
            var empName = $(this).parents("tr").find("td:eq(2)").text();
            if(confirm("你确认删除【" + empName + "】吗？")){
                // 确认，发送ajax请求
                var empId = $(this).attr("delete_id");
                $.ajax({
                    url: "${ctp}/emp/" + empId,
                    type: "delete",
                    success: function (res){
                        // 回到本页
                        to_page(currentPage);
                    }
                });
            }
        });

        // 查询员工信息
        function getEmp(id){
            $.ajax({
                url: "${ctp}/emp/" + id,
                type: "get",
                success: function (res){
                    var empData = res.extend.emp;
                    $("#empName_update_static").text(empData.empName);
                    $("#email_update_input").val(empData.email);
                    $("#empUpdateModal input[name=gender]").val([empData.gender]);
                    $("#empUpdateModal select").val([empData.dId]);
                }
            });
        }

        // 更新员工信息
        $("#emp_update_btn").click(function (){
            // 验证邮箱是否合法
            var email = $("#email_update_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if(!regEmail.test(email)){
                show_validate_msg("#email_update_input", "error", "邮箱格式不正确！");
                return false;
            }
            show_validate_msg("#email_update_input", "success", "");

            // 发送ajax保存信息
            $.ajax({
                url: "${ctp}/emp/" + $(this).attr("edit-id"),
                /*type: "post",*/
                /*data: $("#empUpdateModal form").serialize() + "&_method=put",*/
                type: "put",
                data: $("#empUpdateModal form").serialize(),
                success: function (res){
                    // 关闭模态框
                    $("#empUpdateModal").modal("hide");
                    // 回到本页面
                    to_page(currentPage);
                }
            });

        });

        //==================多选删除按钮逻辑=========================

        // 全选按钮逻辑实现一
        $("#check_all").click(function (){
            // attr获取checked是undefined;
            //我们这些dom原生的属性;attr获取自定义属性的值;prop获取原生属性
            // 让多选框与第一个全选按钮同步状态即可！
            $(".check_item").prop("checked", $(this).prop("checked"));
        });

        // 全选按钮逻辑实现二
        $(document).on("click", ".check_item", function (){
            // 判断选中的和未选中的是否相等
            var flag = $(".check_item:checked").length == $(".check_item").length;
            $("#check_all").prop("checked", flag);
        });

        // 多选删除实现
        $("#emp_delete_all_btn").click(function (){

            // 直接点击删除无效！
            if($(".check_item:checked").length == 0){
                return false;
            }

            var empNames = "";
            var del_ids = "";
            $.each($(".check_item:checked"), function (){
               empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
               del_ids += $(this).parents("tr").find("td:eq(1)").text() + "-";
            });
            // 去掉末尾多余逗号和 -
            empNames = empNames.substring(0, empNames.length - 1);
            del_ids = del_ids.substring(0, del_ids.length - 1);
            if(confirm("你确认删除【" + empNames + "】吗")){
                // 发送ajax请求删除数据
                $.ajax({
                    url: "${ctp}/emp/" + del_ids,
                    type: "delete",
                    success: function (res){
                        to_page(currentPage);
                    }
                });
            }
        });

    </script>

</body>
</html>

