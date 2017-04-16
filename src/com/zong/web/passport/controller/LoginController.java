package com.zong.web.passport.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zong.base.BaseController;
import com.zong.util.BusinessException;
import com.zong.util.MD5Util;
import com.zong.util.PageData;
import com.zong.util.ZConst;
import com.zong.web.passport.service.PassportService;
import com.zong.web.system.bean.SysUser;
import com.zong.web.system.service.SysMenuService;

@Controller
public class LoginController extends BaseController {

	private final static Logger logger = LoggerFactory.getLogger(LoginController.class);

	@Autowired
	private PassportService passportService;
	@Autowired
	private SysMenuService menuService;

	/**
	 * 登录
	 */
	@RequestMapping(value = "/toLogin")
	public String toLogin() {
		// 已登录直接到首页
		if (getSession().getAttribute(ZConst.SESSION_USER) != null) {
			return "redirect:/";
		}
		return "/login";
	}

	@ResponseBody
	@RequestMapping(value = "/login")
	public PageData login(SysUser user, String passcode, HttpServletResponse response) {
		PageData pd = new PageData("errMsg", "success");
		try {
			String code = (String) getSession().getAttribute(ZConst.SESSION_SECURITY_CODE);
			if (passcode == null) {
				throw new BusinessException("请输入验证码");
			}
			if (code == null || !code.toLowerCase().equals(passcode.toLowerCase())) {
				throw new BusinessException("验证码错误");
			}
			SysUser u = passportService.login(user);
			// 登录成功，存到session
			getSession().setAttribute(ZConst.SESSION_USER, u);
			// redisService.put(Const.SESSION_USER, user.getId(), user);

			Cookie cookie = new Cookie("auth_key", u.getAuthKey());
			cookie.setPath("/");
			// 如果记住登录，更新auth_key并返回写入cookie
			if ("1".equals(user.getRememberMe())) {
				cookie.setMaxAge(60 * 60 * 24 * 7);// 设置为7天
			} else {// 删除cookie
				cookie.setMaxAge(0);
			}
			response.addCookie(cookie);
			// 用户菜单权限
			getSession().setAttribute(ZConst.SESSION_MENUS,
					menuService.packageMenu(menuService.findSysMenu(new PageData("userId", u.getId()))));
		} catch (BusinessException e) {
			logger.warn(e.getErrMsg());
			pd.put("errMsg", e.getErrMsg());
		} catch (Exception e) {
			logger.error(e.toString(), e);
			pd.put("errMsg", "系统错误！");
		}
		return pd;
	}

	/**
	 * 修改密码
	 */
	@RequestMapping(value = "/password", method = RequestMethod.GET)
	public String password() {
		return "/password";
	}

	@ResponseBody
	@RequestMapping(value = "/password", method = RequestMethod.POST)
	public PageData password(SysUser user, HttpServletResponse response) {
		PageData pd = new PageData("errMsg", "success");
		try {
			SysUser sysUser = (SysUser) getSession().getAttribute(ZConst.SESSION_USER);
			if (!sysUser.getPassword().equals(MD5Util.MD5(user.getOldPassword()))) {
				throw new BusinessException("旧密码错误");
			}
			user.setId(sysUser.getId());
			user.setPassword(MD5Util.MD5(user.getPassword()));
			passportService.updatePassword(user);
			// 修改密码自动注销
			logout(response);
		} catch (BusinessException e) {
			logger.warn(e.getErrMsg());
			pd.put("errMsg", e.getErrMsg());
		} catch (Exception e) {
			logger.error(e.toString(), e);
			pd.put("errMsg", "系统错误！");
		}
		return pd;
	}

	/**
	 * 注销
	 */
	@RequestMapping(value = "/logout")
	public String logout(HttpServletResponse response) {
		SysUser user = (SysUser) getSession().getAttribute(ZConst.SESSION_USER);
		if (user != null) {
			passportService.updateAuthKey(user);
			getSession().removeAttribute(ZConst.SESSION_USER);
			// 删除cookie的auth_key
			Cookie cookie = new Cookie("auth_key", user.getAuthKey());
			cookie.setMaxAge(0);
			cookie.setPath("/");
			response.addCookie(cookie);
		}
		return "redirect:/toLogin";
	}

	/**
	 * 首页
	 */
	@RequestMapping(value = "/")
	public String index() {
		return "/index";
	}

	/**
	 * easyui首页
	 */
	@RequestMapping(value = "/main.html")
	public String main() {
		return "/main";
	}

	@RequestMapping(value = "/music")
	public String music() {
		return "/music";
	}
}
