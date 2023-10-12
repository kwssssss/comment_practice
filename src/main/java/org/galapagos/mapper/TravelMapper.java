package org.galapagos.mapper;

import java.util.List;

import org.galapagos.domain.Criteria;
import org.galapagos.domain.HeartVO;
import org.galapagos.domain.TravelVO;

public interface TravelMapper {
	
	public int getTotalCount(Criteria cri);
	
	// 페이지 목록 추출
	public List<TravelVO> getList(Criteria cri);
	
	public List<TravelVO> getRandom(int count);
	
	public TravelVO read(Long no);
	
	// pk 추출 포함
	public void insert(TravelVO travel);
	
	public int update(TravelVO travel);
	
	public int delete(Long no);
	
	// 좋아요 처리
	public List<Long> getHeartsList(String username); // List < tno 목록
	
	public int addHeart (HeartVO heart);
		// 이 둘은 ajax를 통해 처리할 것들
	public int deleteHeart (HeartVO heart);
}
