<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/style.jsp"%>
<form action="${ctx}/sysParameter/${formType=='edit'?'edit':'add'}" class="form-x" method="post">
		<div class="padding-big">
			<input type="hidden" name="id" value="${sysParameter.id }" />
			<div class="form-group">
				<div class="label">
					<label>参数名称</label>
				</div>
				<div class="field">
					<input type="text" class="input input-auto" name="name" value="${sysParameter.name }" data-validate="required:请填写信息" size="20" />
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label>英文键，唯一</label>
				</div>
				<div class="field">
					<input type="text" class="input input-auto" name="paramKey" value="${sysParameter.paramKey }" data-validate="required:请填写信息,ajax#${ctx }/sysParameter/check?id=${sysParameter.id }&paramKey=:已存在" size="20" />
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label>参数值</label>
				</div>
				<div class="field">
					<input type="text" class="input input-auto" name="paramValue" value="${sysParameter.paramValue }"  size="50" />
					<input id="file" type="file" />
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label>备注</label>
				</div>
				<div class="field">
					<textarea id="remarkEditor" placeholder="英文键作为常量，定义后不再修改" name="remark" class="input" style="width:400px;height:100px;">${sysParameter.remark }</textarea>
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
	//上传控件
	$("#file").uploadify({
		swf: '${ctx}/plugins/uploadify/uploadify.swf',
		uploader: '${ctx}/common/uploadFile.json?uploadType=picture',
		fileObjName: 'file',
		multi: false,
		//只允许选择一个
		buttonText: '上传图片',
		fileTypeExts: '*.jpg;*.gif;*.png;*.jpeg',
		fileSizeLimit: '1MB',
		height: 34,
		width: 70,
		method: 'post',
		//加上此句会重写onSelectError方法【需要重写的事件】
		overrideEvents: ['onSelectError', 'onDialogClose'],
		//返回一个错误，选择文件的时候触发
		onSelectError: function(file, errorCode, errorMsg) {
			switch (errorCode) {
			case - 110 : alert("文件 [" + file.name + "] 大小超出系统限制的" + $('#file').uploadify('settings', 'fileSizeLimit'));
				break;
			case - 120 : alert("文件 [" + file.name + "] 大小异常！");
				break;
			case - 130 : alert("文件 [" + file.name + "] 类型不正确！");
				break;
			}
		},
		onUploadStart: function(file) {
			layer.load(1);
		},
		onUploadSuccess: function(file, data) {
			data = eval('(' + data + ')');
			$('input[name="paramValue"]').val(data.url);
			layer.closeAll();
		},
		onUploadError: function(file, errorCode, errorMsg, errorString) {
			layer.alert(file.name + '上传失败: ' + errorString);
		}
	});
</script>
