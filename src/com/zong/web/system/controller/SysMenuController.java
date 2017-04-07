package com.zong.web.system.controller;
 
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zong.base.BaseController;
import com.zong.util.BusinessException;
import com.zong.util.PageData;
import com.zong.web.system.bean.SysMenu;
import com.zong.web.system.service.SysMenuService;
 
/**
 * @desc sysMenu控制层 系统菜单表
 * @author zong
 * @date 2017年03月19日
 */
@Controller
@RequestMapping(value = "/sysMenu")
public class SysMenuController extends BaseController {
    private final static Logger logger = LoggerFactory.getLogger(SysMenuController.class);
 
    @Autowired
    private SysMenuService sysMenuService;
 
    /**
     * 查询sysMenu列表
     */
    @RequestMapping(value = "/list")
    public String list(Model model) {
        model.addAttribute("sysMenus", sysMenuService.packageMenu(sysMenuService.findSysMenu(new PageData())));
        return "/system/sysMenu_list";
    }
    
    
     
    /**
     * 新增sysMenu页面
     */
    @RequestMapping(value = "/toAdd")
    public String toAdd(Model model) {
    	model.addAttribute("sysMenus", sysMenuService.packageMenu(sysMenuService.findSysMenu(new PageData())));
        return "/system/sysMenu_form";
    }
 
    /**
     * 新增sysMenu
     */
    @ResponseBody
    @RequestMapping(value = "/add")
    public PageData add(SysMenu sysMenu, Model model) {
        PageData pd = new PageData("errMsg", "success");
        try {
            sysMenuService.addSysMenu(sysMenu);
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
     * 修改sysMenu页面
     */
    @RequestMapping(value = "/toEdit")
    public String toEdit(SysMenu sysMenu, Model model) {
        sysMenu = sysMenuService.loadSysMenu(sysMenu);
        model.addAttribute("sysMenu", sysMenu);
        model.addAttribute("sysMenus", sysMenuService.packageMenu(sysMenuService.findSysMenu(new PageData())));
        model.addAttribute("formType", "edit");
        return "/system/sysMenu_form";
    }
 
    /**
     * 修改sysMenu
     */
    @ResponseBody
    @RequestMapping(value = "/edit")
    public PageData edit(SysMenu sysMenu, Model model) {
        PageData pd = new PageData("errMsg", "success");
        try {
            sysMenuService.editSysMenu(sysMenu);
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
     * 删除sysMenu
     */
    @ResponseBody
    @RequestMapping(value = "/delete")
    public PageData delete(SysMenu sysMenu) {
        PageData pd = new PageData("errMsg", "success");
        try {
            sysMenuService.deleteSysMenu(sysMenu);
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
     * 删除多个sysMenu
     */
    @ResponseBody
    @RequestMapping(value = "/deleteAll")
    public PageData deleteAll() {
        PageData pd = new PageData("errMsg", "success");
        try {
            sysMenuService.deleteSysMenus(getRequest().getParameterValues("id"));
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
     * 查询sysMenu详情data
     */
    @ResponseBody
    @RequestMapping(value = "/data")
    public PageData data(SysMenu sysMenu) {
        PageData pd = new PageData("errMsg", "success");
        sysMenu = sysMenuService.loadSysMenu(sysMenu);
        pd.put("data", sysMenu);
        return pd;
    }
 
    /**
     * 查询sysMenu列表datas
     */
    @ResponseBody
    @RequestMapping(value = "/datas")
    public PageData datas() {
        PageData pd = new PageData("errMsg", "success");
        pd.put("data", sysMenuService.findSysMenu(new PageData()));
        return pd;
    }  
}