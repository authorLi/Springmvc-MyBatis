<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
    <meta charset="utf-8">
    <link rel='stylesheet' href='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css'>
    <style type="text/css">
        .input-group{
            margin:10px 0px;
        }
        h3{
            padding:5px;
            border-bottom:1px solid #ddd;
        }
        li{
            list-style-type:square;
            margin:10px 0;
        }
        em{
            color:#c7254e;
            font-style: inherit;
            background-color: #f9f2f4;
        }
    </style>
</head>
<body>
<div class="row" style="margin:120px;">
    <div class="col-md-6">
        <div class="well col-md-10">
            <h3>管理员登录</h3>
            <form method="post" action="/login">
                <div class="input-group input-group-md">
                <span class="input-group-addon" id="sizing-addon1">
                    <i class="glyphicon glyphicon-user" aria-hidden="true"></i>
                </span>
                    <input type="text" name="username" class="form-control" placeholder="用户名" aria-describedby="sizing-addon1">
                </div>
                <div class="input-group input-group-md">
                <span class="input-group-addon" id="sizing-addon2">
                    <i class="glyphicon glyphicon-lock"></i>
                </span>
                    <input type="password" name="password" class="form-control" placeholder="密码" aria-describedby="sizing-addon1">
                </div>
                <button type="submit" class="btn btn-success btn-block">登录</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>

