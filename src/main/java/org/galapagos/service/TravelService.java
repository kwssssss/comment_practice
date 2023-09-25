package org.galapagos.service;

import java.util.List;

import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;
import org.galapagos.domain.TravelVO;

public interface TravelService { //일반적으로 read-create-delete-update순으로 나열
	
	public int getTotal(Criteria cri);
	
	public List<TravelVO> getList(Criteria cri);

	public TravelVO get(Long no);
	
	public void register(TravelVO travel);

	public boolean modify(TravelVO travel);

	public boolean remove(Long no);
		
}
