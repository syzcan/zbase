<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<title>月光边境</title>
<meta name="keywords" content="关键词" />
<meta name="description" content="描述" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%@ include file="/WEB-INF/jsp/common/style.jsp"%>
</head>
<body style="padding-top: 40px">
	<%@ include file="/WEB-INF/jsp/common/nav.jsp"%>
	<div class="margin">
		<div class="panel">
			<div class="panel-head">
				<form action="${ctx}/craw/store/list">
					<input type="button" class="button border-blue" value="解析列表" onclick="openFrame('解析列表','${ctx}/craw/toCrawList','1000px','600px')" />
					<input type="button" class="button border-green" value="解析详情" onclick="toCrawDetail('')" />
					<input type="button" class="button border-yellow" value="解析详情JS" onclick="toCrawDetail('1')" />
					<select name="status" class="input input-auto" onchange="$(this).parent().submit()">
					<option value="">状态</option>
					<option value="1" ${pd.status==1?'selected':'' }>未解析</option>
					<option value="2" ${pd.status==2?'selected':'' }>已解析</option>
					<option value="3" ${pd.status==3?'selected':'' }>解析失败</option>
					</select>
					<select name="craw_store" class="input input-auto" onchange="$(this).parent().submit()">
					<c:forEach items="${rules }" var="rule">
					<option data-id="${rule.id }" value="${rule.craw_store }" ${pd.craw_store==rule.craw_store?'selected':'' }>${rule.name }</option>
					</c:forEach>
					</select>
					<input name="keyword" value="${pd.keyword }" type="text" style="margin-left: 50px" class="input input-auto border-main" placeholder="输入关键字"> 
					<input type="submit" value="搜索" class="button  bg-main" style="border-left: 0 none;margin-left: -10px;border-top-left-radius:0;border-bottom-left-radius:0" />
				</form>
			</div>
			<form id="dataForm" method="post">
				<table class="table table-hover">
					<thead>
						<tr>
							<th width="50">序号</th>
							<th>名称</th>
							<th>地址</th>
							<th>状态</th>
							<th width="150">操作</th>
						</tr>
					</thead>
					<c:forEach items="${stores }" var="store" varStatus="vs">
						<tr>
							<td align="center">${vs.count }</td>
							<td>${store.title }</td>
							<td><a href="${store.url }" target="_blank">${store.url }</a></td>
							<td>
							${store.status==1?'<span class="badge bg-yellow">未解析</span>':'' }
							${store.status==2?'<span class="badge bg-green">已解析</span>':'' }
							${store.status==3?'<span class="badge bg-red">解析失败</span>':'' }
							</td>
							<td>
								<a class="button border-blue button-little" href="javascript:;" onclick="toView('${store.id}')" >查看</a> 
								<a class="button border-green button-little" href="javascript:;" onclick="crawDetail('${store.url}','')" >同步</a> 
								<a class="button border-yellow button-little" href="javascript:;" onclick="crawDetail('${store.url}','1')" >同步JS</a> 
							</td>
						</tr>
					</c:forEach>
				</table>
			</form>
			<div class="panel-foot text-center">
				<form action="${ctx}/craw/store/list">
					<input type="hidden" name="craw_store" value="${pd.craw_store }" />
					<input type="hidden" name="keyword" value="${pd.keyword }" />
					<input type="hidden" name="status" value="${pd.status }" />
					<%@ include file="/WEB-INF/jsp/common/pagination.jsp"%>
				</form>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/jsp/common/foot.jsp"%>
</body>
<script type="text/javascript">
function toCrawDetail(js_enabled){
	var rule_id = $('select[name="craw_store"]').find("option:selected").attr('data-id');
	var craw_store = $('select[name="craw_store"]').find("option:selected").val();
	openFrame('解析详情','${ctx}/craw/toCrawDetail?rule_id='+rule_id+'&craw_store='+craw_store+'&js_enabled='+js_enabled,'1000px','600px');
}
function toView(id){
	var rule_id = $('select[name="craw_store"]').find("option:selected").attr('data-id');
	var craw_store = $('select[name="craw_store"]').find("option:selected").val();
	location.href = '${ctx}/craw/store/view?rule_id='+rule_id+'&craw_store='+craw_store+'&id='+id;
}
function crawDetail(craw_url,js_enabled){
	var rule_id = $('select[name="craw_store"]').find("option:selected").attr('data-id');
	var craw_store = $('select[name="craw_store"]').find("option:selected").val();
	layer.load(1);
	$.get('${ctx}/craw/rule/data.json?id='+rule_id).done(function(data){
		var rule = {};
		rule.js_enabled = js_enabled;
		rule.craw_url = craw_url;
		rule.craw_store = craw_store;
		$.each(data.rule.content_ext, function(i, n) {
			rule[n.rule_ext_name] = n.rule_ext_css + ";"
					+ n.rule_ext_type + "["+ n.rule_ext_reg + "];" + n.rule_ext_attr + ";" + n.rule_ext_mode;
		});
		$.ajax({
			url:'${ctx}/craw/crawDetail.json',
			type:'post',
			data:rule,
			dataType:'json',
			success:function(data){
				layer.closeAll();
				if(data.errMsg=='success'){
					layer.msg('操作成功');
				}else{
					layer.msg(data.errMsg);
				}
			}
		});
	});
}
</script>
</html>