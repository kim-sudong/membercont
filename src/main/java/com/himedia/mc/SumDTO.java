package com.himedia.mc;

import lombok.Data;

@Data
public class SumDTO {
	int sum;

	public int getSum() {
		return sum;
	}

	public void setSum(int sum) {
		this.sum = sum;
	}
	
}
