<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/style.jsp"%>
<div class="padding-big">
	<div class="margin-bottom">
		<select id="list-rule" class="input input-auto">
			<option value="">--列表规则--</option>
			<c:forEach items="${rules }" var="rule">
				<c:if test="${rule.type==1 }">
				<option value="${rule.id }">${rule.name }</option>
				</c:if>
			</c:forEach>
		</select> 
		<select id="detail-rule" class="input input-auto">
			<option value="">--详情规则--</option>
			<c:forEach items="${rules }" var="rule">
				<c:if test="${rule.type==2 }">
				<option value="${rule.id }">${rule.name }</option>
				</c:if>
			</c:forEach>
		</select> 
		<input type="text" placeholder="爬取列表地址" class="input input-auto"
			name="craw_url" data-next="" size="50" />
		<button class="button bg-green" type="button" onclick="craw()">解析</button>
		<button class="button bg-blue" type="button" onclick="next()">下一页</button>
	</div>
	<table class="table text-default">
		<thead>
			<tr>
				<th width="50">序号</th>
				<th width="300">title</th>
				<th>url</th>
				<th width="80">状态</th>
			</tr>
		</thead>
		<tbody>

		</tbody>
	</table>
</div>
<script>
	function craw() {
		var craw_url = $.trim($('input[name="craw_url"]').val());
		if (craw_url == '') {
			layer.msg('请填写抓取地址');
			return;
		}
		if ($('#list-rule').val() == '') {
			layer.msg('请选择列表规则');
			return;
		}
		if ($('#detail-rule').val() == '') {
			layer.msg('请选择详情规则');
			return;
		}
		layer.load(1,{shade: 0});
		var rule_id = $('#detail-rule').val();
		$.get('${ctx}/crawler/rule/data.json?id=' + $('select').val()).done(
				function(data) {
					var rule = {};
					rule.craw_url = craw_url;
					rule.rule_id = rule_id;
					rule.rule_item = data.rule.rule_item;
					rule.rule_next = data.rule.rule_next;
					$.each(data.rule.rule_ext, function(i, n) {
						rule[n.rule_ext_name] = n.rule_ext_css + "|"
								+ n.rule_ext_type + "|" + n.rule_ext_attr;
					});
					$.post('${ctx}/crawler/list.json', rule).done(
							function(data) {
								$('tbody').html('');
								$.each(data.data, function(i, n) {
									var status = '<span class="badge bg-green" data-url="'+n.url+'">可保存</span>';
									if(n.status=='2'){
										status = '<span class="badge bg-blue" data-url="'+n.url+'">已保存</span>';
									}
									$('tbody').append(
											'<tr><td>'+(i+1)+'</td><td>' + n.title + '</td><td><a target="_blank" href="'
													+ n.url + '">'+n.url+'</a></td><td>'+status+'</td></tr>');
								});
								if($('tbody').html()==''){
									$('tbody').html('<tr><td>没有数据</td></tr>');
								}
								layer.close(layer.index);
								if (data.next_url != null) {
									$('input[name="craw_url"]').attr(
											'data-next', data.next_url);
								}
								next();
							});
				});
	}
	function next() {
		if ($('tbody tr').size() == 0) {
			layer.msg('请先解析');
			return;
		}
		if ($('tbody').html().indexOf('没有数据') > -1) {
			layer.msg('没有下一页');
			return;
		}
		if ($('input[name="craw_url"]').attr('data-next') == '') {
			layer.msg('没有下一页');
			return;
		}
		$('input[name="craw_url"]').val($('input[name="craw_url"]').attr('data-next'));
		craw();
	}
</script>
