<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/style.jsp"%>
<div class="padding-big">
	<table class="table text-default">
		<thead>
			<tr>
				<th width="50">序号</th>
				<th width="300">title</th>
				<th>url</th>
				<th width="80"><span class="badge bg-red" id="msg"></span></th>
			</tr>
		</thead>
		<tbody id="dataList">
			<c:forEach items="${stores }" var="store" varStatus="vs">
				<tr>
					<td>${vs.count }</td>
					<td>${store.title }</td>
					<td><a target="_blank" href="${store.url }">${store.url }</a></td>
					<td><span class="badge bg-green" data-url="${store.url }" data-rule="${store.rule_id }">等待</span></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<script type="text/javascript">
function startDown(){
	//没有可下载的跳到下一页
	if($('#dataList span.bg-green').size()==0){
		//$('.pagination li.active').next().children().click();
		location.href=location.href;
		return;
	}
	$('#msg').html('等待:'+$('#dataList span.bg-green').size());
	var $cur = $('#dataList span.bg-green').first().removeClass('bg-green').addClass('bg-yellow').text('正在下载..');
	var rule_id = $cur.attr('data-rule');
	$.get('${ctx}/crawler/rule/data.json?id=' + rule_id).done(function(data){
		var rule = {};
		rule.craw_url = $cur.attr('data-url');
		$.each(data.rule.rule_ext, function(i, n) {
			rule[n.rule_ext_name] = n.rule_ext_css + "|"
					+ n.rule_ext_type + "|" + n.rule_ext_attr;
		});
		var downer = $.ajax({
			url:'${ctx}/crawler/detail.json',
			type:'post',
			data:rule,
			dataType:'json',
			timeout : 10000, //超时时间设置，单位毫秒
			success:function(data){
				if(data.errMsg=='success'){
					$('#dataList span.bg-yellow').removeClass('bg-yellow').addClass('bg-blue').text('已下载');
				}else{
					$('#dataList span.bg-yellow').removeClass('bg-yellow').addClass('bg-red').text('下载失败！');
				}
				startDown();
			},
			complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
				if(status=='timeout'){//
					downer.abort();
					$('#dataList span.bg-yellow').removeClass('bg-yellow').addClass('bg-red').text('超时！');
					startDown();
				}
			}
		});
	});
	
}

if ('${fn:length(stores)}' != '0') {
	startDown();
	layer.load(1,{shade: 0});
}else{
	layer.alert('没有需要下载的数据！')
}
</script>