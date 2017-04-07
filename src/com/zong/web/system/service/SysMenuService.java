package com.zong.web.system.service;

import java.util.List;

import com.zong.web.system.bean.SysMenu;
import com.zong.util.Page;
import com.zong.util.PageData;

/**
 * @desc sysMenu业务接口类
 * @author zong
 * @date 2017年03月19日
 */
public interface SysMenuService {

	/**
	 * 新增sysMenu
	 * 
	 * @param sysMenu
	 * @throws Exception
	 */
	public void addSysMenu(SysMenu sysMenu) throws Exception;
	
	/**
	 * 删除sysMenu
	 * 
	 * @param sysMenu
	 */
	public void deleteSysMenu(SysMenu sysMenu) throws Exception;
	
	/**
	 * 删除多个sysMenu
	 * @param ids
	 */
	public void deleteSysMenus(String[] ids) throws Exception;
	
	/**
	 * 修改sysMenu
	 * 
	 * @param sysMenu
	 * @throws Exception
	 */
	public void editSysMenu(SysMenu sysMenu) throws Exception;

	/**
	 * 根据id查询sysMenu
	 * 
	 * @param sysMenu
	 * @return
	 */
	public SysMenu loadSysMenu(SysMenu sysMenu);

	/**
	 * 分页查询sysMenu
	 * 
	 * @param page
	 * @return
	 */
	public List<SysMenu> findSysMenuPage(Page page);
	
	/**
	 * 查询全部sysMenu
	 * 
	 * @param pageData
	 * @return
	 */
	public List<SysMenu> findSysMenu(PageData pageData);
	
	/**
	 * 按层级封装菜单
	 * @param menus
	 * @return
	 */
	public List<SysMenu> packageMenu(List<SysMenu> menus);
	
	public List<SysMenu> findRoleMenu(PageData pd);
}
