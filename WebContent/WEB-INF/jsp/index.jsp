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
	<div class="layout">
		<div class="margin">
			<div class="line-big">
				<div class="xm3">
					<div class="panel border-back">
						<div class="panel-body text-center">
							<!-- <a href="#"><span class="icon-smile-o" style="font-size: 48px"></span></a> -->
							<img width="120" class="radius-circle box-shadow" src="${ctx }/${sessionScope.sessionUser.avatar }" onerror="this.src='${ctx }/static/image/avatar.jpg'" />
						</div>
						<div class="panel-foot bg-back border-back">您好，${sessionScope.sessionUser.username } 上次登录：<fmt:formatDate value="${sessionScope.sessionUser.lastLogin }" pattern="yyyy-MM-dd HH:mm"/> </div>
					</div>
					<br />
					<div class="panel">
						<div class="panel-head">
							<strong>站点统计</strong>
						</div>
						<ul class="list-group">
							<li data-table="sys_user"><a href="${ctx }/sysUser/list"><span class="float-right badge bg-red"></span><span class="icon-user"></span> 会员</a></li>
							<li data-table="article"><a href="${ctx }/article/list"><span class="float-right badge bg-main"></span><span class="icon-file-text"></span> 文章</a></li>
							<li data-table="photo"><a href="${ctx }/photo/list"><span class="float-right badge bg-main"></span><span class="icon-file-photo-o"></span> 图片</a></li>
							<li data-table="music"><a href="${ctx }/music/list"><span class="float-right badge bg-main"></span><span class="icon-music"></span> 音乐</a></li>
							<li data-table="video"><a href="${ctx }/video/list"><span class="float-right badge bg-main"></span><span class="icon-file-video-o"></span> 视频</a></li>
						</ul>
					</div>
					<br />
				</div>
				<div class="xm9">
					<div class="alert alert-yellow">
						<span class="close"></span><strong>注意：</strong>您有5条未读信息，<a href="#">点击查看</a>。
					</div>
					<blockquote class="border-main margin-top margin-bottom">
						<strong>${zparam.WEB_DESC.param_value }</strong>
						<pre>${zparam.WEB_DESC.remark }</pre>
					</blockquote>
					<blockquote class="border-blue quote-floatright margin-top margin-bottom">
						<strong>${zparam.SIGN.param_value }</strong>
						<pre>${zparam.SIGN.remark }</pre>
					</blockquote>
					<div class="panel">
						<div class="panel-head">
							<strong>系统信息</strong>
						</div>
						<table class="table">
							<tr>
								<th colspan="2">服务器信息</th>
								<th colspan="2">系统信息</th>
							</tr>
							<tr>
								<td width="110" align="right">操作系统：</td>
								<td>Windows 7</td>
								<td width="90" align="right">后台框架：</td>
								<td><a href="http://www.pintuer.com" target="_blank">Spring、SpringMvc、Mybatis</a></td>
							</tr>
							<tr>
								<td align="right">Web服务器：</td>
								<td>tomcat8</td>
								<td align="right">前端框架：</td>
								<td><a href="http://www.pintuer.com">pintuer、layer</a></td>
							</tr>
							<tr>
								<td align="right">程序语言：</td>
								<td>Java、jstl</td>
								<td align="right">演示：</td>
								<td><a href="${ctx }/" >http://demo.pintuer.com</a></td>
							</tr>
							<tr>
								<td align="right">数据库：</td>
								<td>MySql、Redis</td>
								<td align="right">群交流：</td>
								<td><a href="http://shang.qq.com/wpa/qunwpa?idkey=a08e4d729d15d32cec493212f7672a6a312c7e59884a959c47ae7a846c3fadc1" target="_blank">201916085</a> (点击加入)</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/jsp/common/foot.jsp"%>
</body>
<script type="text/javascript">
	//统计数量
	$('.list-group li').each(function(){
		var $this = $(this);
		$.get('${ctx}/common/count.json?table='+$(this).attr('data-table')).done(function(data){
			$this.find('.badge').html(data.count);
		});
	});
</script>
</html>