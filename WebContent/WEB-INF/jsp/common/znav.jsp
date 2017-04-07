<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="layout bg-main bg-inverse fixed" style="z-index: 9;">
	<div class="container-layout">
		<div class="navbar">
			<!--描述：LOGO及系统名称-->
			<div class="navbar-head">
				<button class="button icon-navicon" data-target="#navbar1"></button>
				<a href="${ctx }/"> <img src="http://www.pintuer.com/images/30-white.png"> <strong class="hidden-l hidden-s">苏神管理系统</strong></a>
			</div>
			<!--描述：导航-->
			<div class="navbar-body nav-navicon" id="navbar1">
				<ul class="nav nav-inline nav-menu">
					<li><a class="icon-cog" href="javascript:;">系统<span class="arrow"></span></a>
						<ul class="drop-menu">
							<li><a href="${ctx}/parameter/list"><span class="icon-cogs"></span> 参数设置</a></li>
							<li><a class="icon-th-list" href="${ctx }/menu/list"> 菜单管理</a></li>
							<li><a href="${ctx}/user/list"><span class="icon-user"></span> 用户管理</a></li>
							<li><a href="${ctx}/role/list"><span class="icon-group"></span> 角色管理</a></li>
						</ul></li>
					<li><a class="icon-navicon " href="javascript:;">菜单<span class="arrow"></span></a>
						<ul class="drop-menu" id="menu-ul">
						</ul></li>
				</ul>
				<ul id="music-bar" class="nav nav-inline nav-menu">
					<li><a class="icon-music " href="javascript:;"><span class="arrow"></span></a>
						<ul class="drop-menu" id="music-list">
							<li><a href="javascript:;" data-src="${ctx }/upload/music/八辈子.mp3">八辈子</a></li>
							<li><a href="javascript:;" data-src="${ctx }/upload/music/雪山.mp3">雪山</a></li>
							<li><a href="javascript:;" data-src="${ctx }/upload/music/花吹雪.mp3">花吹雪</a></li>
						</ul>
					</li>
					<li><a class="icon-step-backward"></a></li>
					<li><a class="icon-play"></a></li>
					<li><a class="icon-step-forward"></a></li>
					<li>
						<div class="progress progress-small" style="width: 100px;margin-top: 18px">
							<div class="progress-bar bg-green" style="width: 0%;"></div>
						</div>
					</li>
					<li><a id="music-time">00:00</a></li>
				</ul>
				<!--描述：右侧用户资料-->
				<ul class="nav nav-inline nav-menu navbar-right">
					<li><a class="bg-main" href="javascript:;"> <spn> <img src="${ctx }/static/images/avatar.png" width="28" class="radius-circle"></spn> ${sessionScope.sessionUser.nickname } <span
							class="downward"></span>
					</a>
						<ul class="drop-menu">
							<li><a class="icon-user" target="_blank" href="javascript:;" onclick="openFrame('修改','${ctx}/user/toEdit?id=${sessionScope.sessionUser.id }','760px','475px')">修改资料</a></li>
							<li><a class="icon-key" target="_blank" href="javascript:;">修改密码</a></li>
						</ul></li>
					<li><a class="bg-green" href="javascript:;"><span class="icon-envelope"></span>&nbsp;<span class="badge bg-blue">5+</span><span class="downward"></span></a>
						<ul class="drop-menu">
							<li><a class="text-yellow-light" target="_blank" href="javascript:;"><span class="icon-envelope"></span>您有16封邮件</a></li>
							<li><a class="bg-gray" target="_blank" href="javascript:;"><span class="icon-envelope"></span>查阅更多...</a></li>
						</ul></li>
					<li><a class="bg-blue" href="javascript:;"><span class="icon-bell-o"></span>&nbsp;<span class="badge bg-green">99+</span><span class="downward"></span></a>
						<ul class="drop-menu">
							<li><a class="text-yellow-light active" target="_blank" href="javascript:;"><span class="icon-comment"></span>您有26条未读消息</a></li>
							<li><a class="text-yellow-light active" target="_blank" href="javascript:;"><span class="icon-comments"></span>您有13条回复消息</a></li>
							<li><a class="bg-gray" target="_blank" href="javascript:;"><span class="icon-envelope"></span>查看更多...</a></li>
						</ul></li>
					<li><a class="bg-yellow" href="${ctx }/logout"><span class="icon-sign-out"></span>注销</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>
