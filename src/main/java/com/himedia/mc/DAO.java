package com.himedia.mc;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DAO {
	void savesignup(String id,String pass,String name,String birth,String gender,
			String mo,String fa);
	int logch(String id,String pass);

}
