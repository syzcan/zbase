package com.zong.util;

import java.util.LinkedList;

/**
 * @desc 使用LinkedList实现队列先进后出，多线程使用
 * @author zong
 * @date 2017年4月23日
 */
public class Queue {

	/**
	 * 访问链接队列
	 */
	public LinkedList<PageData> list = new LinkedList<PageData>();

	/**
	 * 放入队尾
	 * 
	 * @param url
	 */
	public synchronized void add(PageData data) {
		list.add(data);
	}

	/**
	 * 移出队头
	 * 
	 * @return
	 */
	public synchronized PageData remove() {
		return list.remove();
	}

	/**
	 * 队列是否为空
	 * 
	 * @return
	 */
	public synchronized boolean isEmpty() {
		return list.isEmpty();
	}

	/**
	 * 队列长度
	 * 
	 * @return
	 */
	public synchronized int size() {
		return list.size();
	}
}
