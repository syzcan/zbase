package com.zong.web.system.service;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zong.util.Page;
import com.zong.util.PageData;
import com.zong.web.system.bean.SysRole;
import com.zong.web.system.bean.SysUser;
import com.zong.web.system.bean.SysUserRole;
import com.zong.web.system.dao.SysUserMapper;
import com.zong.web.system.dao.SysUserRoleMapper;

/**
 * @desc sysUser业务实现类
 * @author zong
 * @date 2017年03月19日
 */
@Service
public class SysUserServiceImpl implements SysUserService {
	@Autowired
	private SysUserMapper sysUserMapper;
	@Autowired
	private SysUserRoleMapper userRoleMapper;

	/**
	 * 新增sysUser
	 * 
	 * @param sysUser
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public void addSysUser(SysUser sysUser) throws Exception {
		sysUser.setId(UUID.randomUUID().toString().trim().replaceAll("-", ""));
		sysUser.setCreateTime(new Date());
		sysUser.setUpdateTime(new Date());
		sysUserMapper.insert(sysUser);
		//保存角色
		saveUserRole(sysUser);
	}
	
	/**
	 * 删除sysUser
	 * 
	 * @param sysUser
	 */
	@Transactional(rollbackFor = Exception.class)
	public void deleteSysUser(SysUser sysUser) throws Exception {
		sysUserMapper.delete(sysUser);
		//删除role
		userRoleMapper.deleteByUser(sysUser.getId());
	}
	
	/**
	 * 删除多个sysUser
	 * @param ids
	 */
	public void deleteSysUsers(String[] ids) throws Exception {
		if(ids!=null && ids.length>0){
			SysUser sysUser = new SysUser();
			for (String id : ids) {
				sysUser.setId(id);
				sysUserMapper.delete(sysUser);
				//删除role
				userRoleMapper.deleteByUser(sysUser.getId());
			}
		}
	}

	/**
	 * 修改sysUser
	 * 
	 * @param sysUser
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public void editSysUser(SysUser sysUser) throws Exception {
		sysUser.setUpdateTime(new Date());
		sysUserMapper.update(sysUser);
		//先删除role再添加
		userRoleMapper.deleteByUser(sysUser.getId());
		saveUserRole(sysUser);
	}
	
	private void saveUserRole(SysUser sysUser){
		List<SysRole> roles = sysUser.getRoles();
		if(roles==null){
			return;
		}
		for (SysRole role : roles) {
			if(role.getId()==null){
				continue;
			}
			SysUserRole userRole = new SysUserRole();
			userRole.setId(UUID.randomUUID().toString().trim().replaceAll("-", ""));
			userRole.setUserId(sysUser.getId());
			userRole.setRoleId(role.getId());
			userRoleMapper.insert(userRole);
		}
	}

	/**
	 * 根据id查询sysUser
	 * 
	 * @param sysUser
	 * @return
	 */
	public SysUser loadSysUser(SysUser sysUser) {
		return sysUserMapper.load(sysUser);
	}

	/**
	 * 分页查询sysUser
	 * 
	 * @param page
	 * @return
	 */
	public List<SysUser> findSysUserPage(Page page) {
		return sysUserMapper.findSysUserPage(page);
	}
	
	/**
	 * 查询全部sysUser
	 * 
	 * @param pageData
	 * @return
	 */
	public List<SysUser> findSysUser(PageData pageData) {
		return sysUserMapper.findSysUser(pageData);
	}
}