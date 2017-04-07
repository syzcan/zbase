package com.zong.web.system.dao;

import java.util.List;

import com.zong.web.system.bean.SysRole;
import com.zong.web.system.bean.SysUserRole;
import com.zong.util.Page;
import com.zong.util.PageData;

public interface SysUserRoleMapper {

	/**
	 * 根据对象主键查询
	 * @param sysUserRole
	 */
	SysUserRole load(SysUserRole sysUserRole);
	
	/**
	 * 根据条件分页查询
	 * 
	 * @param page
	 * @return
	 */
	List<SysUserRole> findSysUserRolePage(Page page);
	
	/**
	 * 根据条件查询全部
	 * 
	 * @param pageData
	 * @return
	 */
	List<SysUserRole> findSysUserRole(PageData pageData);
	
	/**
	 * 根据对象主键删除
	 * @param sysUserRole
	 */
	void delete(SysUserRole sysUserRole);
	
	/**
	 * 插入对象全部属性的字段
	 * @param sysUserRole
	 */
	void insert(SysUserRole sysUserRole);
	
	/**
	 * 根据主键更新对象不为空属性的字段
	 * @param sysUserRole
	 */
	void update(SysUserRole sysUserRole);
	
	void deleteByUser(String userId);

	void deleteByRole(String roleId);
}