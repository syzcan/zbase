<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/style.jsp"%>
<form
	action="${ctx}/crawler/rule/${formType=='edit'?'edit':'add'}${formType=='edit'?'/':''}${formType=='edit'?rule.id:'' }"
	class="form-x" method="post">
	<div class="padding-big">
		<div class="form-group">
			<div class="label">
				<label>名称</label>
			</div>
			<div class="field">
				<input type="text" class="input input-auto" name="name"
					value="${rule.name }" data-validate="required:请填写信息" size="20" />
			</div>
		</div>
		<div class="form-group">
			<div class="label">
				<label>类型</label>
			</div>
			<div class="field">
				<select name="type" class="input input-auto">
					<option value="1">列表</option>
					<option value="2" ${rule.type==2?'selected':'' }>详情</option>
				</select>
			</div>
		</div>
		<div class="form-group">
			<div class="label">
				<label>样本地址</label>
			</div>
			<div class="field">
				<input type="text" class="input input-auto" name="craw_url"
					value="${rule.craw_url }" size="50" />
			</div>
		</div>
		<div class="form-group list-rule" style="${rule.type==2?'display:none':'' }">
			<div class="label">
				<label>条目规则</label>
			</div>
			<div class="field">
				<input type="text" class="input input-auto" name="rule_item"
					value="${rule.rule_item }" size="50" />
			</div>
		</div>
		<div class="form-group list-rule" style="${rule.type==2?'display:none':'' }">
			<div class="label">
				<label>下一页规则</label>
			</div>
			<div class="field">
				<input type="text" class="input input-auto" name="rule_next"
					value="${rule.rule_next }" size="50" />
			</div>
		</div>
		<div class="form-group">
			<div class="label">
				<label>扩展规则</label>
				<a href="javascript:;" onclick="addExt()" class="margin-left icon-plus-circle text-big text-green"></a>
			</div>
			<div class="field" id="ext">
				<c:if test="${fn:length(rule.rule_ext)==0 }">
				<div class="margin-bottom">
					<a href="javascript:;" style="display:none;" onclick="delExt(this)" class="margin-left icon-minus-circle text-big text-red"></a>
					<input type="text" placeholder="字段名英文" class="input input-auto" value="" size="10" />
					<input type="text" placeholder="cssQuery" class="input input-auto" value="" size="40" />
					<select class="input input-auto rule_ext_type">
						<option value="text">text</option>
						<option value="html">html</option>
						<option value="attr">attr</option>
					</select> 
					<select class="input input-auto rule_ext_attr" style="display: none">
						<option value="href">href</option>
						<option value="src">src</option>
						<option value="title">title</option>
					</select>
				</div>
				</c:if>
				<c:forEach items="${rule.rule_ext }" var="ext" varStatus="vs">
				<div class="margin-bottom">
					<a href="javascript:;" style="${fn:length(rule.rule_ext)==1?'display:none;':''}" onclick="delExt(this)" class="icon-minus-circle text-big text-red"></a>
					<input type="text" placeholder="字段名英文" class="input input-auto" value="${ext.rule_ext_name }" size="10" />
					<input type="text" placeholder="cssQuery" class="input input-auto" value="${ext.rule_ext_css }" size="40" />
					<select class="input input-auto rule_ext_type">
						<option value="text"${ext.rule_ext_type=='text'?'selected':'' }>text</option>
						<option value="html"${ext.rule_ext_type=='html'?'selected':'' }>html</option>
						<option value="attr"${ext.rule_ext_type=='attr'?'selected':'' }>attr</option>
					</select> 
					<select class="input input-auto rule_ext_attr" style="${ext.rule_ext_type=='attr'?'':'display:none'}">
						<option value="href"${ext.rule_ext_attr=='href'?'selected':'' }>href</option>
						<option value="src"${ext.rule_ext_attr=='src'?'selected':'' }>src</option>
						<option value="title"${ext.rule_ext_attr=='title'?'selected':'' }>title</option>
					</select>
				</div>
				</c:forEach>
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
			var rule_ext = [];
			$('#ext div').each(function(){
				var ext = {};
				ext.rule_ext_name = $.trim($(this).find(":input:eq(0)").val());
				ext.rule_ext_css = $.trim($(this).find(":input:eq(1)").val());
				ext.rule_ext_type = $(this).find(":input:eq(2)").val();
				ext.rule_ext_attr = $(this).find(":input:eq(3)").val();
				rule_ext.push(ext);
			});
			var data = zutil.formJson($form);
			data.rule_ext = rule_ext;
			$.ajax({
				url:$form.attr('action'),
				contentType:'application/json',
				type:'POST',
				dataType:'json',
				data:JSON.stringify(data),
				success:function(data){
					if(data.errMsg=='success'){
						parent.location.href = parent.location.href;
					}else{
						layer.msg(data.errMsg);
					}
				}
			});
		});
	}
	function addExt(){
		var $ext = $('#ext').children().first().clone();
		$ext.find('input').val('');
		$ext.find('.rule_ext_attr').hide();
		$('#ext').append($ext).find('a').show();
	}
	function delExt(obj){
		$(obj).parent().remove();
		if($('#ext a').size()==1){
			$('#ext a').hide();
		}
	}
	$('select[name="type"]').change(function(){
		if($(this).val()=='2'){
			$('.list-rule').hide();
		}else{
			$('.list-rule').show();
		}
	});
	$(document).on('change','.rule_ext_type',function(){
		if($(this).val()=='attr'){
			$(this).next('.rule_ext_attr').show();
		}else{
			$(this).next('.rule_ext_attr').hide();
		}
	});
</script>
