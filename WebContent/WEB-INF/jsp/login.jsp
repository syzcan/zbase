<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<title>${empty zparam.WEB_NAME.param_value?'月光边境':zparam.WEB_NAME.param_value}</title>
<meta name="keywords" content="关键词" />
<meta name="description" content="描述" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%@ include file="/WEB-INF/jsp/common/style.jsp"%>
<style type="text/css">
form .form-group:last-child{padding-bottom:0;}
.passcode{position:absolute;right:0;top:0;height:32px;margin:1px;border-left:solid 1px #ddd;text-align:center;line-height:32px;border-radius:0 4px 4px 0;}
</style>
</head>
<body class="bg-back">
	<div class="container" style="margin-top: 100px">
		<div class="line">
			<div class="bg-white xs6 xm4 xs3-move xm4-move">
				<form id="dataForm" onsubmit="return false" action="${ctx }/login" method="post">
					<div class="panel padding">
						<div class="text-center">
							<br>
							<h2>
								<strong>欢迎使用${zparam.WEB_NAME['param_value'] }</strong>
							</h2>
						</div>
						<div class="" style="padding: 30px;">
							<div class="form-group">
								<div class="field field-icon-right">
									<input type="text" id="username" class="input" name="username" placeholder="登录账号" data-validate="required:请填写账号" /> <span class="icon icon-user"></span>
								</div>
							</div>
							<div class="form-group">
								<div class="field field-icon-right">
									<input type="password" id="password" class="input" name="password" placeholder="登录密码" data-validate="required:请填写密码" /> <span class="icon icon-key"></span>
								</div>
							</div>
							<div class="form-group">
								<div class="field">
									<input type="text" id="passcode" class="input" name="passcode" placeholder="填写右侧的验证码" data-validate="required:请填写右侧的验证码" /> <img src="${ctx }/common/code.jpg" onclick="this.src='${ctx }/common/code.jpg?'+Math.random()" width="80" height="32" class="passcode" />
								</div>
							</div>
							<div class="form-group">
								<div class="field">
									<button class="button button-block bg-main text-big" onclick="saveForm(this)">立即登录后台</button>
								</div>
							</div>
							<div class="form-group">
								<div class="field text-center">
									<p class="text-muted text-right">
										<span class="float-left"><input type="checkbox" id="rememberMe" name="rememberMe" value="1" />记住我</span>
										<a class="" href="#">忘记密码了？</a> | <a class="" href="#">注册新账号</a>
									</p>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
function saveForm(obj) {
	//校验表单
	var $form = $(obj).parents('form');
	$form.ajaxSubmit(function() {
		saveCookie();
		zutil.formAjax($form,function(){
			location.href='${ctx}/';
		});
	});
}
//记住我，把账号密码保存到cookie
function saveCookie() {
	if ($("#rememberMe").prop("checked")) {
		$.cookie('username', $("#username").val(), {
			expires : 7
		});
		$.cookie('password', $("#password").val(), {
			expires : 7
		});
	}else{
		$.cookie('username', '', {
			expires : -1
		});
		$.cookie('password', '', {
			expires : -1
		});
	}
}

$(function() {
	var username = $.cookie('username');
	var password = $.cookie('password');
	if (typeof(username) != "undefined"&& typeof(password) != "undefined") {
		$('#username').val(username);
		$('#password').val(password);
		$('#passcode').focus();
		$("#rememberMe").prop("checked", true);
	}
});
</script>
</html>