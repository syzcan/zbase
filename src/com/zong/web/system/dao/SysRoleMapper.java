package com.zong.web.system.dao;

import java.util.List;

import com.zong.web.system.bean.SysRole;
import com.zong.util.Page;
import com.zong.util.PageData;

public interface SysRoleMapper {

	/**
	 * 根据对象主键查询
	 * @param sysRole
	 */
	SysRole load(SysRole sysRole);
	
	/**
	 * 根据条件分页查询
	 * 
	 * @param page
	 * @return
	 */
	List<SysRole> findSysRolePage(Page page);
	
	/**
	 * 根据条件查询全部
	 * 
	 * @param pageData
	 * @return
	 */
	List<SysRole> findSysRole(PageData pageData);
	
	/**
	 * 根据对象主键删除
	 * @param sysRole
	 */
	void delete(SysRole sysRole);
	
	/**
	 * 插入对象全部属性的字段
	 * @param sysRole
	 */
	void insert(SysRole sysRole);
	
	/**
	 * 根据主键更新对象不为空属性的字段
	 * @param sysRole
	 */
	void update(SysRole sysRole);
	
}