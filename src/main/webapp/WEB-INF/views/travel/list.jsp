<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

	
<%@ include file="../layouts/header.jsp" %>
<%-- 개별 페이지 --%>


<h1>100대 관광지</h1>

<%@ include file="../common/search_bar.jsp" %>

<style>
.card-img-top {
	height: 200px;
	object-fit: cover;
}
.card-text {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis; /* 텍스트 넘치는거 ... 처리 */
}
</style>

<c:if test="${not empty username}">
	<style>
		.fa-heart {
		cursor: pointer;
		}
	</style>
	
	<script src="/resources/js/rest.js"></script>
	<script>
	$(document).ready(function() {
		let username = '${username}';
		
		const BASE_URL = '/api/travel/heart'
	
	// 좋아요 추가
	$('span.heart').on('click', '.fa-heart.fa-regular', async function(e){
		
		let tno = parseInt($(this).data("tno"));
		let heart = {tno, username};
		console.log(heart);
		
		await rest_create(BASE_URL + "/add", heart);
		
		let heartCount = $(this).parent().find(".heart-count");
		console.log(heartCount);
		let count = parseInt(heartCount.text());
		heartCount.text(count+1);
		
		$(this)
			.removeClass('fa-regular')
			.addClass('fa-solid');
	});
	
	// 좋아요 제거
	$('span.heart').on('click', '.fa-heart.fa-solid', async function(e){
		let tno = parseInt($(this).data("tno"));
		
		await rest_delete(
				`\${BASE_URL}/delete?tno=\${tno}&username=\${username}`);
				//\ 붙인 이유, $가 el의 $가 아니라는 뜻 그냥 문자 $로 봐달라
		let heartCount = $(this).parent().find(".heart-count");
		console.log(heartCount);
		let count = parseInt(heartCount.text());
		heartCount.text(count-1);
		
		$(this)
			.removeClass('fa-solid')
			.addClass('fa-regular')
	});
});
	</script>
</c:if>

<div class="row">
	<c:forEach var="travel" items="${list}">
		<div class="col-sm-6 col-md-4 mb-3">
			<div class="card" style="width: 100%">
				<a href="${cri.getLink('get')}&no=${travel.no}">
					<img class="card-img-top" src="${travel.image}" alt="${travel.title}">
				</a>
				<div class="card-body">
					<h4 class="card-title">
						<a href="${cri.getLink('get')}&no=${travel.no}">
							${travel.title}
						</a>
					</h4>
					<span class="heart">
						<i class="${travel.myHearts ? 'fa-solid' : 'fa-regular' } fa-heart text-danger"
							data-tno="${travel.no}"></i>
							<span class="heart-count">${travel.hearts}</span>
					</span>
					<p class="card-text">${travel.summary}</p>
				</div>
			</div>
		</div>
	</c:forEach>
</div>

<%-- <table class="table table-striped table-hover">
	<thead>
		<tr>
			<th style="width: 60px">No</th>
			<th style="width: 100px">권역</th>
			<th>제목</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="travel" items="${list}">
			<tr>
				<td>${travel.no}</td>
				<td>${travel.region}</td>
				<td><a href="${cri.getLink('get')}&no=${travel.no}">${travel.title}</a></td>
			</tr>
		</c:forEach>
	</tbody>

</table> --%>

<%@include file="../common/pagination.jsp"%>

		<div class="text-right">
			<sec:authorize access="hasAnyRole('MANAGER')">
				<a href="register" class="btn btn-dark"> <i class="far fa-edit"></i>
					추가
				</a>
			</sec:authorize>
		</div>

<%@ include file="../layouts/footer.jsp" %>