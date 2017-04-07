package com.zong.web.system.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zong.base.BaseController;
import com.zong.util.BusinessException;
import com.zong.util.Page;
import com.zong.util.PageData;
import com.zong.util.ZConst;
import com.zong.web.common.dao.CommonMapper;
import com.zong.web.system.bean.SysParameter;
import com.zong.web.system.service.SysParameterService;

/**
 * @desc sysParameter控制层 系统参数表
 * @author zong
 * @date 2017年03月19日
 */
@Controller
@RequestMapping(value = "/sysParameter")
public class SysParameterController extends BaseController {
	private final static Logger logger = LoggerFactory.getLogger(SysParameterController.class);

	@Autowired
	private SysParameterService sysParameterService;
	@Autowired
	private CommonMapper commonMapper;

	/**
	 * 查询sysParameter列表
	 */
	@RequestMapping(value = "/list")
	public String list(Model model) {
		Page page = super.getPage();
		model.addAttribute("sysParameters", sysParameterService.findSysParameterPage(page));
		return "/system/sysParameter_list";
	}

	/**
	 * 新增sysParameter页面
	 */
	@RequestMapping(value = "/toAdd")
	public String toAdd(Model model) {
		return "/system/sysParameter_form";
	}

	/**
	 * 新增sysParameter
	 */
	@ResponseBody
	@RequestMapping(value = "/add")
	public PageData add(SysParameter sysParameter, Model model) {
		PageData pd = new PageData("errMsg", "success");
		try {
			sysParameterService.addSysParameter(sysParameter);
		} catch (BusinessException e) {
			logger.warn(e.getErrMsg());
			pd.put("errMsg", e.getErrMsg());
		} catch (Exception e) {
			logger.error(e.toString(), e);
			pd.put("errMsg", "系统错误！");
		}
		return pd;
	}

	/**
	 * 修改sysParameter页面
	 */
	@RequestMapping(value = "/toEdit")
	public String toEdit(SysParameter sysParameter, Model model) {
		sysParameter = sysParameterService.loadSysParameter(sysParameter);
		model.addAttribute("sysParameter", sysParameter);
		model.addAttribute("formType", "edit");
		return "/system/sysParameter_form";
	}

	/**
	 * 修改sysParameter
	 */
	@ResponseBody
	@RequestMapping(value = "/edit")
	public PageData edit(SysParameter sysParameter, Model model) {
		PageData pd = new PageData("errMsg", "success");
		try {
			sysParameterService.editSysParameter(sysParameter);
			// 更新application缓存参数
			PageData zparam = (PageData) getApplication().getAttribute(ZConst.ZPARAM);
			zparam.put(sysParameter.getParamKey(),
					new PageData("name", sysParameter.getName()).put("param_key", sysParameter.getParamKey())
							.put("param_value", sysParameter.getParamValue()).put("remark", sysParameter.getRemark()));
		} catch (BusinessException e) {
			logger.warn(e.getErrMsg());
			pd.put("errMsg", e.getErrMsg());
		} catch (Exception e) {
			logger.error(e.toString(), e);
			pd.put("errMsg", "系统错误！");
		}
		return pd;
	}

	/**
	 * 删除sysParameter
	 */
	@ResponseBody
	@RequestMapping(value = "/delete")
	public PageData delete(SysParameter sysParameter) {
		PageData pd = new PageData("errMsg", "success");
		try {
			sysParameterService.deleteSysParameter(sysParameter);
		} catch (BusinessException e) {
			logger.warn(e.getErrMsg());
			pd.put("errMsg", e.getErrMsg());
		} catch (Exception e) {
			logger.error(e.toString(), e);
			pd.put("errMsg", "系统错误！");
		}
		return pd;
	}

	/**
	 * 删除多个sysParameter
	 */
	@ResponseBody
	@RequestMapping(value = "/deleteAll")
	public PageData deleteAll() {
		PageData pd = new PageData("errMsg", "success");
		try {
			sysParameterService.deleteSysParameters(getRequest().getParameterValues("id"));
		} catch (BusinessException e) {
			logger.warn(e.getErrMsg());
			pd.put("errMsg", e.getErrMsg());
		} catch (Exception e) {
			logger.error(e.toString(), e);
			pd.put("errMsg", "系统错误！");
		}
		return pd;
	}

	/**
	 * 查询sysParameter详情data
	 */
	@ResponseBody
	@RequestMapping(value = "/data")
	public PageData data(SysParameter sysParameter) {
		PageData pd = new PageData("errMsg", "success");
		sysParameter = sysParameterService.loadSysParameter(sysParameter);
		pd.put("data", sysParameter);
		return pd;
	}

	/**
	 * 查询sysParameter列表datas
	 */
	@ResponseBody
	@RequestMapping(value = "/datas")
	public PageData datas() {
		PageData pd = new PageData("errMsg", "success");
		Page page = super.getPage();
		List<SysParameter> sysParameters = sysParameterService.findSysParameterPage(page);
		pd.put("data", sysParameters).put("page", page);
		return pd;
	}

	/**
	 * 查询sysParameter是否可用key
	 */
	@ResponseBody
	@RequestMapping(value = "/check")
	public PageData check(SysParameter sysParameter) {
		PageData pd = new PageData("errMsg", "success");
		List<PageData> datas = commonMapper.find("sys_parameter",
				new PageData("param_key", sysParameter.getParamKey()));
		if (!datas.isEmpty()) {
			pd.put("errMsg", "已存在");
			if (sysParameter.getId() != null && !sysParameter.getId().equals("")) {
				PageData data = datas.get(0);
				if (sysParameter.getId().equals(data.getString("id"))) {
					pd.put("errMsg", "success");
				}
			}
		}
		return pd;
	}
}
