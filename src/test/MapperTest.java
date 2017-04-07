package test;

import java.util.Date;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.zong.util.Page;
import com.zong.util.PageData;
import com.zong.util.SpringContextUtil;
import com.zong.web.common.dao.CommonMapper;

public class MapperTest {
	public static void main(String[] args) {
		try {
			CommonMapper commonMapper = SpringContextUtil.getBean(CommonMapper.class);
			Page page = new Page();
			page.setTable("sys_user");
			page.getPd().put("desc", "id");
			System.out.println(new ObjectMapper().writerWithDefaultPrettyPrinter()
					.writeValueAsString(commonMapper.findPage(page)));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
