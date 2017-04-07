<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<title>${empty zparam.WEB_NAME.param_value?'月光边境':zparam.WEB_NAME.param_value}</title>
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
				<form action="${ctx}/sysUser/list">
					<input type="button" class="button border-green" value="新增" onclick="openFrame('新增','${ctx}/sysUser/toAdd')" />
					<input type="button" class="button border-red" value="删除" onclick="deleteForm('dataForm','${ctx}/sysUser/deleteAll')" />
					<input name="keyword" value="${page.pd.keyword }" type="text" style="margin-left: 50px" class="input input-auto border-main" placeholder="输入关键字"> 
					<input type="submit" value="搜索" class="button  bg-main" style="border-left: 0 none;margin-left: -10px;border-top-left-radius:0;border-bottom-left-radius:0" />
				</form>
			</div>
			<form id="dataForm" method="post">
				<table class="table table-hover">
					<thead>
						<tr>
							<th><input type="checkbox" class="checkall" name="checkall" checkfor="id" /></th>
							<th>头像</th>
							<th>用户名</th>
							<th>昵称</th>
							<th width="50px">性别</th>
							<th>状态</th>
							<th>上次登录时间</th>
							<th>登录ip</th>
							<th>最后修改</th>
							<th>操作</th>
						</tr>
					</thead>
					<c:forEach items="${sysUsers }" var="sysUser">
						<tr>
							<td>
								<input type="checkbox" name="id" value="${sysUser.id }" />
							</td>
							<td><img style="width: 128px;height: 128px" class="radius-circle img-border box-shadow" src="${ctx }/${sysUser.avatar }" onerror="this.src='${ctx }/static/image/avatar.jpg'" /></td>
							<td>${sysUser.username }</td>
							<td>${sysUser.nickname }</td>
							<td align="center">
							<span class="text-large ${empty sysUser.gender?'icon-question text-yellow':'' }${sysUser.gender=='男'?'icon-male text-blue':'' }${sysUser.gender=='女'?'icon-female text-red':'' }"></span>
							</td>
							<td>${sysUser.status==1?'<span class="badge bg-green">启用</span>':'<span class="badge bg-red">禁用</span>' }</td>
							<td><fmt:formatDate value="${sysUser.lastLogin }" pattern="yyyy-MM-dd HH:mm"/></td>
							<td>${sysUser.ip }</td>
							<td><fmt:formatDate value="${sysUser.updateTime }" pattern="yyyy-MM-dd"/></td>
							<td>
								<a class="button border-blue button-little" href="javascript:;" onclick="openFrame('修改','${ctx}/sysUser/toEdit?id=${sysUser.id }')">修改</a> 
								<a class="button border-yellow button-little" href="javascript:;" onclick="deleteData('${ctx}/sysUser/delete?id=${sysUser.id }')">删除</a>
							</td>
						</tr>
					</c:forEach>
				</table>
			</form>
			<div class="panel-foot text-center">
				<form action="${ctx}/sysUser/list">
					<%@ include file="/WEB-INF/jsp/common/pagination.jsp"%>
				</form>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/jsp/common/foot.jsp"%>
</body>
</html>