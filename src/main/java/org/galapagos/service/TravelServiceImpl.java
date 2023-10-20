package org.galapagos.service;

import java.io.IOException;
import java.security.Principal;
import java.util.List;

import org.galapagos.domain.Criteria;
import org.galapagos.domain.TravelVO;
import org.galapagos.domain.kakao.local.LocalResult;
import org.galapagos.mapper.BoardMapper;
import org.galapagos.mapper.TravelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import retrofit2.Call;
import retrofit2.Response;


@Log4j
@Service //이녀석이 붙아야 bean으로 등록이 됨
@AllArgsConstructor // 생성자를 통해서 와이어링 할 수 있다
public class TravelServiceImpl implements TravelService {
	@Autowired // 생성자 주입 아니라 field 앞에 autowired 붙여도 됨
	private TravelMapper mapper;
	
	@Override
	public int getTotal(Criteria cri) {
		
		return mapper.getTotalCount(cri);
		
	}

	@Override
	public List<TravelVO> getList(Criteria cri, Principal principal) {
		List<TravelVO> list = mapper.getList(cri);
		if(principal !=null) {
			List<Long> hearts = mapper.getHeartsList(principal.getName());
			for(TravelVO travel: list) {
				travel.setMyHearts(hearts.contains(travel.getNo()));
			}
		}
		return list;
		
	}

	@Override
	public TravelVO get(Long no, Principal principal) {
		// 조회수 처리는 get에서 함
		TravelVO travel = mapper.read(no);
		if(principal != null) {
			List<Long> hearts = mapper.getHeartsList(principal.getName());
			travel.setMyHearts(hearts.contains(travel.getNo()));
		}
		
		// 주변 검색
		String query = "주변 맛집 " + travel.getTitle();
		KakaoMapService service = KakaoMapService.getService();
		Call<LocalResult> call = service.searchLocal(query, 10 ,1);
		Response<LocalResult> res;
		try {
			res = call.execute();
			if (res.isSuccessful()) {
				LocalResult result = res.body();
				log.info("====> " + result);
				travel.setLocals(result.getLocals());
			} else {
				log.info("호출 실패!!!!!!!!!!!! ==>>" + res);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return travel;
		
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
	
	@Override
	public List<TravelVO> getRandom(int count){
		return mapper.getRandom(count);
	}
}
