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
				<form action="${ctx}/sysMenu/list">
					<input type="button" class="button border-green" value="新增" onclick="openFrame('新增','${ctx}/sysMenu/toAdd','','440px')" />
					<input type="button" class="button border-red" value="删除" onclick="deleteForm('dataForm','${ctx}/sysMenu/deleteAll')" />
<%-- 					<input name="keyword" value="${page.pd.keyword }" type="text" style="margin-left: 50px" class="input input-auto border-main" placeholder="输入关键字">  --%>
<!-- 					<input type="submit" value="搜索" class="button  bg-main" style="border-left: 0 none;margin-left: -10px;border-top-left-radius:0;border-bottom-left-radius:0" /> -->
				</form>
			</div>
			<form id="dataForm" method="post">
				<table class="table table-condensed">
					<thead>
						<tr>
							<th>菜单名称</th>
							<th>菜单地址</th>
							<th>排序</th>
							<th>状态</th>
							<th>创建时间</th>
							<th>更新时间</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${sysMenus }" var="sysMenu">
						<tr class="bg">
							<td><span class="${sysMenu.icon } text-big"></span> ${sysMenu.name }</td>
							<td>${sysMenu.url }</td>
							<td>${sysMenu.sort }</td>
							<td>${sysMenu.status==1?'<span class="badge bg-green">启用</span>':'<span class="badge bg-red">禁用</span>' }</td>
							<td><fmt:formatDate value="${sysMenu.createTime }" pattern="yyyy-MM-dd"/></td>
							<td><fmt:formatDate value="${sysMenu.updateTime }" pattern="yyyy-MM-dd"/></td>
							<td>
								<a class="button border-blue button-little" href="javascript:;" onclick="openFrame('修改','${ctx}/sysMenu/toEdit?id=${sysMenu.id }','','440px')">修改</a> 
								<a class="button border-yellow button-little" href="javascript:;" onclick="deleteData('${ctx}/sysMenu/delete?id=${sysMenu.id }')">删除</a>
							</td>
						</tr>
						<c:forEach items="${sysMenu.childMenus }" var="sysMenu">
						<tr data-pid="${sysMenu.pid }">
							<td>&nbsp;&nbsp;&nbsp; <span class="${sysMenu.icon } text-big"></span> ${sysMenu.name }</td>
							<td>${sysMenu.url }</td>
							<td>${sysMenu.sort }</td>
							<td>${sysMenu.status==1?'<span class="badge bg-green">启用</span>':'<span class="badge bg-red">禁用</span>' }</td>
							<td><fmt:formatDate value="${sysMenu.createTime }" pattern="yyyy-MM-dd"/></td>
							<td><fmt:formatDate value="${sysMenu.updateTime }" pattern="yyyy-MM-dd"/></td>
							<td>
								<a class="button border-blue button-little" href="javascript:;" onclick="openFrame('修改','${ctx}/sysMenu/toEdit?id=${sysMenu.id }')">修改</a> 
								<a class="button border-yellow button-little" href="javascript:;" onclick="deleteData('${ctx}/sysMenu/delete?id=${sysMenu.id }')">删除</a>
							</td>
						</tr>
						<c:forEach items="${sysMenu.childMenus }" var="sysMenu">
						<tr>
							<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span class="${sysMenu.icon } text-big"></span> ${sysMenu.name }</td>
							<td>${sysMenu.url }</td>
							<td>${sysMenu.sort }</td>
							<td>${sysMenu.status==1?'<span class="badge bg-green">启用</span>':'<span class="badge bg-red">禁用</span>' }</td>
							<td><fmt:formatDate value="${sysMenu.createTime }" pattern="yyyy-MM-dd"/></td>
							<td><fmt:formatDate value="${sysMenu.updateTime }" pattern="yyyy-MM-dd"/></td>
							<td>
								<a class="button border-blue button-little" href="javascript:;" onclick="openFrame('修改','${ctx}/sysMenu/toEdit?id=${sysMenu.id }')">修改</a> 
								<a class="button border-yellow button-little" href="javascript:;" onclick="deleteData('${ctx}/sysMenu/delete?id=${sysMenu.id }')">删除</a>
							</td>
						</tr>
						</c:forEach>
						</c:forEach>
					</c:forEach>
					</tbody>
				</table>
			</form>
<!-- 			<div class="panel-foot text-center"> -->
<%-- 				<form action="${ctx}/sysMenu/list"> --%>
<%-- 					<%@ include file="/WEB-INF/jsp/common/pagination.jsp"%> --%>
<!-- 				</form> -->
<!-- 			</div> -->
		</div>
	</div>
	<%@ include file="/WEB-INF/jsp/common/foot.jsp"%>
</body>
</html>