package com.human.myapp;

import java.util.ArrayList;

public interface iMenu {
	ArrayList<menuDTO> getMenuList();
	int addMenu(String name, int price);
	int remove(int seqno);
	int modify(String name, int price, int seqno);
}
