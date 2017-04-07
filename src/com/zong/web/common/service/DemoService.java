package com.zong.web.common.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Random;

import org.springframework.stereotype.Service;

import com.zong.util.Page;
import com.zong.web.common.bean.Demo;

@Service
public class DemoService {
	private static List<Demo> demos = new ArrayList<Demo>();
	private static int id = 500;
	static {
		// 初始化模拟数据
		char[] words = "朝露昙花咫尺天涯人道是黄河十曲毕竟东流去八千年玉老一夜枯荣问苍天此生何必".toCharArray();
		Random random = new Random();
		Calendar calendar = Calendar.getInstance();
		for (int i = 1; i <= id; i++) {
			Demo demo = new Demo();
			demo.setId(i);
			String name = "";
			for (int j = 1; j <= 4; j++) {
				char word = words[random.nextInt(words.length)];
				while (name.indexOf(word) != -1) {
					word = words[random.nextInt(words.length)];
				}
				name += word;
			}
			demo.setName(name);
			demo.setMoney(new BigDecimal(10000 + random.nextInt(10000)));
			calendar.set(1986 + random.nextInt(10), 1 + random.nextInt(12), 1 + random.nextInt(31));
			demo.setBirthday(calendar.getTime());
			demo.setAvatar("static/demo/avatar.png");
			String remark = "";
			int wordCount = 20 + random.nextInt(31);
			for (int j = 1; j <= wordCount; j++) {
				remark += words[random.nextInt(words.length)];
			}
			demo.setRemark(remark);
			demos.add(demo);
		}
	}

	public void addDemo(Demo demo) throws Exception {
		demo.setId(++id);
		demos.add(demo);
	}

	public void deleteDemo(Demo demo) throws Exception {
		for (Demo d : demos) {
			if (d.getId().equals(demo.getId())) {
				demos.remove(d);
				return;
			}
		}
	}

	public void deleteDemos(String[] ids) throws Exception {
		if(ids!=null && ids.length>0){
			for (String id : ids) {
				Demo demo = new Demo();
				demo.setId(Integer.parseInt(id));
				deleteDemo(demo);
			}
		}
	}

	public void editDemo(Demo demo) throws Exception {
		for (Demo d : demos) {
			if (d.getId() == demo.getId()) {
				d.setName(demo.getName());
				d.setBirthday(demo.getBirthday());
				d.setMoney(demo.getMoney());
				d.setAvatar(demo.getAvatar());
				d.setRemark(demo.getRemark());
				return;
			}
		}
	}

	public Demo loadDemo(Demo demo) {
		for (Demo d : demos) {
			if (d.getId().equals(demo.getId())) {
				return d;
			}
		}
		return null;
	}

	public List<Demo> findDemoPage(Page page) {
		List<Demo> demos = new ArrayList<Demo>();
		String keyword = page.getPd().getString("keyword");
		if (keyword != null && !keyword.equals("")) {
			for (Demo d : DemoService.demos) {
				if (d.getName().indexOf(keyword) != -1) {
					demos.add(d);
				}
			}
		} else {
			demos = DemoService.demos;
		}

		List<Demo> list = new ArrayList<Demo>();
		page.setTotalResult(demos.size());
		int index = page.getCurrentResult();
		for (int i = index; i < demos.size() && i < index + page.getShowCount(); i++) {
			list.add(demos.get(i));
		}
		return list;
	}

}
