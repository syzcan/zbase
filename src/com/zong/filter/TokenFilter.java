package com.zong.filter;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.zong.cache.TokenService;
import com.zong.util.SpringContextUtil;
import com.zong.util.ZConst;

/**
 * app访问权限过滤
 * 
 * @desc
 * @author zong
 * @date 2016-6-23 下午4:40:38
 */
public class TokenFilter implements Filter {
	private static final Logger logger = LoggerFactory.getLogger(TokenFilter.class);
	// 不过滤的路径
	private static final String[] ignoreUrls = { "app/login", "app/logout" };
	private static final TokenService tokenService = (TokenService) SpringContextUtil.getBean(TokenService.class);

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse rsp = (HttpServletResponse) response;
		String path = req.getServletPath();
		// 不过滤指定路径
		for (String url : ignoreUrls) {
			if (path.indexOf(url) != -1) {
				chain.doFilter(request, response);
				return;
			}
		}

		Map<String, Object> result = new HashMap<String, Object>();
		try {
			// 取出参数token进行验证
			// String token = request.getParameter(ZConst.APP_TOKEN);
			String token = req.getHeader(ZConst.APP_TOKEN);
			if (token == null || token.length() != 32) {
				result.put("errCode", "-1");
				result.put("errMsg", "token无效，请重新登录");
				doResponse(rsp, result);
				return;
			}
			tokenService.verifyToken(token);// 验证token
			chain.doFilter(request, response);
		} catch (Exception e) {
			logger.warn(e.getMessage());
			result.put("errCode", "-1");
			result.put("errMsg", e.getMessage());
			doResponse(rsp, result);
		}
	}

	// 返回JSON字符串结果
	private void doResponse(HttpServletResponse response, Map<String, Object> result) {
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
			ObjectMapper objectMapper = new ObjectMapper();
			out.write(objectMapper.writeValueAsString(result));
			out.flush();
		} catch (IOException e) {
			logger.warn("安全Token过滤器执行时异常, 获取Request.PrintWriter对象异常", e);
		} finally {
			if (out != null) {
				out.close();
			}
		}
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		logger.info("token过滤器初始化");
	}

	@Override
	public void destroy() {
		logger.info("token过滤器关闭");
	}
}
