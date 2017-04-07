<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="/WEB-INF/jsp/common/style.jsp"%>
<link rel="stylesheet" href="${ctx }/static/css/zadmin.css" />
<script type="text/javascript" src="${ctx }/static/js/zadmin.js"></script>
<form action="${ctx}/sysRole/${formType=='edit'?'edit':'add'}" class="form-x" method="post">
		<div class="padding-big">
			<input type="hidden" name="id" value="${sysRole.id }" />
			<div class="form-group">
				<div class="label">
					<label>name</label>
				</div>
				<div class="field">
					<input type="text" class="input input-auto" name="name" value="${sysRole.name }" data-validate="required:请填写信息" size="20" />
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label>remark</label>
				</div>
				<div class="field">
					<input type="text" class="input input-auto" name="remark" value="${sysRole.remark }"  size="20" />
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label>权限菜单</label>
				</div>
				<div class="field">
					<ul id="treeDemo" class="ztree"></ul>
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
			//选中的树节点添加表单隐藏域，先移出在添加
			$('input[type="hidden"][data-ztree]').remove();
			$.each(zTreeObj.getCheckedNodes(true),function(i,n){
				$form.append('<input type="hidden" data-ztree name="menus['+i+'].id" value="'+n.id+'"/>');
			});
			zutil.formAjax($form, function() {
				parent.location.href = parent.location.href;
			});
		});
	}

	var zTreeObj;
	var setting = {check: {enable: true,chkboxType :{ "Y" : "p", "N" : "s" }},data: {simpleData: {enable: true}}};
	var zNodes = ${sysMenus};
	$(document).ready(function(){
	   zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, zNodes);
	});
</script>
