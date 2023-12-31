package org.galapagos.domain;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.validation.constraints.NotBlank;

import org.galapagos.domain.kakao.local.Local;

import lombok.Data;

@Data
public class TravelVO {
	private Long no;
	
	
	@NotBlank(message="필수 항목입니다.")
	private String region;
	
	@NotBlank(message="필수 항목입니다.")
	private String title;
	
	@NotBlank(message="필수 항목입니다.")
	private String description;
	
	private String address;
	private String phone;
	private String hearts;
	private Boolean myHearts;
	
	List<Local> locals; // 주변 검색 결과 목록
	
	public String getImage() {
		int i = new Random().nextInt(5) + 1;
		return String.format("/resources/images/travel/%03d-%d.jpg", no, i);
	} 
	
	public List<String> getImages() {
		List<String> list = new ArrayList<String>();
		for(int i=1; i<=5; i++) {
			list.add(String.format("/resources/images/travel/%03d-%d.jpg", no, i));
		}
		return list;
	}
	
	public String getSummary() {
		return description.split("<br>")[0].replace("<p>", "");
	}
}
