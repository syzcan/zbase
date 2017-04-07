package com.zong.web.system.service;

import java.util.List;

import com.zong.util.Page;
import com.zong.util.PageData;
import com.zong.web.system.bean.SysUser;

/**
 * @desc sysUser业务接口类
 * @author zong
 * @date 2017年03月19日
 */
public interface SysUserService {

	/**
	 * 新增sysUser
	 * 
	 * @param sysUser
	 * @throws Exception
	 */
	public void addSysUser(SysUser sysUser) throws Exception;
	
	/**
	 * 删除sysUser
	 * 
	 * @param sysUser
	 */
	public void deleteSysUser(SysUser sysUser) throws Exception;
	
	/**
	 * 删除多个sysUser
	 * @param ids
	 */
	public void deleteSysUsers(String[] ids) throws Exception;
	
	/**
	 * 修改sysUser
	 * 
	 * @param sysUser
	 * @throws Exception
	 */
	public void editSysUser(SysUser sysUser) throws Exception;

	/**
	 * 根据id查询sysUser
	 * 
	 * @param sysUser
	 * @return
	 */
	public SysUser loadSysUser(SysUser sysUser);

	/**
	 * 分页查询sysUser
	 * 
	 * @param page
	 * @return
	 */
	public List<SysUser> findSysUserPage(Page page);
	
	/**
	 * 查询全部sysUser
	 * 
	 * @param pageData
	 * @return
	 */
	public List<SysUser> findSysUser(PageData pageData);

}
