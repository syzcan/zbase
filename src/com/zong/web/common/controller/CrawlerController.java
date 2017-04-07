package com.zong.web.common.controller;

import java.util.Date;
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
import com.spreada.utils.chinese.ZHConverter;
import com.zong.base.BaseController;
import com.zong.util.JsoupUtil;
import com.zong.util.Page;
import com.zong.util.PageData;
import com.zong.web.common.dao.CommonMapper;

@Controller
@RequestMapping("/crawler")
public class CrawlerController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(CrawlerController.class);
	private static final ObjectMapper objectMapper = new ObjectMapper();
	private static final ZHConverter converter = ZHConverter.getInstance(ZHConverter.SIMPLIFIED);
	@Autowired
	private CommonMapper commonMapper;

	@RequestMapping(value = "/toCraw")
	public String toCraw(Model model) {
		List<PageData> rules = commonMapper.find(JsoupUtil.CRAW_RULE_TABLE, new PageData());
		model.addAttribute("rules", rules);
		return "/crawler/craw_form";
	}

	@RequestMapping(value = "/toCrawDetail")
	public String toCrawDetail(Model model) {
		Page page = new Page();
		page.setTable(JsoupUtil.CRAW_STORE_TABLE);
		String[] columns = { "id", "title", "url", "rule_id", "status" };
		page.getPd().put("status", 1).put("columns", columns);
		List<PageData> stores = commonMapper.findPage(page);
		model.addAttribute("stores", stores);
		return "/crawler/craw_detail";
	}

	@ResponseBody
	@RequestMapping(value = "/list")
	public PageData list() {
		PageData result = new PageData("errMsg", "success");
		try {
			PageData request = super.getPageData();
			String rule_id = (String) request.remove("rule_id");
			result.put(JsoupUtil.CRAW_URL, request.getString(JsoupUtil.CRAW_URL));
			List<PageData> datas = JsoupUtil.parseList(request);
			for (PageData data : datas) {
				try {
					commonMapper.insert(JsoupUtil.CRAW_STORE_TABLE,
							new PageData("title", converter.convert(data.getString("title")))
									.put("url", data.getString("url")).put("create_time", new Date()).put("status", 1)
									.put("rule_id", rule_id));
				} catch (Exception e) {
					logger.warn(e.toString());
				}
				PageData pd = commonMapper.find(JsoupUtil.CRAW_STORE_TABLE, new PageData("url", data.getString("url")))
						.get(0);
				data.put("status", pd.getString("status"));
			}
			logger.info("爬取并保存列表条目 {}", request.getString(JsoupUtil.CRAW_URL));
			result.put("data", datas);
			result.put("next_url", request.getString("next_url"));
		} catch (Exception e) {
			logger.error(e.toString(), e);
			result.put("errMsg", "系统错误！");
		}
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "/detail")
	public PageData detail() {
		PageData result = new PageData("errMsg", "success");
		PageData request = super.getPageData();
		try {
			PageData data = JsoupUtil.parseDetail(request);
			commonMapper.update(JsoupUtil.CRAW_STORE_TABLE,
					new PageData("status", 2).put("content", converter.convert(objectMapper.writeValueAsString(data))),
					new PageData("url", request.getString(JsoupUtil.CRAW_URL)));
			logger.info("爬取并保存 {}", request.getString(JsoupUtil.CRAW_URL));
		} catch (Exception e) {
			logger.error(e.toString(), e);
			result.put("errMsg", "系统错误！");
			commonMapper.update(JsoupUtil.CRAW_STORE_TABLE, new PageData("status", 3),
					new PageData("url", request.getString(JsoupUtil.CRAW_URL)));
		}
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "/data")
	public PageData data() {
		PageData result = new PageData("errMsg", "success");
		PageData request = super.getPageData();
		try {
			PageData data = JsoupUtil.parseDetail(request);
			result.put("data", data);
			result.put(JsoupUtil.CRAW_URL, request.getString(JsoupUtil.CRAW_URL));
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return result;
	}

	@RequestMapping(value = "/rule/list")
	public String rules(Model model) {
		try {
			List<PageData> rules = commonMapper.find(JsoupUtil.CRAW_RULE_TABLE, new PageData());
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
		List<PageData> rules = commonMapper.find(JsoupUtil.CRAW_RULE_TABLE, new PageData("id", id));
		if (!rules.isEmpty()) {
			PageData data = rules.get(0);
			try {
				data.put("rule_ext",
						objectMapper.readValue(data.getString("rule_ext"), new TypeReference<List<PageData>>() {
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
			data.put("rule_ext", objectMapper.writeValueAsBytes(data.get("rule_ext")));
			commonMapper.insert(JsoupUtil.CRAW_RULE_TABLE, data);
		} catch (Exception e) {
			logger.error(e.toString(), e);
			result.put("errMsg", "系统错误！");
		}
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "/rule/edit/{id}")
	public PageData edit(@PathVariable String id, @RequestBody PageData data) {
		PageData result = new PageData("errMsg", "success");
		try {
			data.put("rule_ext", objectMapper.writeValueAsBytes(data.get("rule_ext")));
			commonMapper.update(JsoupUtil.CRAW_RULE_TABLE, data, new PageData("id", id));
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
			commonMapper.delete(JsoupUtil.CRAW_RULE_TABLE, new PageData("id", id));
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
			List<PageData> rules = commonMapper.find(JsoupUtil.CRAW_RULE_TABLE, new PageData("id", id));
			if (!rules.isEmpty()) {
				PageData data = rules.get(0);
				data.put("rule_ext",
						objectMapper.readValue(data.getString("rule_ext"), new TypeReference<List<PageData>>() {
						}));
				result.put("rule", data);
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
			result.put("errMsg", "系统错误！");
		}
		return result;
	}

	@RequestMapping(value = "/store/list")
	public String stores(Model model) {
		try {
			Page page = super.getPage();
			page.setTable(JsoupUtil.CRAW_STORE_TABLE);
			String keyword = (String) page.getPd().remove("keyword");
			if (keyword != null) {
				page.getPd().put("like", new PageData("content", keyword));
			}
			String[] columns = { "id", "title", "url", "rule_id", "status" };
			page.getPd().put("columns", columns);
			List<PageData> stores = commonMapper.findPage(page);
			model.addAttribute("stores", stores);
		} catch (Exception e) {
			logger.error(e.toString(), e);
			model.addAttribute("errMsg", "系统错误！");
		}
		return "/crawler/store_list";
	}

	@RequestMapping(value = "/store/view")
	public String store(String id, Model model) {
		try {
			List<PageData> stores = commonMapper.find(JsoupUtil.CRAW_STORE_TABLE, new PageData("id", id));
			PageData store = stores.get(0);
			store.put("content", objectMapper.readValue(store.getString("content"), PageData.class));
			model.addAttribute("store", store);
		} catch (Exception e) {
			logger.error(e.toString(), e);
			model.addAttribute("errMsg", "系统错误！");
		}
		return "/crawler/store_view";
	}
}
