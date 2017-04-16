package com.zong.web.common.controller;

import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zong.base.BaseController;
import com.zong.util.JsoupUtil;
import com.zong.util.Page;
import com.zong.util.PageData;
import com.zong.web.common.dao.CommonMapper;
import com.zong.web.common.service.CommonService;

@Controller
@RequestMapping("/craw")
public class CrawController extends BaseController {
	private Logger logger = LoggerFactory.getLogger(CommonController.class);
	@Autowired
	private CommonService commonService;
	@Autowired
	private CommonMapper commonMapper;

	/**
	 * 解析任何页面
	 * 
	 * @param craw_url 抓取地址【必须】
	 * @param exts 非craw_*关键参数的其他扩展规则
	 */
	@ResponseBody
	@RequestMapping("/data")
	public PageData data() {
		PageData result = new PageData("errMsg", "success");
		try {
			PageData pd = super.getPageData();
			PageData data = JsoupUtil.parseDetail(pd);
			result.put("data", data);
		} catch (Exception e) {
			logger.error(e.toString(), e);
			result.put("errMsg", "系统错误");
		}
		return result;
	}

	/**
	 * 解析列表页面
	 * 
	 * @param craw_url 抓取地址【必须】
	 * @param craw_item 条目规则【必须】
	 * @param craw_next 下一页规则
	 * @param craw_store 存储表名，只有指定才保存到数据库
	 * @param exts 非craw_*关键参数的其他扩展规则
	 */
	@ResponseBody
	@RequestMapping("/crawList")
	public PageData crawList() {
		PageData result;
		try {
			PageData pd = super.getPageData();
			result = JsoupUtil.parseList(pd);
			saveData(pd, (List<PageData>) result.get("data"));
			result.put("errMsg", "success");
		} catch (Exception e) {
			logger.error(e.toString(), e);
			result = new PageData("errMsg", "系统错误");
		}
		return result;
	}

	private void saveData(PageData pd, List<PageData> data) throws Exception {
		String craw_store = pd.getString(JsoupUtil.CRAW_STORE_TABLE);
		if (craw_store != null && !"".equals(craw_store)) {
			craw_store = JsoupUtil.storeTable(craw_store);
			for (PageData pageData : data) {
				try {
					pageData.put(JsoupUtil.STORE_TABLE_COL_CREATE_TIME, new Date());
					commonService.add(craw_store, pageData);
					logger.info("抓取插入 {} : {}", craw_store, pageData.get("url"));
				} catch (Exception e) {
					logger.warn(e.toString());
				}
			}
		}
	}

	@RequestMapping(value = "/toCrawList")
	public String toCrawList(Model model) {
		List<PageData> rules = commonService.find(JsoupUtil.CRAW_RULE_TABLE, new PageData());
		model.addAttribute("rules", rules);
		return "/crawler/craw_list";
	}

	@RequestMapping(value = "/toCrawDetail")
	public String toCrawDetail(String craw_store, Model model) {
		Page page = new Page();
		page.setTable(JsoupUtil.storeTable(craw_store));
		String[] columns = { "id", "title", "url", "status" };
		page.getPd().put("status", 1).put("columns", columns);
		List<PageData> stores = commonService.findPage(page);
		model.addAttribute("stores", stores);
		model.addAttribute("page", page);
		return "/crawler/craw_detail";
	}

	@ResponseBody
	@RequestMapping(value = "/crawDetail")
	public PageData crawDetail() {
		PageData result = new PageData("errMsg", "success");
		PageData request = super.getPageData();
		String craw_store = JsoupUtil.storeTable(request.getString(JsoupUtil.CRAW_STORE_TABLE));
		try {
			PageData data = JsoupUtil.parseDetail(request);
			commonService.edit(craw_store, data.put("status", 2).put(JsoupUtil.STORE_TABLE_COL_UPDATE_TIME, new Date()),
					new PageData("url", request.getString(JsoupUtil.CRAW_URL)));
			logger.info("爬取并保存 {}", request.getString(JsoupUtil.CRAW_URL));
		} catch (Exception e) {
			logger.error(e.toString(), e);
			result.put("errMsg", "系统错误！");
			commonMapper.update(craw_store, new PageData("status", 3),
					new PageData("url", request.getString(JsoupUtil.CRAW_URL)));
		}
		return result;
	}

	@RequestMapping(value = "/store/list")
	public String stores(Model model) {
		try {
			List<PageData> rules = commonService.find(JsoupUtil.CRAW_RULE_TABLE, new PageData());
			Page page = super.getPage();
			String keyword = (String) page.getPd().remove("keyword");
			String craw_store = (String) page.getPd().remove(JsoupUtil.CRAW_STORE_TABLE);
			if (keyword != null) {
				page.getPd().put("like", new PageData("content", keyword));
			}
			if (craw_store == null) {
				if (!rules.isEmpty()) {
					String table = rules.get(0).getString(JsoupUtil.CRAW_STORE_TABLE);
					craw_store = JsoupUtil.storeTable(table);
					getPageData().put("craw_store", table);
				} else {
					craw_store = JsoupUtil.CRAW_STORE_TABLE;
				}
			} else {
				craw_store = JsoupUtil.storeTable(craw_store);
			}
			page.setTable(craw_store);
			String[] columns = { "id", "title", "url", "status" };
			page.getPd().put("columns", columns);
			List<PageData> stores = commonService.findPage(page);
			model.addAttribute("stores", stores);
			model.addAttribute("rules", rules);
		} catch (Exception e) {
			logger.error(e.toString(), e);
			model.addAttribute("errMsg", "系统错误！");
		}
		return "/crawler/store_list";
	}

	@RequestMapping(value = "/store/view")
	public String store(String craw_store, String id, Model model) {
		try {
			String tableName = JsoupUtil.storeTable(craw_store);
			PageData store = commonService.load(tableName, new PageData("id", id));
			model.addAttribute("table", commonService.showTable(tableName));
			model.addAttribute("store", store);
		} catch (Exception e) {
			logger.error(e.toString(), e);
			model.addAttribute("errMsg", "系统错误！");
		}
		return "/crawler/store_view";
	}
}
