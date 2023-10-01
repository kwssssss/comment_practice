<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../layouts/header.jsp"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js">
</script>
<script src="/resources/js/rest.js"></script>
<script src="/resources/js/comment.js"></script>
<script src="/resources/js/reply.js"></script>


<script>
// 댓글 기본 URL 상수 - 전역 상수
const COMMENT_URL = '/api/board/${param.bno}/comment/';
const REPLY_URL = '/api/board/${param.bno}/reply/';

	$(document).ready(async function() {
		$('.remove').click(function() {
			if (!confirm("정말 삭제할까요?")) return;
			document.forms.removeForm.submit();
		}); 
		
 		let bno = ${param.bno}; //글번호
		let writer = '${username}'; // 글 작성자( 로그인 유저) 
		
		loadComments(bno, writer); // 댓글 목록 불러오기 */
		
		// 댓글 추가버튼 처리
		$('.comment-add-btn').click(function(e) {
			createComment(bno, writer);
		});	
		
		$('.comment-list').on('click', '.comment-update-show-btn', showUpdateComment);
		
		$('.comment-list').on('click', '.comment-delete-btn', deleteComment);

		
		
		/* const bno = ${board.bno};
		const url = '/api/board/' +bno + '/comment'; // 여기에 밑에 코드가 다 들어가잇슴
		console.log(url); */
		
		// 생성
		/* let comment = {
			bno, //bno= bno,에서 bno만 써도 된대
			writer: '${username}',
			content: "추가 글입니다."
		};
		console.log(comment);
		console.log(JSON.stringify(comment)); // 직렬화, 문자열로 변환됨
		
		comment = await rest_create(url, comment);
		console.log(comment); */
		
		/* // 수정
		let comment = {
				no: 5,
				content: "수정한 글입니다."
		};
		
		comment = await rest_modify(url + "/5", comment); // 기존 url에 대상이 되는 글 번호
		console.log(comment); */
		
		/* // 삭제
		let result = await rest_delete(url + "/1"); // 기존 url에 대상이 되는 글 번호
		console.log(result);
		
		
		// 목록 추출
		let data= await rest_get(url);
		console.log(data); */
		
		//let res = await fetch('/api/board/303/comment'); //get 요청할때는 옵션 설정할필요업슴, 두번째 매개변수가 없다? get요청인거임 ㅇㅋ?
		//let data = await res.json(); 
		//console.log(data);
				
		//.then(res => res.json()) //매개변수가 하날 경우에 한해서 괄호도 생략 가능 //본체가 한줄 짜리면 대괄호도 생략 가능.. 리턴도 생략가능///.		//.then(function (res) {			
				//res.json(); //json을 리턴한다는건 ? promise가 리턴된다는 것, json객체를 실제 객체로 바꾸라는 뜻(역직렬화)
		//.then(data => console.log(data));
				/* .then(function(data) {
				console.log(data);
			}); */
		
//		console.log('fetch 호출 완료')
		
			// res=>console.log(res)
			
		//수정확인버튼 클릭
		$('.comment-list').on('click', '.comment-update-btn', function (e){
			const el = $(this).closest('.comment');
			updateComment (el, writer);
		});
			
		// 수정 취소 버튼 클릭
		$('.comment-list').on('click', '.comment-update-cancel-btn', 
			cancelCommentUpdate);	
		
		//답글 버튼 이벤트 핸들링
		// 답글 추가 인터페이스 보이기
		$('.comment-list').on('click', '.reply-add-show-btn', function(e) {
			showReplyAdd($(this), writer);
			});
		
		// 답글 등록
		$('.comment-list').on('click', '.reply-add-btn', function(e){
			addReply($(this), writer);
			});
		
		// 답급 취소
		$('.comment-list').on('click', '.reply-add-cancel-btn', cancelReply);
		
		// 답글 수정 화면 보이기
		$('.comment-list').on('click', '.reply-update-show-btn', function(e) {
			showUpdateReply($(this));
			});
		
		// 답글 수정 등록
		$('.comment-list').on('click', '.reply-update', function(e) {
			updateReply($(this));
		});
		
		// 답글 수정 취소
		$('.comment-list').on('click', '.reply-update-cancel', cancelReplyUpdate);
		
		// 답글 삭제
		$('.comment-list').on('click', '.reply-delete-btn', deleteReply);

		
			
	});
</script>


<h1 class="page-header">
	<i class="far fa-file-alt"></i> ${board.title}
</h1>
<div class="d-flex justify-content-between">
	<div>
		<i class="fas fa-user"></i> ${board.writer}
	</div>
	<div>
		<i class="fas fa-clock"></i>
		<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate}" />
	</div>
</div>
<hr>
<div>${board.content}</div>

<!-- 코멘트 추가 / 작성자가 아닌 경우에만 보여주기 -->

<c:if test="${username != board.writer }">
	<div class="bg-light p-2 rounded my-5">
		<div>${username == null ? '댓글을 작성하려면 먼저 로그인하세요' : '댓글 작
성' }</div>
		<div>
			<textarea class="form-control new-comment-content" rows="3"
				${username == null ? 'disabled' : '' }></textarea>
			<div class="text-right">
				<button class="btn btn-primary btn-sm my-2 comment-add-btn"
					${username == null ? 'disabled' : '' }>
					<i class="fa-regular fa-comment"></i> 확인
				</button>
			</div>
		</div>
	</div>
</c:if>

<div class="my-5">
	<i class="fa-regular fa-comments"></i> 댓글 목록
	<hr>
	<div class="comment-list">
		<!-- 여기에 댓글 목록이 나오게 할 예정 -->


		<div class="comment-body">
			<div class="comment-content"></div>
		</div>
		<div class="reply-list ml-5">
			<!-- 답글 목록 출력 영역 -->
		</div>
	</div>

	<c:if test="${result=='success'}">
		<script>
		alert("수정이 완료되었습니다.");
	</script>
	</c:if>

	<div class="mt-4">
		<a href="${cri.getLink('list')}" class="btn btn-primary list"><i
			class="fas fa-list"></i>목록</a>

		<c:if test="${username == board.writer}">
			<a href="${cri.getLinkWithBno('modify', board.bno)}"
				class="btn btn-primary modify"> <i class="far fa-edit"></i>수정
			</a>
			<a href="#" class="btn btn-danger remove"> <i
				class="far fa-trash-alt"></i>삭제
			</a>
		</c:if>
	</div>

	<%-- 
<form id="listForm" action="/board/list" method="get">
	<input type="hidden" name="pageNum" value="${cri.pageNum}" /> 
	<input type="hidden" name="amount" value="${cri.amount}" />
	<input type="hidden" name="type" value="${cri.type}" />
	<input type="hidden" name="keyword" value="${cri.keyword}" />
</form>

<form id="modifyForm" action="/board/modify" method="get">
	<input type="hidden" id="bno" name="bno" value="${board.bno}" /> 
	<input type="hidden" name="pageNum" value="${cri.pageNum}" /> 
	<input type="hidden" name="amount" value="${cri.amount}" />
	<input type="hidden" name="type" value="${cri.type}" />
	<input type="hidden" name="keyword" value="${cri.keyword}" />
</form>
 --%>

	<form action="remove" method="post" name="removeForm">
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" /> <input type="hidden" name="bno"
			value="${board.bno}" /> <input type="hidden" name="pageNum"
			value="${cri.pageNum}" /> <input type="hidden" name="amount"
			value="${cri.amount}" /> <input type="hidden" name="type"
			value="${cri.type}" /> <input type="hidden" name="keyword"
			value="${cri.keyword}" />
	</form>

	<%@include file="../layouts/footer.jsp"%>