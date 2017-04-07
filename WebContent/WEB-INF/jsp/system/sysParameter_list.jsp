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
				<form action="${ctx}/sysParameter/list">
					<input type="button" class="button border-green" value="新增" onclick="openFrame('新增','${ctx}/sysParameter/toAdd','450px','550px')" />
					<input type="button" class="button border-red" value="删除" onclick="deleteForm('dataForm','${ctx}/sysParameter/deleteAll')" />
					<input name="keyword" value="${page.pd.keyword }" type="text" style="margin-left: 50px" class="input input-auto border-main" placeholder="输入关键字"> 
					<input type="submit" value="搜索" class="button  bg-main" style="border-left: 0 none;margin-left: -10px;border-top-left-radius:0;border-bottom-left-radius:0" />
				</form>
			</div>
			<form id="dataForm" method="post">
				<table class="table table-hover">
					<thead>
						<tr>
							<th><input type="checkbox" class="checkall" name="checkall" checkfor="id" /></th>
							<th>参数名称</th>
							<th>英文键，唯一</th>
							<th>参数值</th>
							<th>备注</th>
							<th>创建时间</th>
							<th>操作</th>
						</tr>
					</thead>
					<c:forEach items="${sysParameters }" var="sysParameter">
						<tr>
							<td>
								<input type="checkbox" name="id" value="${sysParameter.id }" />
							</td>
							<td>${sysParameter.name }</td>
							<td>${sysParameter.paramKey }</td>
							<td>${sysParameter.paramValue }</td>
							<td>
								<c:if test="${fn:length(sysParameter.remark)>20 }">
								${fn:substring(sysParameter.remark,0,20) }...
								</c:if>
								<c:if test="${fn:length(sysParameter.remark)<=20 }">
								${sysParameter.remark }
								</c:if>
							</td>
							<td><fmt:formatDate value="${sysParameter.createTime }" pattern="yyyy-MM-dd"/></td>
							<td>
								<a class="button border-blue button-little" href="javascript:;" onclick="openFrame('修改','${ctx}/sysParameter/toEdit?id=${sysParameter.id }','450px','550px')">修改</a> 
								<a class="button border-yellow button-little" href="javascript:;" onclick="deleteData('${ctx}/sysParameter/delete?id=${sysParameter.id }')">删除</a>
							</td>
						</tr>
					</c:forEach>
				</table>
			</form>
			<div class="panel-foot text-center">
				<form action="${ctx}/sysParameter/list">
					<%@ include file="/WEB-INF/jsp/common/pagination.jsp"%>
				</form>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/jsp/common/foot.jsp"%>
</body>
</html>