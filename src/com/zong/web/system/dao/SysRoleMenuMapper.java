package com.zong.web.system.dao;

import java.util.List;

import com.zong.web.system.bean.SysRole;
import com.zong.web.system.bean.SysRoleMenu;
import com.zong.util.Page;
import com.zong.util.PageData;

public interface SysRoleMenuMapper {

	/**
	 * 根据对象主键查询
	 * @param sysRoleMenu
	 */
	SysRoleMenu load(SysRoleMenu sysRoleMenu);
	
	/**
	 * 根据条件分页查询
	 * 
	 * @param page
	 * @return
	 */
	List<SysRoleMenu> findSysRoleMenuPage(Page page);
	
	/**
	 * 根据条件查询全部
	 * 
	 * @param pageData
	 * @return
	 */
	List<SysRoleMenu> findSysRoleMenu(PageData pageData);
	
	/**
	 * 根据对象主键删除
	 * @param sysRoleMenu
	 */
	void delete(SysRoleMenu sysRoleMenu);
	
	/**
	 * 插入对象全部属性的字段
	 * @param sysRoleMenu
	 */
	void insert(SysRoleMenu sysRoleMenu);
	
	/**
	 * 根据主键更新对象不为空属性的字段
	 * @param sysRoleMenu
	 */
	void update(SysRoleMenu sysRoleMenu);

	void deleteByRole(String roleId);
	
	void deleteByMenu(String menuId);
	
}