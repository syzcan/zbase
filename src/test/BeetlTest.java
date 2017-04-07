package test;

import java.util.ArrayList;
import java.util.List;

import org.beetl.core.Configuration;
import org.beetl.core.GroupTemplate;
import org.beetl.core.Template;
import org.beetl.core.resource.FileResourceLoader;
import org.beetl.core.resource.StringTemplateResourceLoader;

import com.zong.util.FileUtils;
import com.zong.util.PageData;

public class BeetlTest {
	public static void main(String[] args) {
		try {
			//从字符串加载
//			String btl = FileUtils.readTxt(FileUtils.getClassResources() + "test/zong.btl");
//			StringTemplateResourceLoader resourceLoader = new StringTemplateResourceLoader();
//			Configuration cfg = Configuration.defaultConfiguration();
//			GroupTemplate gt = new GroupTemplate(resourceLoader, cfg);
//			Template t = gt.getTemplate(btl);
			//从模板文件加载
			FileResourceLoader fileLoader = new FileResourceLoader(FileUtils.getClassResources() + "test","utf-8");
			Configuration cfg = Configuration.defaultConfiguration();
			GroupTemplate gt = new GroupTemplate(fileLoader, cfg);
			Template t = gt.getTemplate("/zong.btl");
			
			List<PageData> users = new ArrayList<>();
			users.add(new PageData("name","zong1").put("age", 10));
			users.add(new PageData("name","zong2").put("age", 20));
			users.add(new PageData("name","zong3").put("age", 30));
			t.binding("users", users);
			String str = t.render();
			System.out.println(str);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
