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
				<form action="${ctx}/crawler/store/list">
					<input type="button" class="button border-blue" value="爬取列表" onclick="openFrame('爬取','${ctx}/crawler/toCraw','1000px','600px')" />
					<input type="button" class="button border-yellow" value="爬取详情" onclick="openFrame('爬取','${ctx}/crawler/toCrawDetail','1000px','600px')" />
					<select name="status" class="input input-auto" onchange="$(this).parent().submit()">
					<option value="">状态</option>
					<option value="1" ${pd.status==1?'selected':'' }>未下载</option>
					<option value="2" ${pd.status==2?'selected':'' }>已下载</option>
					<option value="3" ${pd.status==3?'selected':'' }>下载失败</option>
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
							<th>操作</th>
						</tr>
					</thead>
					<c:forEach items="${stores }" var="store" varStatus="vs">
						<tr>
							<td align="center">${vs.count }</td>
							<td>${store.title }</td>
							<td>${store.url }</td>
							<td>
							${store.status==1?'<span class="badge bg-yellow">未下载</span>':'' }
							${store.status==2?'<span class="badge bg-green">已下载</span>':'' }
							${store.status==3?'<span class="badge bg-red">下载失败</span>':'' }
							</td>
							<td>
								<a class="button border-blue button-little" href="${ctx}/crawler/store/view?id=${store.id }" target="_blank">查看</a> 
							</td>
						</tr>
					</c:forEach>
				</table>
			</form>
			<div class="panel-foot text-center">
				<form action="${ctx}/crawler/store/list">
					<input type="hidden" name="keyword" value="${pd.keyword }" />
					<input type="hidden" name="status" value="${pd.status }" />
					<%@ include file="/WEB-INF/jsp/common/pagination.jsp"%>
				</form>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/jsp/common/foot.jsp"%>
</body>
</html>