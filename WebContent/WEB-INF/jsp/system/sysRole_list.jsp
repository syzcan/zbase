<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
				<form action="${ctx}/sysRole/list">
					<input type="button" class="button border-green" value="新增" onclick="openFrame('新增','${ctx}/sysRole/toAdd','400px','620px')" />
					<input type="button" class="button border-red" value="删除" onclick="deleteForm('dataForm','${ctx}/sysRole/deleteAll')" />
				</form>
			</div>
			<form id="dataForm" method="post">
				<table class="table table-hover">
					<thead>
						<tr>
							<th><input type="checkbox" class="checkall" name="checkall" checkfor="id" /></th>
							<th>name</th>
							<th>remark</th>
							<th>createTime</th>
							<th>操作</th>
						</tr>
					</thead>
					<c:forEach items="${sysRoles }" var="sysRole">
						<tr>
							<td>
								<input type="checkbox" name="id" value="${sysRole.id }" />
							</td>
							<td>${sysRole.name }</td>
							<td>${sysRole.remark }</td>
							<td><fmt:formatDate value="${sysRole.createTime }" pattern="yyyy-MM-dd"/></td>
							<td>
								<a class="button border-blue button-little" href="javascript:;" onclick="openFrame('修改','${ctx}/sysRole/toEdit?id=${sysRole.id }','400px','620px')">修改</a> 
								<a class="button border-yellow button-little" href="javascript:;" onclick="deleteData('${ctx}/sysRole/delete?id=${sysRole.id }')">删除</a>
							</td>
						</tr>
					</c:forEach>
				</table>
			</form>
			<div class="panel-foot text-center">
				<form action="${ctx}/sysRole/list">
					<%@ include file="/WEB-INF/jsp/common/pagination.jsp"%>
				</form>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/jsp/common/foot.jsp"%>
</body>
</html>