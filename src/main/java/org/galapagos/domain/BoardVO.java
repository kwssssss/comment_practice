
package org.galapagos.domain;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotBlank;

import lombok.Data;

@Data
public class BoardVO {

  private Long bno;
  
  @NotBlank(message="필수 항목입니다.")
  private String title;
  
  @NotBlank(message="필수 항목입니다.")
  private String content;
  
  @NotBlank(message="필수 항목입니다.")
  private String writer;
  
  List<BoardAttachmentVO> attaches;
  
  private Date regDate;
  private Date updateDate;
}

