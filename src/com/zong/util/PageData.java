package com.zong.util;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * @desc 说明：参数封装Map，查询参数均使用该类封装
 * @author zong
 * @date 2016年3月18日
 */
@SuppressWarnings("rawtypes")
public class PageData extends HashMap implements Map, Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 通过request对象将请求参数进行封装
	 * 
	 * @param request
	 */
	public PageData(HttpServletRequest request) {
		Map properties = request.getParameterMap();
		Iterator entries = properties.entrySet().iterator();
		Map.Entry entry;
		String name = "";
		String value = "";
		while (entries.hasNext()) {
			entry = (Map.Entry) entries.next();
			name = (String) entry.getKey();
			Object valueObj = entry.getValue();
			if (null == valueObj) {
				value = "";
			} else if (valueObj instanceof String[]) {
				String[] values = (String[]) valueObj;
				for (int i = 0; i < values.length; i++) {
					value = values[i] + ",";
				}
				value = value.substring(0, value.length() - 1);
			} else {
				value = valueObj.toString();
			}
			put(name, value);
		}
	}

	public PageData() {
	}

	public PageData(Object key, Object value) {
		put(key, value);
	}

	@Override
	public Object get(Object key) {
		Object obj = null;
		if (super.get(key) instanceof Object[]) {
			obj = (Object[]) super.get(key);
		} else {
			obj = super.get(key);
		}
		return obj;
	}

	public String getString(Object key) {
		Object object = get(key);
		if(object!=null){
			return object.toString();
		}
		return null;
	}

	/**
	 * 返回当前对象，可以链式调用
	 */
	@SuppressWarnings("unchecked")
	public PageData put(Object key, Object value) {
		super.put(key, value);
		return this;
	}

	/**
	 * 使用jackson序列化为json
	 * 
	 * @return json
	 */
	public String toJson() {
		String json = "";
		ObjectMapper objectMapper = new ObjectMapper();
		try {
			json = objectMapper.writeValueAsString(this);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;
	}
}