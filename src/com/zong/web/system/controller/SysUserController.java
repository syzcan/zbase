package com.zong.web.system.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zong.base.BaseController;
import com.zong.util.BusinessException;
import com.zong.util.MD5Util;
import com.zong.util.Page;
import com.zong.util.PageData;
import com.zong.web.passport.service.PassportService;
import com.zong.web.system.bean.SysRole;
import com.zong.web.system.bean.SysUser;
import com.zong.web.system.service.SysRoleService;
import com.zong.web.system.service.SysUserService;

/**
 * @desc sysUser控制层 系统用户表
 * @author zong
 * @date 2017年03月19日
 */
@Controller
@RequestMapping(value = "/sysUser")
public class SysUserController extends BaseController {
	private final static Logger logger = LoggerFactory.getLogger(SysUserController.class);

	@Autowired
	private SysUserService sysUserService;
	@Autowired
	private PassportService passportService;
	@Autowired
	private SysRoleService roleService;

	/**
	 * 查询sysUser列表
	 */
	@RequestMapping(value = "/list")
	public String list(Model model) {
		Page page = super.getPage();
		model.addAttribute("sysUsers", sysUserService.findSysUserPage(page));
		return "/system/sysUser_list";
	}
	
	/**
	 * 新增sysUser页面
	 */
	@RequestMapping(value = "/toAdd")
	public String toAdd(Model model) {
		model.addAttribute("roles", roleService.findSysRole(new PageData()));
		return "/system/sysUser_form";
	}

	/**
	 * 修改sysUser页面
	 */
	@RequestMapping(value = "/toEdit")
	public String toEdit(SysUser sysUser, Model model) {
		sysUser = sysUserService.loadSysUser(sysUser);
		//全部角色
		List<SysRole> roles = roleService.findSysRole(new PageData());
		//当前角色，选中
		List<SysRole> myRoles = roleService.findSysRole(new PageData("userId",sysUser.getId()));
		for (SysRole sysRole : myRoles) {
			for (SysRole role : roles) {
				if(role.getId().equals(sysRole.getId())){
					role.setChecked(true);
					break;
				}
			}
		}
		model.addAttribute("roles", roles);
		model.addAttribute("sysUser", sysUser);
		model.addAttribute("formType", "edit");
		return "/system/sysUser_form";
	}
	
	/**
	 * 新增sysUser
	 */
	@ResponseBody
	@RequestMapping(value = "/add")
	public PageData add(SysUser sysUser, Model model) {
		PageData pd = new PageData("errMsg", "success");
		try {
			//随机用户名，初始密码为MD5加密123456
			sysUser.setUsername(passportService.makeUsername());
			sysUser.setPassword(MD5Util.MD5("123456"));
			sysUserService.addSysUser(sysUser);
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
	 * 修改sysUser
	 */
	@ResponseBody
	@RequestMapping(value = "/edit")
	public PageData edit(SysUser sysUser, Model model) {
		PageData pd = new PageData("errMsg", "success");
		try {
			sysUserService.editSysUser(sysUser);
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
	 * 删除sysUser
	 */
	@ResponseBody
	@RequestMapping(value = "/delete")
	public PageData delete(SysUser sysUser) {
		PageData pd = new PageData("errMsg", "success");
		try {
			sysUserService.deleteSysUser(sysUser);
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
	 * 删除多个sysUser
	 */
	@ResponseBody
	@RequestMapping(value = "/deleteAll")
	public PageData deleteAll() {
		PageData pd = new PageData("errMsg", "success");
		try {
			sysUserService.deleteSysUsers(getRequest().getParameterValues("id"));
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
	 * 查询sysUser详情data
	 */
	@ResponseBody
	@RequestMapping(value = "/data")
	public PageData data(SysUser sysUser) {
		PageData pd = new PageData("errMsg", "success");
		sysUser = sysUserService.loadSysUser(sysUser);
		pd.put("data", sysUser);
		return pd;
	}

	/**
	 * 查询sysUser列表datas
	 */
	@ResponseBody
	@RequestMapping(value = "/datas")
	public PageData datas() {
		PageData pd = new PageData("errMsg", "success");
		Page page = super.getPage();
		List<SysUser> sysUsers = sysUserService.findSysUserPage(page);
		pd.put("data", sysUsers).put("page", page);
		return pd;
	}	
}
