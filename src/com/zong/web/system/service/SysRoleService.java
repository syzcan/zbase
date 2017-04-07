package com.zong.web.system.service;

import java.util.List;

import com.zong.web.system.bean.SysRole;
import com.zong.util.Page;
import com.zong.util.PageData;

/**
 * @desc sysRole业务接口类
 * @author zong
 * @date 2017年03月19日
 */
public interface SysRoleService {

	/**
	 * 新增sysRole
	 * 
	 * @param sysRole
	 * @throws Exception
	 */
	public void addSysRole(SysRole sysRole) throws Exception;
	
	/**
	 * 删除sysRole
	 * 
	 * @param sysRole
	 */
	public void deleteSysRole(SysRole sysRole) throws Exception;
	
	/**
	 * 删除多个sysRole
	 * @param ids
	 */
	public void deleteSysRoles(String[] ids) throws Exception;
	
	/**
	 * 修改sysRole
	 * 
	 * @param sysRole
	 * @throws Exception
	 */
	public void editSysRole(SysRole sysRole) throws Exception;

	/**
	 * 根据id查询sysRole
	 * 
	 * @param sysRole
	 * @return
	 */
	public SysRole loadSysRole(SysRole sysRole);

	/**
	 * 分页查询sysRole
	 * 
	 * @param page
	 * @return
	 */
	public List<SysRole> findSysRolePage(Page page);
	
	/**
	 * 查询全部sysRole
	 * 
	 * @param pageData
	 * @return
	 */
	public List<SysRole> findSysRole(PageData pageData);
}
