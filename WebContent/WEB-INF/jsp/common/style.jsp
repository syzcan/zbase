<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" href="${ctx }/static/css/pintuer.css" />
<link rel="stylesheet" href="${ctx }/plugins/perfectScrollbar/perfect-scrollbar.min.css" />
<link rel="stylesheet" href="${ctx }/plugins/umeditor/themes/default/css/umeditor.css" />
<link rel="stylesheet" href="${ctx }/plugins/uploadify/uploadify.css" />
<link rel="stylesheet" href="${ctx }/plugins/webuploader/webuploader.css" />
<link rel="stylesheet" href="${ctx }/plugins/ztree/css/zTreeStyle/zTreeStyle.css" />
<link rel="shortcut icon" href="${ctx }/static/image/favicon.ico"/>
<script type="text/javascript">var ctx = "${pageContext.request.contextPath }";</script>
<script type="text/javascript" src="${ctx }/static/js/jquery.js"></script>
<script type="text/javascript" src="${ctx }/static/js/pintuer.js"></script>
<script type="text/javascript" src="${ctx }/static/js/zcommon.js"></script>
<script type="text/javascript" src="${ctx }/plugins/jquery.cookie.js"></script>
<script type="text/javascript" src="${ctx }/plugins/perfectScrollbar/perfect-scrollbar.min.js"></script>
<script type="text/javascript" src="${ctx }/plugins/layer/layer.js"></script>
<script type="text/javascript" src="${ctx }/plugins/laydate/laydate.js"></script>
<%-- <script type="text/javascript" src="${ctx }/plugins/umeditor/third-party/template.min.js"></script> --%>
<script type="text/javascript" src="${ctx }/plugins/umeditor/umeditor.config.js"></script>
<script type="text/javascript" src="${ctx }/plugins/umeditor/umeditor.min.js"></script>
<script type="text/javascript" src="${ctx }/plugins/uploadify/jquery.uploadify.min.js"></script>
<script type="text/javascript" src="${ctx }/plugins/webuploader/webuploader.min.js"></script>
<script type="text/javascript" src="${ctx }/plugins/ztree/jquery.ztree.all.min.js"></script>