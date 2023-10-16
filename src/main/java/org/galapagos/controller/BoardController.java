package org.galapagos.controller;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.galapagos.domain.BoardAttachmentVO;
import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;
import org.galapagos.domain.PageDTO;
import org.galapagos.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping(value = "/board")
@AllArgsConstructor
public class BoardController {
	@Autowired
	private BoardService service;
	
	@ModelAttribute("searchTypes")
	public Map<String, String> searchTypes() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("","-- 검색대상선택 --");
		map.put("R","권역");
		map.put("T","제목");
		map.put("D","내용");
		map.put("TD","제목+내용");
		map.put("TR","권역+제목");
		map.put("TRD","권역+제목+내용");
		
		return map;
	}

	@GetMapping("/list")
	public void list(@ModelAttribute("cri") Criteria cri, Model model) { //@ModelAttribute("cri") 라고 하면 jsp에서 cri로 접근 가능해짐
	log.info("list: " + cri);
	int total= service.getTotal(cri);

	model.addAttribute("list", service.getList(cri));
	model.addAttribute("pageMaker", new PageDTO(cri, total));// 실제 데이터 건수 어떻게 넣냐??
	}

	@GetMapping("/register")
	public void register(@ModelAttribute("board") BoardVO board) {
		log.info("register");
	}

	@PostMapping("/register")
	public String register(@Valid @ModelAttribute("board") BoardVO board, Errors errors, List<MultipartFile> files, RedirectAttributes rttr) throws Exception { //@Valid 뒤에는 항상 Errors가 붙어있어야함

		log.info("register: " + board);



		if(errors.hasErrors()) {
			return "board/register"; // 오류 발생시 다시 작성하라고 register 페이지로 다시 보내기
		}
		
		service.register(board, files);
		rttr.addFlashAttribute("result", board.getBno());
		return "redirect:/board/list";
	}

	@GetMapping({"/get", "/modify"})
	public void get(
			@RequestParam("bno") Long bno,
			@ModelAttribute("cri") Criteria cri,
			Model model) {

		log.info("/get or modify");
		model.addAttribute("board", service.get(bno));
	}

	@PostMapping("/modify")
	public String modify(
			@Valid @ModelAttribute("board") BoardVO board,
			Errors errors,
			List<MultipartFile> files,
			@ModelAttribute("cri") Criteria cri, 
			RedirectAttributes rttr) throws Exception{
		
		if(errors.hasErrors()) {
			return "board/modify";
		}
		log.info("modify:" + board);

		if (service.modify(board, files)) {
			// flash = 1회성, 1회성으로 정보를 전달
			rttr.addFlashAttribute("result", "success");
			rttr.addAttribute("bno", board.getBno());
			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
			rttr.addAttribute("type", cri.getType());
			rttr.addAttribute("keyword", cri.getKeyword());
		}
		return "redirect:" + cri.getLinkWithBno("/board/get", board.getBno());
	}

	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri,
 RedirectAttributes rttr) {

		log.info("remove..." + bno);
		if (service.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
			rttr.addAttribute("type", cri.getType());
			rttr.addAttribute("keyword", cri.getKeyword());

		}
		return "redirect:" +cri.getLink("/board/list");
	}
	
	@GetMapping("/download/{no}")
	@ResponseBody // view를 사용하지 않고 직접 내보내겠다.
	public void download(
			@PathVariable("no") Long no,
			HttpServletResponse response) throws Exception {
		
		BoardAttachmentVO attach = service.getAttachment(no);
		attach.download(response);		
	}
	
	@DeleteMapping("/remove/attach/{no}")
	@ResponseBody
	public String removeAttach(@PathVariable("no") Long no) throws Exception {
	service.removeAttachment(no);
	return "OK";
	}

}
