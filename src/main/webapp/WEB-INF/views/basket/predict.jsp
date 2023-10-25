<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
	
<%@ include file="../layouts/header.jsp" %>
<%-- 개별 페이지 --%>

<h1 class="page-header">
	<i class="far fa-edit"></i>너의 농구 포지션은??
</h1>
<div class="panel panel-default">

	<div class="panel-body">

		<form:form modelAttribute="basketVO" role="form">
			<input type="hidden" name="_csrf" value="${_csrf.token}" />

			<div class="form-group">
				<form:label path="P3">3점슛</form:label>
				<form:input path="P3" cssClass="form-control" />
			</div>

			<div class="form-group">
				<form:label path="P2">2점슛</form:label>
				<form:input path="P2" cssClass="form-control" />
			</div>

			<div class="form-group">
				<form:label path="TRP">트레블링 반칙</form:label>
				<form:input path="TRP" cssClass="form-control" />
			</div>

			<div class="form-group">
				<form:label path="AST">어시스트</form:label>
				<form:input path="AST" Class="form-control"></form:input>
			</div>

			<div class="form-group">
				<form:label path="STL">스틸</form:label>
				<form:input path="STL" Class="form-control"></form:input>
			</div>

			<div class="form-group">
				<form:label path="BLK">블락</form:label>
				<form:input path="BLK" Class="form-control"></form:input>
			</div>

			<div class="form-group">
				<label>결과</label>
				<div>${result}</div>
			</div>

			<button type="submit" class="btn btn-primary">
				<i class="fas fa-check"></i>확인
			</button>
			<button type="reset" class="btn btn-primary">
				<i class="fas fa-undo"></i>취소
			</button>
		</form:form>
	</div>
</div>

<%@ include file="../layouts/footer.jsp" %>