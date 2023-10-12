package org.galapagos.mapper;

import java.util.List;

import org.galapagos.domain.BoardAttachmentVO;
import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;

public interface BoardMapper {
//	@Select("select * from tbl_board")
	public List<BoardVO> getList();
	
	public List<BoardVO> getListWithPaging(Criteria cri);

	public void insert(BoardVO board);

	public void insertSelectKey(BoardVO board);

	public BoardVO read(Long bno);

	public int delete(Long bno);

	public int update(BoardVO board);
	
	public int getTotalCount(Criteria cri);
	
	public void insertAttachment(BoardAttachmentVO attach);
	
	public List<BoardAttachmentVO> getAttachmentList(Long bno);
	
	public BoardAttachmentVO getAttachment(Long no);
	
	public int removeAttachment(Long no);

}
