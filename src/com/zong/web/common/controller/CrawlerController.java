package com.zong.web.common.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.zong.base.BaseController;
import com.zong.util.JsoupUtil;
import com.zong.util.Page;
import com.zong.util.PageData;
import com.zong.web.common.dao.CommonMapper;
import com.zong.web.common.service.CommonService;

@Controller
@RequestMapping("/crawler")
public class CrawlerController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(CrawlerController.class);
	private static final ObjectMapper objectMapper = new ObjectMapper();
	@Autowired
	private CommonMapper commonMapper;
	@Autowired
	private CommonService commonService;

	@RequestMapping(value = "/toCraw")
	public String toCraw(Model model) {
		List<PageData> rules = commonService.find(JsoupUtil.CRAW_RULE_TABLE, new PageData());
		model.addAttribute("rules", rules);
		return "/crawler/craw_form";
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
	@RequestMapping(value = "/detail")
	public PageData detail() {
		PageData result = new PageData("errMsg", "success");
		PageData request = super.getPageData();
		String craw_store = JsoupUtil.storeTable(request.getString(JsoupUtil.CRAW_STORE_TABLE));
		try {
			PageData data = JsoupUtil.parseDetail(request);
			commonService.edit(craw_store, data.put("status", 2),
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

	@RequestMapping(value = "/rule/list")
	public String rules(Model model) {
		try {
			List<PageData> rules = commonService.find(JsoupUtil.CRAW_RULE_TABLE, new PageData());
			model.addAttribute("rules", rules);
		} catch (Exception e) {
			logger.error(e.toString(), e);
			model.addAttribute("errMsg", "系统错误！");
		}
		return "/crawler/rule_list";
	}

	@RequestMapping(value = "/rule/toAdd")
	public String toAdd(Model model) {
		return "/crawler/rule_form";
	}

	@RequestMapping(value = "/rule/toEdit")
	public String toEdit(String id, Model model) {
		List<PageData> rules = commonService.find(JsoupUtil.CRAW_RULE_TABLE, new PageData("id", id));
		if (!rules.isEmpty()) {
			PageData data = rules.get(0);
			try {
				data.put("list_ext",
						objectMapper.readValue(data.getString("list_ext"), new TypeReference<List<PageData>>() {
						}));
				data.put("content_ext",
						objectMapper.readValue(data.getString("content_ext"), new TypeReference<List<PageData>>() {
						}));
			} catch (Exception e) {
				e.printStackTrace();
			}
			model.addAttribute("rule", data);
		}
		model.addAttribute("formType", "edit");
		return "/crawler/rule_form";
	}

	@ResponseBody
	@RequestMapping(value = "/rule/add")
	public PageData add(@RequestBody PageData data) {
		PageData result = new PageData("errMsg", "success");
		try {
			data.put("list_ext", objectMapper.writeValueAsString(data.get("list_ext")));
			data.put("content_ext", objectMapper.writeValueAsString(data.get("content_ext")));
			commonService.add(JsoupUtil.CRAW_RULE_TABLE, data);
			// 保存表结构
			saveStoreTable(data);
		} catch (Exception e) {
			logger.error(e.toString(), e);
			result.put("errMsg", "系统错误！");
		}
		return result;
	}

	private void saveStoreTable(PageData ruleData) throws Exception {
		String craw_store = ruleData.getString(JsoupUtil.CRAW_STORE_TABLE);
		craw_store = JsoupUtil.storeTable(craw_store);
		PageData pd = new PageData();
		List<PageData> list_ext = objectMapper.readValue(ruleData.getString("list_ext"),
				new TypeReference<List<PageData>>() {
				});
		List<PageData> content_ext = objectMapper.readValue(ruleData.getString("content_ext"),
				new TypeReference<List<PageData>>() {
				});
		for (PageData data : list_ext) {
			pd.put(data.getString(JsoupUtil.RULE_EXT_NAME), "");
		}
		for (PageData data : content_ext) {
			pd.put(data.getString(JsoupUtil.RULE_EXT_NAME), "");
		}
		pd.remove("");
		PageData table = commonService.findTable(craw_store);
		PageData columns = JsoupUtil.baseTableColumns(pd);
		if (table == null) {
			commonService.createTable(craw_store, columns);
		} else {
			commonService.alterTable(craw_store, columns);
		}
	}

	@ResponseBody
	@RequestMapping(value = "/rule/edit/{id}")
	public PageData edit(@PathVariable String id, @RequestBody PageData data) {
		PageData result = new PageData("errMsg", "success");
		try {
			data.put("list_ext", objectMapper.writeValueAsString(data.get("list_ext")));
			data.put("content_ext", objectMapper.writeValueAsString(data.get("content_ext")));
			commonService.edit(JsoupUtil.CRAW_RULE_TABLE, data, new PageData("id", id));
			// 保存表结构
			saveStoreTable(data);
		} catch (Exception e) {
			logger.error(e.toString(), e);
			result.put("errMsg", "系统错误！");
		}
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "/rule/delete")
	public PageData delete(String id) {
		PageData result = new PageData("errMsg", "success");
		try {
			commonService.delete(JsoupUtil.CRAW_RULE_TABLE, new PageData("id", id));
		} catch (Exception e) {
			logger.error(e.toString(), e);
			result.put("errMsg", "系统错误！");
		}
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "/rule/data")
	public PageData data(String id) {
		PageData result = new PageData("errMsg", "success");
		try {
			List<PageData> rules = commonService.find(JsoupUtil.CRAW_RULE_TABLE, new PageData("id", id));
			if (!rules.isEmpty()) {
				PageData data = rules.get(0);
				data.put("list_ext",
						objectMapper.readValue(data.getString("list_ext"), new TypeReference<List<PageData>>() {
						}));
				data.put("content_ext",
						objectMapper.readValue(data.getString("content_ext"), new TypeReference<List<PageData>>() {
						}));
				result.put("rule", data);
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
			result.put("errMsg", "系统错误！");
		}
		return result;
	}

	/**
	 * 查询是否可用craw_store
	 */
	@ResponseBody
	@RequestMapping(value = "/rule/check")
	public PageData check(String craw_store) {
		PageData pd = new PageData("errMsg", "success");
		List<PageData> datas = commonService.find(JsoupUtil.CRAW_RULE_TABLE, new PageData("craw_store", craw_store));
		if (!datas.isEmpty()) {
			pd.put("errMsg", "已存在");
		}
		return pd;
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
			PageData store = commonService.load(JsoupUtil.storeTable(craw_store), new PageData("id", id));
			model.addAttribute("store", store);
		} catch (Exception e) {
			logger.error(e.toString(), e);
			model.addAttribute("errMsg", "系统错误！");
		}
		return "/crawler/store_view";
	}
}
