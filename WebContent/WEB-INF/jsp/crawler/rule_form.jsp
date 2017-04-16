<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/style.jsp"%>
<form
	action="${ctx}/craw/rule/${formType=='edit'?'edit':'add'}${formType=='edit'?'/':''}${formType=='edit'?rule.id:'' }"
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
				<label>存储表</label>
			</div>
			<div class="field">
				<c:if test="${formType=='edit'}">
				<input type="text" class="input input-auto" name="craw_store"
					value="${rule.craw_store }" readonly="readonly" size="20" />
				</c:if>
				<c:if test="${formType!='edit'}">
				<input type="text" class="input input-auto" name="craw_store"
					value="${rule.craw_store }" data-validate="required:请填写信息,ajax#${ctx }/craw/rule/check?craw_store=:已存在" size="20" />
				</c:if>
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
				<input type="text" class="input input-auto" name="craw_item"
					value="${rule.craw_item }" size="50" />
			</div>
		</div>
		<div class="form-group list-rule" style="${rule.type==2?'display:none':'' }">
			<div class="label">
				<label>下一页规则</label>
			</div>
			<div class="field">
				<input type="text" class="input input-auto" name="craw_next"
					value="${rule.craw_next }" size="50" />
			</div>
		</div>
		<div class="form-group">
			<div class="label">
				<label>列表规则</label>
				<a href="javascript:;" onclick="addExt(this)" class="margin-left icon-plus-circle text-big text-green"></a>
			</div>
			<div class="field" id="list-ext">
				<c:if test="${formType!='edit' }">
				<div class="margin-bottom">
					<input type="text" placeholder="字段名英文" class="input input-auto" value="title" readonly="readonly" data-validate="required:请填写信息" size="10" />
					<input type="text" placeholder="cssQuery" class="input input-auto" value="" size="30" />
					<select class="input input-auto rule_ext_type">
						<option value="text">text</option>
						<option value="html">html</option>
						<option value="attr">attr</option>
					</select> 
					<input type="text" placeholder="ext_reg" class="input input-auto" value="" size="15" />
					<select class="input input-auto rule_ext_attr">
						<option value="href">href</option>
						<option value="src">src</option>
						<option value="title">title</option>
						<option value="value">value</option>
						<option value="alt">alt</option>
						<option value="data-src">data-src</option>
						<option value="content">content</option>
					</select>
					<select class="input input-auto rule_ext_mode">
						<option value="string">string</option>
						<option value="array">array</option>
					</select>
					<input type="text" placeholder="字段描述" class="input input-auto" value="标题" readonly="readonly" size="10" />
					<a href="javascript:;" style="display:none;" onclick="delExt(this)" class="icon-minus-circle text-big text-red"></a>
				</div>
				<div class="margin-bottom">
					<input type="text" placeholder="字段名英文" class="input input-auto" value="url" readonly="readonly" data-validate="required:请填写信息" size="10" />
					<input type="text" placeholder="cssQuery" class="input input-auto" value="" size="30" />
					<select class="input input-auto rule_ext_type">
						<option value="text">text</option>
						<option value="html">html</option>
						<option value="attr">attr</option>
					</select> 
					<input type="text" placeholder="ext_reg" class="input input-auto" value="" size="15" />
					<select class="input input-auto rule_ext_attr">
						<option value="href">href</option>
						<option value="src">src</option>
						<option value="title">title</option>
						<option value="value">value</option>
						<option value="alt">alt</option>
						<option value="data-src">data-src</option>
						<option value="content">content</option>
					</select>
					<select class="input input-auto rule_ext_mode">
						<option value="string">string</option>
						<option value="array">array</option>
					</select>
					<input type="text" placeholder="字段描述" class="input input-auto" value="详情地址" readonly="readonly" size="10" />
					<a href="javascript:;" style="display:none;" onclick="delExt(this)" class="icon-minus-circle text-big text-red"></a>
				</div>
				</c:if>
				<c:forEach items="${rule.list_ext }" var="ext" varStatus="vs">
				<div class="margin-bottom">
					<input type="text" placeholder="字段名英文" class="input input-auto" value="${ext.rule_ext_name }" ${ext.rule_ext_name=='title'||ext.rule_ext_name=='url'?'readonly':'' } data-validate="required:请填写信息" size="10" />
					<input type="text" placeholder="cssQuery" class="input input-auto" value="${ext.rule_ext_css }" size="30" />
					<select class="input input-auto rule_ext_type">
						<option value="text"${ext.rule_ext_type=='text'?'selected':'' }>text</option>
						<option value="html"${ext.rule_ext_type=='html'?'selected':'' }>html</option>
						<option value="attr"${ext.rule_ext_type=='attr'?'selected':'' }>attr</option>
					</select> 
					<input type="text" placeholder="ext_reg" class="input input-auto" value="${ext.rule_ext_reg }" size="15" />
					<select class="input input-auto rule_ext_attr">
						<option value="href"${ext.rule_ext_attr=='href'?'selected':'' }>href</option>
						<option value="src"${ext.rule_ext_attr=='src'?'selected':'' }>src</option>
						<option value="title"${ext.rule_ext_attr=='title'?'selected':'' }>title</option>
						<option value="value"${ext.rule_ext_attr=='value'?'selected':'' }>value</option>
						<option value="alt"${ext.rule_ext_attr=='alt'?'selected':'' }>alt</option>
						<option value="data-src"${ext.rule_ext_attr=='data-src'?'selected':'' }>data-src</option>
						<option value="content"${ext.rule_ext_attr=='content'?'selected':'' }>content</option>
					</select>
					<select class="input input-auto rule_ext_mode">
						<option value="string"${ext.rule_ext_mode=='string'?'selected':'' }>string</option>
						<option value="array"${ext.rule_ext_mode=='array'?'selected':'' }>array</option>
					</select>
					<input type="text" placeholder="字段描述" class="input input-auto" value="${ext.rule_ext_desc }" ${ext.rule_ext_name=='title'||ext.rule_ext_name=='url'?'readonly':'' } size="10" />
					<a href="javascript:;" style="${ext.rule_ext_name=='title'||ext.rule_ext_name=='url'?'display:none;':'' }" onclick="delExt(this)" class="icon-minus-circle text-big text-red"></a>
				</div>
				</c:forEach>
			</div>
		</div>
		<div class="form-group">
			<div class="label">
				<label>内容规则</label>
				<a href="javascript:;" onclick="addExt(this)" class="margin-left icon-plus-circle text-big text-green"></a>
			</div>
			<div class="field" id="content-ext">
				<c:if test="${formType!='edit' }">
				<div class="margin-bottom">
					<input type="text" placeholder="字段名英文" class="input input-auto" value="content" readonly="readonly" data-validate="required:请填写信息" size="10" />
					<input type="text" placeholder="cssQuery" class="input input-auto" value="" size="30" />
					<select class="input input-auto rule_ext_type">
						<option value="text">text</option>
						<option value="html">html</option>
						<option value="attr">attr</option>
					</select> 
					<input type="text" placeholder="ext_reg" class="input input-auto" value="" size="15" />
					<select class="input input-auto rule_ext_attr">
						<option value="href">href</option>
						<option value="src">src</option>
						<option value="title">title</option>
						<option value="value">value</option>
						<option value="alt">alt</option>
						<option value="data-src">data-src</option>
						<option value="content">content</option>
					</select>
					<select class="input input-auto rule_ext_mode">
						<option value="string">string</option>
						<option value="array">array</option>
					</select>
					<input type="text" placeholder="字段描述" class="input input-auto" value="详情内容" readonly="readonly" size="10" />
					<a href="javascript:;" style="display:none;" onclick="delExt(this)" class="icon-minus-circle text-big text-red"></a>
				</div>
				</c:if>
				<c:forEach items="${rule.content_ext }" var="ext" varStatus="vs">
				<div class="margin-bottom">
					<input type="text" placeholder="字段名英文" class="input input-auto" value="${ext.rule_ext_name }" ${ext.rule_ext_name=='content'?'readonly':'' } data-validate="required:请填写信息" size="10" />
					<input type="text" placeholder="cssQuery" class="input input-auto" value="${ext.rule_ext_css }" size="30" />
					<select class="input input-auto rule_ext_type">
						<option value="text"${ext.rule_ext_type=='text'?'selected':'' }>text</option>
						<option value="html"${ext.rule_ext_type=='html'?'selected':'' }>html</option>
						<option value="attr"${ext.rule_ext_type=='attr'?'selected':'' }>attr</option>
					</select> 
					<input type="text" placeholder="ext_reg" class="input input-auto" value="${ext.rule_ext_reg }" size="15" />
					<select class="input input-auto rule_ext_attr">
						<option value="href"${ext.rule_ext_attr=='href'?'selected':'' }>href</option>
						<option value="src"${ext.rule_ext_attr=='src'?'selected':'' }>src</option>
						<option value="title"${ext.rule_ext_attr=='title'?'selected':'' }>title</option>
						<option value="value"${ext.rule_ext_attr=='value'?'selected':'' }>value</option>
						<option value="alt"${ext.rule_ext_attr=='alt'?'selected':'' }>alt</option>
						<option value="data-src"${ext.rule_ext_attr=='data-src'?'selected':'' }>data-src</option>
						<option value="content"${ext.rule_ext_attr=='content'?'selected':'' }>content</option>
					</select>
					<select class="input input-auto rule_ext_mode">
						<option value="string"${ext.rule_ext_mode=='string'?'selected':'' }>string</option>
						<option value="array"${ext.rule_ext_mode=='array'?'selected':'' }>array</option>
					</select>
					<input type="text" placeholder="字段描述" class="input input-auto" value="${ext.rule_ext_desc }" ${ext.rule_ext_name=='content'?'readonly':'' } size="10" />
					<a href="javascript:;" style="${vs.count==1?'display:none;':''}" onclick="delExt(this)" class="icon-minus-circle text-big text-red"></a>
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
			var list_ext = [];
			var content_ext = [];
			$('#list-ext div').each(function(){
				var ext = {};
				ext.rule_ext_name = $.trim($(this).find(":input:eq(0)").val());
				ext.rule_ext_css = $.trim($(this).find(":input:eq(1)").val());
				ext.rule_ext_type = $(this).find(":input:eq(2)").val();
				ext.rule_ext_reg = $(this).find(":input:eq(3)").val();
				ext.rule_ext_attr = $(this).find(":input:eq(4)").val();
				ext.rule_ext_mode = $(this).find(":input:eq(5)").val();
				ext.rule_ext_desc = $(this).find(":input:eq(6)").val();
				list_ext.push(ext);
			});
			$('#content-ext div').each(function(){
				var ext = {};
				ext.rule_ext_name = $.trim($(this).find(":input:eq(0)").val());
				ext.rule_ext_css = $.trim($(this).find(":input:eq(1)").val());
				ext.rule_ext_type = $(this).find(":input:eq(2)").val();
				ext.rule_ext_reg = $(this).find(":input:eq(3)").val();
				ext.rule_ext_attr = $(this).find(":input:eq(4)").val();
				ext.rule_ext_mode = $(this).find(":input:eq(5)").val();
				ext.rule_ext_desc = $(this).find(":input:eq(6)").val();
				content_ext.push(ext);
			});
			var data = zutil.formJson($form);
			data.list_ext = list_ext;
			data.content_ext = content_ext;
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
			layer.load(1);
		});
	}
	function addExt(obj){
		var $div = $(obj).parent().next();
		var $ext = $div.children().first().clone(true);
		$ext.find('input').val('').removeAttr('readonly');
		$ext.find('a').show();
		$div.append($ext);
	}
	function delExt(obj){
		var $div = $(obj).parents('.field');
		$(obj).parent().remove();
	}
	$('select[name="type"]').change(function(){
		if($(this).val()=='2'){
			$('.list-rule').hide();
		}else{
			$('.list-rule').show();
		}
	});
	$(function(){
		$('input[placeholder="字段名英文"]').blur(function(){
			var $this = $(this);
			var val = $(this).val();
			var count = 0;
			$('input[placeholder="字段名英文"]').each(function(){
				if($(this).val()==val){
					count++;
				}
			});
			if(count>1){
				$this.closest(".form-group").removeClass("check-success");
				$this.closest(".form-group").addClass("check-error");
				layer.tips('该字段已经存在', $this,{tipsMore: true});
				$this.focus();
			}else{
				$this.closest(".form-group").removeClass("check-error");
				$this.parent().find(".input-help").remove();
				$this.closest(".form-group").addClass("check-success");
			}
		});
	});
</script>
