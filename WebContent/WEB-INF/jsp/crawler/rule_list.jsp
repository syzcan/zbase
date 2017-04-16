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
				<form action="${ctx}/craw/rule/list">
					<input type="button" class="button border-green" value="新增" onclick="openFrame('新增','${ctx}/craw/rule/toAdd','980px','500px')" />
				</form>
			</div>
			<form id="dataForm" method="post">
				<table class="table table-hover">
					<thead>
						<tr>
							<th width="50">序号</th>
							<th width="100px">名称</th>
							<th>存储表</th>
							<th>样本地址</th>
							<th width="120px">操作</th>
						</tr>
					</thead>
					<c:forEach items="${rules }" var="rule" varStatus="vs">
						<tr>
							<td align="center">${vs.count }</td>
							<td>${rule.name }</td>
							<td>${rule.craw_store }</td>
							<td style="word-break: break-all;">${rule.craw_url }</td>
							<td>
								<a class="button border-blue button-little" href="javascript:;" onclick="openFrame('修改','${ctx}/craw/rule/toEdit?id=${rule.id }','980px','500px')">修改</a> 
								<a class="button border-yellow button-little" href="javascript:;" onclick="deleteData('${ctx}/craw/rule/delete?id=${rule.id }',function(){location.href=location.href})">删除</a>
							</td>
						</tr>
					</c:forEach>
				</table>
			</form>
		</div>
	</div>
	<%@ include file="/WEB-INF/jsp/common/foot.jsp"%>
</body>
</html>