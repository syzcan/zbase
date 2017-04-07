package com.zong.web.system.service;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zong.util.Page;
import com.zong.util.PageData;
import com.zong.web.system.bean.SysMenu;
import com.zong.web.system.bean.SysRole;
import com.zong.web.system.bean.SysRoleMenu;
import com.zong.web.system.dao.SysRoleMapper;
import com.zong.web.system.dao.SysRoleMenuMapper;
import com.zong.web.system.dao.SysUserRoleMapper;

/**
 * @desc sysRole业务实现类
 * @author zong
 * @date 2017年03月19日
 */
@Service
public class SysRoleServiceImpl implements SysRoleService {
	@Autowired
	private SysRoleMapper sysRoleMapper;
	@Autowired
	private SysRoleMenuMapper roleMenuMapper;
	@Autowired
	private SysUserRoleMapper userRoleMapper;

	/**
	 * 新增sysRole
	 * 
	 * @param sysRole
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public void addSysRole(SysRole sysRole) throws Exception {
		sysRole.setId(UUID.randomUUID().toString().trim().replaceAll("-", ""));
		sysRole.setCreateTime(new Date());
		sysRoleMapper.insert(sysRole);
		//保存菜单
		saveRoleMenu(sysRole);
	}
	
	/**
	 * 删除sysRole
	 * 
	 * @param sysRole
	 */
	@Transactional(rollbackFor = Exception.class)
	public void deleteSysRole(SysRole sysRole) throws Exception {
		sysRoleMapper.delete(sysRole);
		//删除roleMenu
		roleMenuMapper.deleteByRole(sysRole.getId());
		//删除userRole
		userRoleMapper.deleteByRole(sysRole.getId());
	}
	
	/**
	 * 删除多个sysRole
	 * @param ids
	 */
	public void deleteSysRoles(String[] ids) throws Exception {
		if(ids!=null && ids.length>0){
			SysRole sysRole = new SysRole();
			for (String id : ids) {
				sysRole.setId(id);
				deleteSysRole(sysRole);
			}
		}
	}

	/**
	 * 修改sysRole
	 * 
	 * @param sysRole
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public void editSysRole(SysRole sysRole) throws Exception {
		sysRoleMapper.update(sysRole);
		//先删除roleMenu再添加
		roleMenuMapper.deleteByRole(sysRole.getId());
		saveRoleMenu(sysRole);
	}
	
	private void saveRoleMenu(SysRole sysRole){
		List<SysMenu> menus = sysRole.getMenus();
		if(menus==null){
			return;
		}
		for (SysMenu sysMenu : menus) {
			SysRoleMenu roleMenu = new SysRoleMenu();
			roleMenu.setId(UUID.randomUUID().toString().trim().replaceAll("-", ""));
			roleMenu.setMenuId(sysMenu.getId());
			roleMenu.setRoleId(sysRole.getId());
			roleMenuMapper.insert(roleMenu);
		}
	}

	/**
	 * 根据id查询sysRole
	 * 
	 * @param sysRole
	 * @return
	 */
	public SysRole loadSysRole(SysRole sysRole) {
		return sysRoleMapper.load(sysRole);
	}

	/**
	 * 分页查询sysRole
	 * 
	 * @param page
	 * @return
	 */
	public List<SysRole> findSysRolePage(Page page) {
		return sysRoleMapper.findSysRolePage(page);
	}
	
	/**
	 * 查询全部sysRole
	 * 
	 * @param pageData
	 * @return
	 */
	public List<SysRole> findSysRole(PageData pageData) {
		return sysRoleMapper.findSysRole(pageData);
	}
}