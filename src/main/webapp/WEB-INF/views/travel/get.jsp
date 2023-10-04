<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../layouts/header.jsp"%>

<script>
	$(document).ready(function() {

		/* $('.list').click(function() {
			document.forms.listForm.submit();
		});
		$('.modify').click(function() {
			document.forms.modifyForm.submit();
		}); */

		$('.remove').click(function() {
			//클릭 이벤트 핸들러 함수
			if (!confirm("정말 삭제할까요?"))
				return;

			// form을 얻어서 submit() 호출
			//console.log(document.forms); // document: dom객체
			console.log(document.forms);
			document.forms.removeForm.submit();
		}); /* 이벤트 핸들링하는 방법 기억! */
	});
</script>


<h1 class="page-header">
	<i class="far fa-file-alt"></i> ${travel.title}
</h1>
<div class="d-flex justify-content-between">
	<div>
		<i class="fas fa-user"></i> ${travel.region}
	</div>
	<div>${travel.phone}</div>
	
</div>

<hr>

<div>주소 : ${travel.address}</div>
<div id="map" style="width:100%; height:300px; bacground-color:red; "></div>
<div class="mb-2">${travel.description}</div>

<div class="thumb-images my-5 d-flex">
	<c:forEach var="image" items="${travel.images}"><img alt="" src="${image}"></c:forEach>

</div>

<c:if test="${result=='success'}">
	<script>
		alert("수정이 완료되었습니다.");
	</script>
</c:if>

<div class="mt-4">
	<a href="${cri.getLink('list')}" class="btn btn-primary list"><i class="fas fa-list"></i>목록</a>
	
	<sec:authorize access="hasAnyRole('MANAGER')">
		<a href="${cri.getLink('modify')}&no=${travel.no}" class="btn btn-primary modify"> <i class="far fa-edit"></i>수정</a>
		<a href="#" class="btn btn-danger remove"> <i class="far fa-trash-alt"></i>삭제</a>
	</sec:authorize>
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
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="hidden" name="no" value="${travel.no}" /> 
	<input type="hidden" name="pageNum" value="${cri.pageNum}" /> 
	<input type="hidden" name="amount" value="${cri.amount}" />
	<input type="hidden" name="type" value="${cri.type}" />
	<input type="hidden" name="keyword" value="${cri.keyword}" />
</form>


<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c47faf97463735813588e20413c4be66&libraries=services"></script>

<script>
	let geocoder = new kakao.maps.services.Geocoder();
	let address = '${travel.address}';
	
	geocoder.addressSearch(address, function(result, status){
		if (status === kakao.maps.services.Status.OK) {
			
			// 배열의 첫번째 위치로 이동
			let coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			
			let mapContainer = document.getElementById('map');
			let mapOption = {
				center : coords, // 중심좌표
				level : 3 // 지도의 확대 레벨
			};

			let map = new kakao.maps.Map(mapContainer, mapOption);
			
			let marker = new kakao.maps.Marker({
				map: map,
				position: coords
			});
			
			// 결과값으로 받은 위치로 지도의 중심을 이동
			// map.setCenter(coords);
			// 위에서 중심 설정 되서 더 필요없음
		} else {
			alert('잘못된 주소입니다.');
		}
	});
	



</script>



<%@include file="../layouts/footer.jsp"%>
