package com.zong.web.common.controller;

import java.util.ArrayList;
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
import com.zong.util.JsoupUtil;
import com.zong.util.PageData;
import com.zong.web.common.service.CommonService;
import com.zong.zdb.bean.Table;

@Controller
@RequestMapping("/craw")
public class CrawRuleController {
	private static final Logger logger = LoggerFactory.getLogger(CrawRuleController.class);
	private static final ObjectMapper objectMapper = new ObjectMapper();
	@Autowired
	private CommonService commonService;

	@RequestMapping(value = "/rule/list")
	public String list(Model model) {
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
			// 保存表结构
			saveStoreTable(data);
			data.put("list_ext", objectMapper.writeValueAsString(data.get("list_ext")));
			data.put("content_ext", objectMapper.writeValueAsString(data.get("content_ext")));
			commonService.add(JsoupUtil.CRAW_RULE_TABLE, data);
		} catch (Exception e) {
			logger.error(e.toString(), e);
			result.put("errMsg", "系统错误！");
		}
		return result;
	}

	private void saveStoreTable(PageData ruleData) throws Exception {
		String craw_store = JsoupUtil.storeTable(ruleData.getString(JsoupUtil.CRAW_STORE_TABLE));
		Table table = commonService.showTable(craw_store);
		if (table == null) {
			commonService.createTable(JsoupUtil.createTableSql(ruleData));
		} else {
			commonService.alterTable(ruleData);
		}
	}

	@ResponseBody
	@RequestMapping(value = "/rule/edit/{id}")
	public PageData edit(@PathVariable String id, @RequestBody PageData data) {
		PageData result = new PageData("errMsg", "success");
		try {
			// 保存表结构
			saveStoreTable(data);
			data.put("list_ext", objectMapper.writeValueAsString(data.get("list_ext")));
			data.put("content_ext", objectMapper.writeValueAsString(data.get("content_ext")));
			commonService.edit(JsoupUtil.CRAW_RULE_TABLE, data, new PageData("id", id));
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
}
