package org.galapagos.domain;

import javax.validation.constraints.NotBlank;

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
}
