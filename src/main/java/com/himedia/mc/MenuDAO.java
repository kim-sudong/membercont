package com.himedia.mc;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MenuDAO {
	ArrayList<MenuDTO> getmenu();
	void insertm(String a,int b);
	void delmenu(int a);
	void updateM(int a,String b,int c);
	void insertsales(String a,int b,int c,int d);
	ArrayList<SalesDTO> getSales();
	ArrayList<TypeDTO> getType();
	void insertRoom(String a,int b,int c, int d);
	ArrayList<RoomDTO> getRoom();
	void delRoom(int a);
	void upRoom(String a,int b,int c,int d,int e);
	int sum();
}
