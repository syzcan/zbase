package test;

import com.zong.cache.CacheService;
import com.zong.util.PageData;
import com.zong.util.SpringContextUtil;
import com.zong.util.ZConst;

public class CacheTest {
	public static void main(String[] args) {
		CacheService cacheService = (CacheService)SpringContextUtil.getBean("ehcacheService");
		cacheService.put(ZConst.MODULE_APP_ID_TOKEN, "1", new PageData("name","zong").put("age", "28"));
		cacheService.put(ZConst.MODULE_APP_ID_TOKEN, "2", new PageData("name","good").put("age", "30"));
		
		System.out.println(cacheService.get(ZConst.MODULE_APP_ID_TOKEN, "2"));
	}
}
