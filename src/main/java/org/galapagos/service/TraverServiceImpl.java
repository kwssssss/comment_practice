package org.galapagos.service;

import java.util.List;

import org.galapagos.domain.Criteria;
import org.galapagos.domain.TravelVO;
import org.galapagos.mapper.BoardMapper;
import org.galapagos.mapper.TravelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Log4j
@Service //이녀석이 붙아야 bean으로 등록이 됨
@AllArgsConstructor // 생성자를 통해서 와이어링 할 수 있다
public class TraverServiceImpl implements TravelService {
	@Autowired // 생성자 주입 아니라 field 앞에 autowired 붙여도 됨
	private TravelMapper mapper;
	
	@Override
	public int getTotal(Criteria cri) {
		
		return mapper.getTotalCount(cri);
		
	}

	@Override
	public List<TravelVO> getList(Criteria cri) {
		
		return mapper.getList(cri);
		
	}

	@Override
	public TravelVO get(Long no) {
		// 조회수 처리는 get에서 함
		
		return mapper.read(no);
		
	}

	@Override
	public void register(TravelVO travel) {
		// 첨부파일 업로드 여기서 작업함
		// 다음주에 해볼 예정, 오늘은 23년 9월 15일이란다.
		
		mapper.insert(travel);

	}

	@Override
	public boolean modify(TravelVO travel) {
		
		return mapper.update(travel) == 1;
	}

	@Override
	public boolean remove(Long no) {
		
		return mapper.delete(no) == 1;
	}

}
