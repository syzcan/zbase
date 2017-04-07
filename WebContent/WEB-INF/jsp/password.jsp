<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/style.jsp"%>
<form action="${ctx}/password" class="form-x" method="post">
		<div class="padding-big">
			<div class="form-group">
				<div class="label">
					<label>旧密码</label>
				</div>
				<div class="field">
					<input type="password" class="input input-auto" name="oldPassword" data-validate="required:请填写信息" size="20" />
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label>新密码</label>
				</div>
				<div class="field">
					<input type="password" class="input input-auto" name="password" data-validate="required:请填写信息" size="20" />
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label>确认新密码</label>
				</div>
				<div class="field">
					<input type="password" class="input input-auto" name="password2" data-validate="required:请填写信息" size="20" />
				</div>
			</div>
		</div>
		<div class="padding text-right">
			<button class="button bg-green" type="button" onclick="saveForm(this)">保存</button>
		</div>
</form>	
<script>
	function saveForm(obj) {
		//校验表单
		var $form = $(obj).parents('form');
		$form.ajaxSubmit(function() {
			if($('input[name="password"]').val()!=$('input[name="password2"]').val()){
				layer.msg('两次新密码不一致');
				return;
			}
			zutil.formAjax($form,function(){
				layer.msg('修改成功，请重新登录');
				setTimeout(function(){
					parent.location.href=parent.location.href;
				},3000);
			});
		});
	}
	
</script>
