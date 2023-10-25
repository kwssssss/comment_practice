<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%@ include file="../layouts/header.jsp"%>
<%-- 개별 페이지 --%>

<h1 class="page-header">
	<i class="far fa-edit"></i>두둥탁
</h1>
<div class="panel panel-default">

	<div class="panel-body">

		<form:form modelAttribute="titanicVO" role="form">
			<input type="hidden" name="_csrf" value="${_csrf.token}" />

			<div class="form-group">
				<form:label path="sex">성별</form:label>
				<form:input path="sex" cssClass="form-control" />
			</div>

			<div class="form-group">
				<form:label path="age">나이</form:label>
				<form:input path="age" cssClass="form-control" />
			</div>

			<div class="form-group">
				<form:label path="sidsp">형제</form:label>
				<form:input path="sidsp" cssClass="form-control" />
			</div>

			<div class="form-group">
				<form:label path="fare">요금</form:label>
				<form:input path="fare" Class="form-control"></form:input>
			</div>

			<div class="form-group">
				<form:label path="class3">클래스3</form:label>
				<form:input path="class3" Class="form-control"></form:input>
			</div>

			<div class="form-group">
				<form:label path="class1">클래스1</form:label>
				<form:input path="class1" Class="form-control"></form:input>
			</div>

			<div class="form-group">
				<form:label path="class2">클래스2</form:label>
				<form:input path="class2" Class="form-control"></form:input>
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

<%@ include file="../layouts/footer.jsp"%>