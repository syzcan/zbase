package com.zong.web.system.service;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zong.web.system.bean.SysParameter;
import com.zong.web.system.dao.SysParameterMapper;
import com.zong.util.Page;
import com.zong.util.PageData;

/**
 * @desc sysParameter业务实现类
 * @author zong
 * @date 2017年03月19日
 */
@Service
public class SysParameterServiceImpl implements SysParameterService {
	@Autowired
	private SysParameterMapper sysParameterMapper;

	/**
	 * 新增sysParameter
	 * 
	 * @param sysParameter
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public void addSysParameter(SysParameter sysParameter) throws Exception {
		sysParameter.setId(UUID.randomUUID().toString().trim().replaceAll("-", ""));
		sysParameter.setCreateTime(new Date());
		sysParameterMapper.insert(sysParameter);
	}
	
	/**
	 * 删除sysParameter
	 * 
	 * @param sysParameter
	 */
	@Transactional(rollbackFor = Exception.class)
	public void deleteSysParameter(SysParameter sysParameter) throws Exception {
		sysParameterMapper.delete(sysParameter);
	}
	
	/**
	 * 删除多个sysParameter
	 * @param ids
	 */
	public void deleteSysParameters(String[] ids) throws Exception {
		if(ids!=null && ids.length>0){
			SysParameter sysParameter = new SysParameter();
			for (String id : ids) {
				sysParameter.setId(id);
				sysParameterMapper.delete(sysParameter);
			}
		}
	}

	/**
	 * 修改sysParameter
	 * 
	 * @param sysParameter
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public void editSysParameter(SysParameter sysParameter) throws Exception {
		sysParameterMapper.update(sysParameter);
	}

	/**
	 * 根据id查询sysParameter
	 * 
	 * @param sysParameter
	 * @return
	 */
	public SysParameter loadSysParameter(SysParameter sysParameter) {
		return sysParameterMapper.load(sysParameter);
	}

	/**
	 * 分页查询sysParameter
	 * 
	 * @param page
	 * @return
	 */
	public List<SysParameter> findSysParameterPage(Page page) {
		return sysParameterMapper.findSysParameterPage(page);
	}
	
	/**
	 * 查询全部sysParameter
	 * 
	 * @param pageData
	 * @return
	 */
	public List<SysParameter> findSysParameter(PageData pageData) {
		return sysParameterMapper.findSysParameter(pageData);
	}
}