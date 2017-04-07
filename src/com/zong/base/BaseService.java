package com.zong.base;

import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * @desc 业务基类，包含通用方法
 * @author zong
 * @date 2016年3月8日
 */
public class BaseService {

	protected Logger logger = LoggerFactory.getLogger(this.getClass());
	public static final ObjectMapper OBJECT_MAPPER = new ObjectMapper();

	/**
	 * 得到32位的uuid
	 * 
	 * @return
	 */
	public String get32UUID() {
		return UUID.randomUUID().toString().trim().replaceAll("-", "");
	}

	/**
	 * 得到request对象
	 * 
	 * @return
	 */
	public HttpServletRequest getRequest() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
				.getRequest();
		return request;
	}

	/**
	 * 得到session对象
	 * 
	 * @return
	 */
	public HttpSession getSession() {
		return getRequest().getSession();
	}

	/**
	 * 获取客户端真实IP
	 * 
	 * @author zong
	 * @param request
	 * @return
	 * @date 2016年2月22日
	 */
	public String getIp() {
		HttpServletRequest request = getRequest();
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
	
}
