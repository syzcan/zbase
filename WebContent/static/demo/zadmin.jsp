<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
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
<link rel="stylesheet" href="${ctx }/static/css/zadmin.css" />
<script type="text/javascript" src="${ctx }/static/js/zadmin.js"></script>
</head>
<body>
	<div id="main">
		<%@ include file="/WEB-INF/jsp/common/nav.jsp"%>
		<div id="left-side">
			<ul class="sidebar-menu">
				<c:forEach items="${contextMenus }" var="menu">
				<li class="treeview">
							<a href="#">
							<i class="fa ${menu.icon }"></i><span>${menu.name }</span><i class="fa float-right ${fn:length(menu.childMenus)>0?'icon-angle-right':'' }"></i>
							</a>
							<c:if test="${fn:length(menu.childMenus)>0}">
							<ul class="treeview-menu">
								<c:forEach items="${menu.childMenus }" var="menu">
								<li><a href="#"><i class="fa ${menu.icon }"></i>${menu.name }</a></li>
								</c:forEach>
							</ul>
							</c:if>
						</li>
				</c:forEach>
			</ul>
		</div>
		<div id="right-area"></div>
	</div>
</body>
<script>
	$.sidebarMenu($('.sidebar-menu'));
	$('#left-side').perfectScrollbar();
	$('#right-area').perfectScrollbar();
</script>
</body>
</html>