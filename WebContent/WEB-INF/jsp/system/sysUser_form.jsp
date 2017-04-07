<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/style.jsp"%>
<form action="${ctx}/sysUser/${formType=='edit'?'edit':'add'}" class="form-x" method="post">
	<div class="panel">
		<div class="panel-body">
			<input type="hidden" name="id" value="${sysUser.id }" />
			<div class="form-group">
				<div class="label">
					<label>状态</label>
				</div>
				<div class="field">
					<select name="status" class="input input-auto">
						<option value="1"${sysUser.status==1?'selected':'' }>启用</option>
						<option value="2"${sysUser.status==2?'selected':'' }>禁用</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label>角色</label>
				</div>
				<div class="field">
					<div class="button-group checkbox">
					<c:forEach items="${roles }" var="role" varStatus="vs">
						<label class="button${role.checked?' active':'' }"><input type="checkbox" name="roles[${vs.index }].id" value="${role.id }" ${role.checked?'checked':'' } /><span class="icon icon-check text-green"></span>${role.name }</label>
					</c:forEach>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label>昵称</label>
				</div>
				<div class="field">
					<input type="text" class="input input-auto" name="nickname" value="${sysUser.nickname }" data-validate="required:请填写信息" size="20" />
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label>性别</label>
				</div>
				<div class="field">
					<select name="gender" class="input input-auto">
						<option value="">请选择</option>
						<option value="男"${sysUser.gender=='男'?'selected':'' }>男</option>
						<option value="女"${sysUser.gender=='女'?'selected':'' }>女</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label>生日</label>
				</div>
				<div class="field">
					<input type="text" class="input input-auto" name="birthday" value="<fmt:formatDate value="${sysUser.birthday }" pattern="yyyy-MM-dd"/>" onclick="laydate()" size="20" />
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label>头像</label>
				</div>
				<div class="field">
					<input id="avatar" type="hidden" name="avatar" value="${sysUser.avatar }" /> 
					<div id="avatarPicker">选择图片</div>
					<div id="avatarView" style="width: 120px;height: 120px;margin-top: 10px">
						<c:if test="${!empty sysUser.avatar}">
							<img id="image" style="max-width: 120px; max-height: 120px;"
								src="${ctx }/${sysUser.avatar }" />
						</c:if>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label>备注</label>
				</div>
				<div class="field">
					<textarea id="remarkEditor" name="remark" style="width:600px;height:240px;">${sysUser.remark }</textarea>
					<script>UM.getEditor('remarkEditor');</script>				
				</div>
			</div>
		</div>
		<div class="panel-foot text-right">
			<button class="button bg-green" type="button" onclick="saveForm(this)">保存</button>
		</div>
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
	
	$(function() {
		uploader = WebUploader.create({
			auto : true,
			swf : '${ctx }/plugins/webuploader/Uploader.swf',
			server : '${ctx }/common/uploadFile.json?uploadType=picture',
			pick : {id:'#avatarPicker',multiple:false},
			accept : {
				title : 'Images',
				extensions : 'gif,jpg,jpeg,bmp,png',
				//直接用image/*在chrome下出现迟钝
				mimeTypes : 'image/gif,image/jpg,image/jpeg,image/bmp,image/png'
			}
		});
		// 上传开始弹出加载层
		uploader.on('uploadStart', function(file) {
			layer.load(1);
		});
		// 文件上传过程中创建进度条实时显示。
		uploader.on('uploadProgress', function(file, percentage) {
			var progress = '<div style="padding-top: 40px;text-align:center">'+parseInt(percentage*100)+'%</div>';
			$('.layui-layer[type="loading"] .layui-layer-content').html(progress);
		});
		// 文件上传成功
	    uploader.on( 'uploadSuccess', function(file,data) {
	    	layer.closeAll();
	        $('input[name="avatar"]').val(data.url);
			// 创建缩略图
			uploader.makeThumb(file, function(error, src) {
				if (error) {
					$('#avatarView').html('<img title="不支持预览" src="${ctx}/static/image/avatar.jpg"/>');
					return;
				}
				$('#avatarView').html('<img src="'+src+'"/>');
			}, 120, 120);
		});
		uploader.on('uploadError', function(file,reason) {
			layer.closeAll();
			layer.msg('上传失败:'+reason);
		});
	});
</script>
