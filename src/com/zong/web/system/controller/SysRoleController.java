package com.zong.web.system.controller;

import java.util.ArrayList;
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
import com.zong.util.Page;
import com.zong.util.PageData;
import com.zong.web.system.bean.SysMenu;
import com.zong.web.system.bean.SysRole;
import com.zong.web.system.service.SysMenuService;
import com.zong.web.system.service.SysRoleService;

/**
 * @desc sysRole控制层 系统角色表
 * @author zong
 * @date 2017年03月19日
 */
@Controller
@RequestMapping(value = "/sysRole")
public class SysRoleController extends BaseController {
	private final static Logger logger = LoggerFactory.getLogger(SysRoleController.class);

	@Autowired
	private SysRoleService sysRoleService;
	@Autowired
    private SysMenuService sysMenuService;

	/**
	 * 查询sysRole列表
	 */
	@RequestMapping(value = "/list")
	public String list(Model model) {
		Page page = super.getPage();
		model.addAttribute("sysRoles", sysRoleService.findSysRolePage(page));
		return "/system/sysRole_list";
	}
	
	/**
	 * 新增sysRole页面
	 */
	@RequestMapping(value = "/toAdd")
	public String toAdd(Model model) {
		model.addAttribute("sysMenus", ztreeJson(""));
		return "/system/sysRole_form";
	}

	/**
	 * 修改sysRole页面
	 */
	@RequestMapping(value = "/toEdit")
	public String toEdit(SysRole sysRole, Model model) {
		sysRole = sysRoleService.loadSysRole(sysRole);
		model.addAttribute("sysRole", sysRole);
		model.addAttribute("sysMenus", ztreeJson(sysRole.getId()));
		model.addAttribute("formType", "edit");
		return "/system/sysRole_form";
	}
	
	/**
	 * 构造ztree的json
	 * @param roleId
	 * @return
	 */
	private String ztreeJson(String roleId){
		List<PageData> datas = new ArrayList<>();
		List<SysMenu> menus = sysMenuService.findRoleMenu(new PageData("roleId",roleId));
		for (SysMenu sysMenu : menus) {
			datas.add(new PageData("id",sysMenu.getId()).put("pId", sysMenu.getPid()).put("name", sysMenu.getName()).put("open", true).put("checked", sysMenu.isChecked()));
		}
		return toJson(datas);
	}
	
	/**
	 * 新增sysRole
	 */
	@ResponseBody
	@RequestMapping(value = "/add")
	public PageData add(SysRole sysRole, Model model) {
		PageData pd = new PageData("errMsg", "success");
		try {
			sysRoleService.addSysRole(sysRole);
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
	 * 修改sysRole
	 */
	@ResponseBody
	@RequestMapping(value = "/edit")
	public PageData edit(SysRole sysRole, Model model) {
		PageData pd = new PageData("errMsg", "success");
		try {
			sysRoleService.editSysRole(sysRole);
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
	 * 删除sysRole
	 */
	@ResponseBody
	@RequestMapping(value = "/delete")
	public PageData delete(SysRole sysRole) {
		PageData pd = new PageData("errMsg", "success");
		try {
			sysRoleService.deleteSysRole(sysRole);
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
	 * 删除多个sysRole
	 */
	@ResponseBody
	@RequestMapping(value = "/deleteAll")
	public PageData deleteAll() {
		PageData pd = new PageData("errMsg", "success");
		try {
			sysRoleService.deleteSysRoles(getRequest().getParameterValues("id"));
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
	 * 查询sysRole详情data
	 */
	@ResponseBody
	@RequestMapping(value = "/data")
	public PageData data(SysRole sysRole) {
		PageData pd = new PageData("errMsg", "success");
		sysRole = sysRoleService.loadSysRole(sysRole);
		pd.put("data", sysRole);
		return pd;
	}

	/**
	 * 查询sysRole列表datas
	 */
	@ResponseBody
	@RequestMapping(value = "/datas")
	public PageData datas() {
		PageData pd = new PageData("errMsg", "success");
		Page page = super.getPage();
		List<SysRole> sysRoles = sysRoleService.findSysRolePage(page);
		pd.put("data", sysRoles).put("page", page);
		return pd;
	}	
}
