package com.zong.web.system.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zong.web.system.bean.SysMenu;
import com.zong.web.system.bean.SysRoleMenu;
import com.zong.web.system.dao.SysMenuMapper;
import com.zong.web.system.dao.SysRoleMenuMapper;
import com.zong.util.Page;
import com.zong.util.PageData;

/**
 * @desc sysMenu业务实现类
 * @author zong
 * @date 2017年03月19日
 */
@Service
public class SysMenuServiceImpl implements SysMenuService {
	@Autowired
	private SysMenuMapper sysMenuMapper;
	@Autowired
	private SysRoleMenuMapper roleMenuMapper; 

	/**
	 * 新增sysMenu
	 * 
	 * @param sysMenu
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public void addSysMenu(SysMenu sysMenu) throws Exception {
		sysMenu.setId(UUID.randomUUID().toString().trim().replaceAll("-", ""));
		sysMenu.setCreateTime(new Date());
		sysMenu.setUpdateTime(new Date());
		sysMenuMapper.insert(sysMenu);
	}
	
	/**
	 * 删除sysMenu
	 * 
	 * @param sysMenu
	 */
	@Transactional(rollbackFor = Exception.class)
	public void deleteSysMenu(SysMenu sysMenu) throws Exception {
		sysMenuMapper.delete(sysMenu);
		//删除roleMenu
		roleMenuMapper.deleteByMenu(sysMenu.getId());
	}
	
	/**
	 * 删除多个sysMenu
	 * @param ids
	 */
	public void deleteSysMenus(String[] ids) throws Exception {
		if(ids!=null && ids.length>0){
			SysMenu sysMenu = new SysMenu();
			for (String id : ids) {
				sysMenu.setId(id);
				deleteSysMenu(sysMenu);
			}
		}
	}

	/**
	 * 修改sysMenu
	 * 
	 * @param sysMenu
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public void editSysMenu(SysMenu sysMenu) throws Exception {
		sysMenu.setUpdateTime(new Date());
		sysMenuMapper.update(sysMenu);
	}

	/**
	 * 根据id查询sysMenu
	 * 
	 * @param sysMenu
	 * @return
	 */
	public SysMenu loadSysMenu(SysMenu sysMenu) {
		return sysMenuMapper.load(sysMenu);
	}

	/**
	 * 分页查询sysMenu
	 * 
	 * @param page
	 * @return
	 */
	public List<SysMenu> findSysMenuPage(Page page) {
		return sysMenuMapper.findSysMenuPage(page);
	}
	
	/**
	 * 查询全部sysMenu
	 * 
	 * @param pageData
	 * @return
	 */
	public List<SysMenu> findSysMenu(PageData pageData) {
		return sysMenuMapper.findSysMenu(pageData);
	}

	public List<SysMenu> packageMenu(List<SysMenu> menus){
    	List<SysMenu> firstList = new ArrayList<>();
    	List<SysMenu> secondList = new ArrayList<>();
    	Iterator<SysMenu> iterator = menus.iterator();
		// 筛选一级菜单
		while (iterator.hasNext()) {
			SysMenu sysMenu = iterator.next();
			if (sysMenu.getPid().equals("0")) {
				firstList.add(sysMenu);
				iterator.remove();
			}
		}
		// 封装二级菜单到一级菜单下
		for (SysMenu parentMenu : firstList) {
			iterator = menus.iterator();
			while (iterator.hasNext()) {
				SysMenu childMenu = iterator.next();
				if (childMenu.getPid().equals(parentMenu.getId())) {
					//添加的secondList用于下面三级菜单进行封装
					secondList.add(childMenu);
					parentMenu.getChildMenus().add(childMenu);
					iterator.remove();
				}
			}
		}
		// 封装三级菜单到二级菜单下
		for (SysMenu parentMenu : secondList) {
			iterator = menus.iterator();
			while (iterator.hasNext()) {
				SysMenu childMenu = iterator.next();
				if (childMenu.getPid().equals(parentMenu.getId())) {
					parentMenu.getChildMenus().add(childMenu);
				}
			}
		}
    	return firstList;
    }

	@Override
	public List<SysMenu> findRoleMenu(PageData pd) {
		//查询全部封装
		List<SysMenu> menus = sysMenuMapper.findSysMenu(new PageData());
		//查询当前角色绑定的菜单，标记选中
		List<SysRoleMenu> roleMenus = roleMenuMapper.findSysRoleMenu(pd);
		for (SysRoleMenu sysRoleMenu : roleMenus) {
			for (SysMenu sysMenu : menus) {
				if(sysMenu.getId().equals(sysRoleMenu.getMenuId())){
					sysMenu.setChecked(true);
					break;
				}
			}
		}
		return menus;
	}
	
}