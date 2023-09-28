package org.galapagos.domain;

import java.util.List;

import lombok.Data;

@Data
public class CommentVO {
	private Long no;
	private Long bno;
	
	private String writer;
	private String content;
	private String regDate;
	private String updateDate;
	
	List<ReplyVO> replyList;
}
