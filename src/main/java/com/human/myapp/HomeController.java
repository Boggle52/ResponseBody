package com.human.myapp;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class HomeController {
	
	@Autowired
	private SqlSession sqlSession;
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value="/menulist", produces="application/text; charset=UTF-8")
	public String doMenuList() {
		iMenu menu=sqlSession.getMapper(iMenu.class);
		ArrayList<menuDTO> arMenu = menu.getMenuList();
		JSONArray ja = new JSONArray();
		for(int i=0; i<arMenu.size(); i++) {
			menuDTO mDto = arMenu.get(i);
			JSONObject jo = new JSONObject();
			jo.put("seqno",mDto.getSeqno());
			jo.put("name",mDto.getName());
			jo.put("price",mDto.getPrice());
			ja.add(jo);
		}
		return ja.toJSONString();
	}
	
	@RequestMapping("/list")
	public String doHome() {
		return "menu";
	}
	
	@ResponseBody
	@RequestMapping(value="/addnew", produces="application/text; charset=UTF-8")
	public String doAddNew(@RequestParam("name") String name,
			@RequestParam("price") int price) {
		iMenu menu=sqlSession.getMapper(iMenu.class);
		int reccount = menu.addMenu(name, price);
//		return "0";
		return Integer.toString(reccount);
	}
	
	@ResponseBody
	@RequestMapping(value="/delete", produces="application/text; charset=UTF-8")
	public String doDelete(@RequestParam("seqno") int seqno) {
		iMenu menu=sqlSession.getMapper(iMenu.class);
		int reccount = menu.remove(seqno);
		return Integer.toString(reccount);
	}
	
	@ResponseBody
	@RequestMapping(value = "/change", produces="application/text; charset=UTF-8")
	public String doChange(@RequestParam("name") String name,
			@RequestParam("price") int price, @RequestParam("seqno") int seqno) {
		iMenu menu=sqlSession.getMapper(iMenu.class);
		int reccount = menu.modify(name, price, seqno);
		return Integer.toString(reccount);
	}
}
