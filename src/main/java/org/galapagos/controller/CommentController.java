package org.galapagos.controller;

import java.util.List;

import org.galapagos.domain.CommentVO;
import org.galapagos.mapper.CommentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController // 그냥 콘트롤러가 아니고 restcontroller
@RequestMapping("/api/board/{bno}/comment") // {bno} 
public class CommentController {
	@Autowired
	CommentMapper mapper;

	@GetMapping("") // 비어있는 문자열은 공통 url 그대로 쓰겠다는 뜻 (requestMapping)한거
	public List<CommentVO> readComments(@PathVariable Long bno) { // jackson에 의해서 list<>가 자바의 배열문자("[....]")로 해서 나가게 됨
		return mapper.readAll(bno);
	}

	@GetMapping("/{no}")
	public CommentVO readComment(@PathVariable Long bno, @PathVariable Long no) {
		return mapper.get(no);
	}

	@PostMapping("")
	public CommentVO create(@RequestBody CommentVO vo) { //@RequestBody < json을 분석해서 만들어라
		mapper.create(vo); // create 후 no가 배정됨 (mapper 참고)
		return mapper.get(vo.getNo());
	}

	@PutMapping("/{no}")
	public CommentVO update(@PathVariable Long no, @RequestBody CommentVO vo) {
		System.out.println("==> " + vo);
		mapper.update(vo);
		return mapper.get(vo.getNo());
		//return vo;
	}

	@DeleteMapping("/{no}")
	public String delete(@PathVariable Long no) {
		System.out.println("delete ==>" + no);
		mapper.delete(no);
		return "OK";
	}
}