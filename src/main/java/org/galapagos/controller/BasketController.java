package org.galapagos.controller;

import org.galapagos.domain.BasketVO;
import org.galapagos.service.BasketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/basket")
public class BasketController {
	
	@Autowired
	BasketService service;
	
	@GetMapping("/predict")
	public void getPredict(BasketVO vo) {
		
	}
	
	@PostMapping("/predict")
	public void postPredict(BasketVO vo, Model model) {
		String result = service.predict(vo);
		model.addAttribute("result", result);
		
	}
}
