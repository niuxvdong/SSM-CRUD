// 1. 页面加载完成发起ajax请求，得到分页数据
$(function (){
    to_page(1);
});

function to_page(p){
    $.ajax({
        url: "${ctp}/emps",
        data: "p=" + p,
        type: "get",
        success: function (res){
            // console.log(res);
            // 2. 解析并显示员工数据
            build_emps_table(res);
            // 3. 解析并显示分页信息
            build_page_info(res);
            // 4. 解析并显示分页条
            build_page_nav(res);

        }
    });
}

// 解析并显示员工数据
function build_emps_table(res){
    // 清空元素
    $("#emp_table tbody").empty();

    var emps = res.extend.pageInfo.list;
    $.each(emps, function (index, item){
        // console.log(item);
        var empIdTd = $("<td></td>").append(item.empId);
        var empNameTd = $("<td></td>").append(item.empName);
        var genderTd = $("<td></td>").append(item.gender == "M" ? "男" : "女");
        var emailTd = $("<td></td>").append(item.email);
        var deptNameTd = $("<td></td>").append(item.department.deptName);

        /*
         <button class="btn btn-primary btn-sm">
            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
            编辑
        </button>
        <button class="btn btn-danger btn-sm">
            <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
            删除
        </button>
         */
        var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm")
            .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
            .append("编辑");

        var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
            .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
            .append("删除");

        var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);

        $("<tr></tr>").append(empIdTd).append(empNameTd)
            .append(genderTd).append(emailTd).append(deptNameTd)
            .append(btnTd)
            .appendTo("#emp_table tbody");
    });
}

// 解析并显示分页信息
function build_page_info(res){
    // 清空信息
    $("#page_info_area").empty();

    $("#page_info_area").append("当前第 " +  res.extend.pageInfo.pageNum +
        " 页，总 " + res.extend.pageInfo.pages +" 页，总 " + res.extend.pageInfo.total + " 条记录");
}

// 解析并显示分页条
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

    //添加首页和前一页 的提示
    ul.append(firstPageLi).append(prePageLi);
    //1,2，3遍历给ul中添加页码提示
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