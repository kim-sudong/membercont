package com.himedia.mc;

import lombok.Data;

@Data
public class TypeDTO {
	int id;
	String roomname;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getRoomname() {
		return roomname;
	}
	public void setRoomname(String roomname) {
		this.roomname = roomname;
	}
	
}
