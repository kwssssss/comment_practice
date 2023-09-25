<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@ include file="../layouts/header.jsp"%>
<%-- 개별 페이지 --%>
<link rel="stylesheet"
	href="/resources/css/summernote/summernote-lite.min.css">
<script src="/resources/js/summernote/summernote-lite.min.js"></script>
<script src="/resources/js/summernote/lang/summernote-ko-KR.min.js"></script>

<script>
	$(document).ready(function() {
		$('#content').summernote({ //jQuery Plugin < 해당 기능 확장
			height : 300, // 에디터 높이
			focus : true, // 에디터 로딩후 포커스를 맞출지 여부
			lang : "ko-KR", // 한글 설정
		});
	});
	// 기본 글꼴 설정
	$('#summernote').summernote('fontName', 'Arial');
</script>


<div class="panel panel-default">

	<div class="panel-body">
	
		<form:form modelAttribute="board" role="form"> <!-- form:form 왜씀? 복원하기 편하기 위해서, 근데 이거 하려면 전제조건이 board 이름의 객체가 스코프에 전달되어야함. 왜냐? board 객체를 통해 bno, writer등을 호출할건데 null이니까 다 실패하겠죠? 그럼 board는 어디서 넘어오나요? controller에서 넘어옴 controller에서 보면 get과 post에 둘다@modelAttributeI("board")로 BoardVO가 넘어와야함 만약 모델 어트리뷰트 안하면 BoardVO로 넘어오겠지??? 암튼 이게 get하고 post 둘 다에 붙여줘야함-, form태그를 쓰기 위한 전제조건 ->
			<!-- menu.jsp에 들어가 있는 <sec:authentication property="principal.username" var="username"/>를 통해 principal.username을  -->
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<form:hidden path="bno"/>
            <form:hidden path="writer" value="${username}" /><!-- menu.jsp에 들어가 있는 <sec:authentication property="principal.username" var="username"/>를 통해 principal.username을 전달받음  -->
			
			<div class="form-group">
				<form:label path="title">제목</form:label> 
				<form:input path="title" cssClass="form-control"/>
				<form:errors path="title" cssClass="errors"/>
			</div>
			
			<div class="form-group">
				<form:label path="content">내용</form:label> 
				<form:textarea path="content" cssClass="form-control" id="content"></form:textarea>
				<form:errors path="content" cssClass="errors"/>
			</div>

			<button type="submit" class="btn btn-primary">
				<i class="fas fa-check"></i>확인
			</button>
			<button type="reset" class="btn btn-primary">
				<i class="fas fa-undo"></i>취소
			</button>
			<a href="javascript:history.back()" class="btn btn-primary"> <i class="fas fa-list"></i>목록 <!--href에 javascript:를 적을시 링크로 보는게 아니라 자바스크립트 코드로 보겠다는 뜻  -->
			</a>
		</form:form>
	</div>
</div>

<%@ include file="../layouts/footer.jsp"%>