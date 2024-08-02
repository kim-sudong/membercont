package com.himedia.mc;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardDAO {
	void insert(String a,String b,String c);
	ArrayList<BoardDTO> getList(int start);
	int getcount();
	BoardDTO getView(int x);
	void delete(int a);
	void update(int a,String b,String c);
	void addHit(int x);
	BoardDTO delsel(int a);
	void delselx(int a);
	int getmemid(String a);
	void insertrecon(int a,String b,int c);
	ArrayList<ReDTO> getre(int a);
	void redel(int a);
	void reup(String a,int b);
	void reinsert(int a,String b,int c);
}
