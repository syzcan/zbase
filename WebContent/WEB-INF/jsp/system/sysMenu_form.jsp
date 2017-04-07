<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/style.jsp"%>
<form action="${ctx}/sysMenu/${formType=='edit'?'edit':'add'}" class="form-x" method="post">
		<div class="padding">
			<input type="hidden" name="id" value="${sysMenu.id }" />
			<div class="form-group">
				<div class="label">
					<label>菜单名称</label>
				</div>
				<div class="field">
					<input type="text" class="input input-auto" name="name" value="${sysMenu.name }" data-validate="required:请填写信息" size="20" />
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label>菜单地址</label>
				</div>
				<div class="field">
					<input type="text" class="input input-auto" name="url" value="${sysMenu.url }" data-validate="required:请填写信息" size="20" />
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label>上级</label>
				</div>
				<div class="field">
					<select name="pid" class="input input-auto">
						<option value="0">根节点</option>
						<c:forEach items="${sysMenus }" var="firstMenu">
						<c:if test="${sysMenu.id!=firstMenu.id }">
						<option value="${firstMenu.id }"${sysMenu.pid==firstMenu.id?'selected':'' }>${firstMenu.name }</option>
						</c:if>
							<c:forEach items="${firstMenu.childMenus }" var="secondMenu">
							<c:if test="${sysMenu.id!=secondMenu.id }">
							<option value="${secondMenu.id }"${sysMenu.pid==secondMenu.id?'selected':'' }>&nbsp;&nbsp;${secondMenu.name }</option>
							</c:if>
							</c:forEach>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label>排序</label>
				</div>
				<div class="field">
					<input type="text" class="input input-auto" name="sort" value="${sysMenu.sort }" data-validate="required:必填,number:只能填写数字" size="20" />
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label>菜单图标</label>
				</div>
				<div class="field">
					<input type="text" class="input input-auto" name="icon" value="${sysMenu.icon }"  size="20" />
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label>类型</label>
				</div>
				<div class="field">
					<select name="type" class="input input-auto">
						<option value="nav"${sysMenu.type=='nav'?'selected':'' }>导航</option>
						<option value="button"${sysMenu.type=='button'?'selected':'' }>按钮</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label>状态</label>
				</div>
				<div class="field">
					<select name="status" class="input input-auto">
						<option value="1"${sysMenu.status==1?'selected':'' }>启用</option>
						<option value="2"${sysMenu.status==2?'selected':'' }>禁用</option>
					</select>
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
			zutil.formAjax($form,function(){
				parent.location.href=parent.location.href;
			});
		});
	}
</script>
