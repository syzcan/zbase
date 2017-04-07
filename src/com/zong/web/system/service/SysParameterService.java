package com.zong.web.system.service;

import java.util.List;

import com.zong.web.system.bean.SysParameter;
import com.zong.util.Page;
import com.zong.util.PageData;

/**
 * @desc sysParameter业务接口类
 * @author zong
 * @date 2017年03月19日
 */
public interface SysParameterService {

	/**
	 * 新增sysParameter
	 * 
	 * @param sysParameter
	 * @throws Exception
	 */
	public void addSysParameter(SysParameter sysParameter) throws Exception;
	
	/**
	 * 删除sysParameter
	 * 
	 * @param sysParameter
	 */
	public void deleteSysParameter(SysParameter sysParameter) throws Exception;
	
	/**
	 * 删除多个sysParameter
	 * @param ids
	 */
	public void deleteSysParameters(String[] ids) throws Exception;
	
	/**
	 * 修改sysParameter
	 * 
	 * @param sysParameter
	 * @throws Exception
	 */
	public void editSysParameter(SysParameter sysParameter) throws Exception;

	/**
	 * 根据id查询sysParameter
	 * 
	 * @param sysParameter
	 * @return
	 */
	public SysParameter loadSysParameter(SysParameter sysParameter);

	/**
	 * 分页查询sysParameter
	 * 
	 * @param page
	 * @return
	 */
	public List<SysParameter> findSysParameterPage(Page page);
	
	/**
	 * 查询全部sysParameter
	 * 
	 * @param pageData
	 * @return
	 */
	public List<SysParameter> findSysParameter(PageData pageData);
}
