package com.zong.web.common.controller;

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
import com.zong.web.common.bean.Demo;
import com.zong.web.common.service.DemoService;

/**
 * @desc 控制层 demo
 * @author zong
 * @date 2017年03月11日
 */
@Controller
@RequestMapping(value = "/demo")
public class DemoController extends BaseController {
	private final static Logger logger = LoggerFactory.getLogger(DemoController.class);
	@Autowired
	private DemoService demoService;

	/**
	 * 查询demo列表，测试thymeleaf渲染
	 */
	@RequestMapping(value = "/th/list")
	public String thlist(Model model) {
		Page page = super.getPage();
		model.addAttribute("demos", demoService.findDemoPage(page));
		return "/th/demo_list";
	}
	/**
	 * 查询demo列表
	 */
	@RequestMapping(value = "/list")
	public String list(Model model) {
		Page page = super.getPage();
		model.addAttribute("demos", demoService.findDemoPage(page));
		return "/demo/demo_list";
	}
	
	/**
	 * 新增demo页面
	 */
	@RequestMapping(value = "/toAdd")
	public String toAdd(Model model) {
		return "/demo/demo_form";
	}
	
	/**
	 * 修改demo页面
	 */
	@RequestMapping(value = "/toEdit")
	public String toEdit(Demo demo, Model model) {
		demo = demoService.loadDemo(demo);
		model.addAttribute("data", demo);
		model.addAttribute("formType", "edit");
		return "/demo/demo_form";
	}
	
	/**
	 * 新增demo
	 */
	@ResponseBody
	@RequestMapping(value = "/add")
	public PageData add(Demo demo, Model model) {
		PageData pd = new PageData("errMsg", "success");
		try {
			demoService.addDemo(demo);
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
	 * 修改demo
	 */
	@ResponseBody
	@RequestMapping(value = "/edit")
	public PageData edit(Demo demo, Model model) {
		PageData pd = new PageData("errMsg", "success");
		try {
			demoService.editDemo(demo);
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
	 * 删除demo
	 */
	@ResponseBody
	@RequestMapping(value = "/delete")
	public PageData delete(Demo demo) {
		PageData pd = new PageData("errMsg", "success");
		try {
			demoService.deleteDemo(demo);
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
     * 删除多个demo
     */
    @ResponseBody
    @RequestMapping(value = "/deleteAll")
    public PageData deleteAll() {
        PageData pd = new PageData("errMsg", "success");
        try {
            demoService.deleteDemos(getRequest().getParameterValues("id"));
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
	 * 查询demo详情data
	 */
	@ResponseBody
	@RequestMapping(value = "/data")
	public PageData data(Demo demo) {
		PageData pd = new PageData("errMsg", "success");
		demo = demoService.loadDemo(demo);
		pd.put("data", demo);
		return pd;
	}

	/**
	 * 查询demo列表datas
	 */
	@ResponseBody
	@RequestMapping(value = "/datas")
	public PageData datas() {
		PageData pd = new PageData("errMsg", "success");
		Page page = super.getPage();
		List<Demo> demos = demoService.findDemoPage(page);
		pd.put("data", demos).put("page", page);
		return pd;
	}
}
