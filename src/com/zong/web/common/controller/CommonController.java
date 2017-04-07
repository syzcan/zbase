package com.zong.web.common.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.zong.util.FileUploadDownload;
import com.zong.util.PageData;
import com.zong.util.RandomCode;
import com.zong.util.ZConst;
import com.zong.web.common.dao.CommonMapper;

/**
 * 文件上传下载、验证码生成等通用类
 * 
 * @author zong
 * 
 */
@Controller
@RequestMapping(value = "/common")
public class CommonController {
	private static final Logger logger = LoggerFactory.getLogger(CommonController.class);
	@Autowired
	private CommonMapper commonMapper;

	/**
	 * uploadify上传附件
	 * 
	 * @param file
	 * @param uploadType 指定上传类型，上传到对应目录下
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
	public Map<String, String> uploadFile(MultipartFile file, String uploadType, HttpServletRequest request) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("fileName", file.getOriginalFilename());
		map.put("url", this.upload(file, uploadType, request));
		logger.info("上传 {} 类型文件:{}", uploadType, file.getOriginalFilename());
		return map;
	}

	/**
	 * 
	 * @param file
	 * @param uploadType
	 * @return 返回附件访问路径
	 */
	private String upload(MultipartFile file, String uploadType, HttpServletRequest request) {
		String uploadPath = ZConst.UPLOAD_FILE_PATH;
		if ("picture".equals(uploadType)) {
			uploadPath = ZConst.UPLOAD_PICTURE_PATH;
		} else if ("music".equals(uploadType)) {
			uploadPath = ZConst.UPLOAD_MUSIC_PATH;
		} else if ("video".equals(uploadType)) {
			uploadPath = ZConst.UPLOAD_VIDEO_PATH;
		} else if ("document".equals(uploadType)) {
			uploadPath = ZConst.UPLOAD_DOCUMENT_PATH;
		}
		// 文件目录按时间归类文件夹
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		String dateDir = dateFormat.format(new Date());
		String path = uploadPath + "/" + dateDir;
		String fileName = FileUploadDownload.fileUp(file,
				request.getSession().getServletContext().getRealPath("/") + path);
		return path + "/" + fileName;
	}

	/**
	 * 下载附件
	 * 
	 * @param file
	 */
	@RequestMapping(value = "/downloadFile")
	public void downloadFile(HttpServletRequest request, HttpServletResponse response) {
		try {
			String filePath = "static/js/pintuer.js";
			filePath = request.getSession().getServletContext().getRealPath(filePath);
			String fileName = "拼图文件pintuer.js";
			FileUploadDownload.fileDownload(response, filePath, fileName);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 生成图形验证码
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/code")
	public void code(HttpServletRequest request, HttpServletResponse response) {
		RandomCode.getRandcode(request, response);
	}

	/**
	 * 统计某个表总记录数
	 * 
	 * @param table
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/count")
	public PageData count(String table) {
		PageData pd = new PageData("errMsg", "success").put("count", 0);
		try {
			pd.put("count", commonMapper.count(table));
		} catch (Exception e) {
			logger.warn(e.toString(),e);
		}
		return pd;
	}
}
