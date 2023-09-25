async function rest_get(url) {
	try {
		let res = await fetch(url);
		return await res.json();
	} catch(e) {
		console.log(e);
		}
	}
	
async function rest_create(url, data) {
	try {
		let res = await fetch(url, {
			method: "POST",
			headers: { "Content-Type": "application/json" },
			body: JSON.stringify(data),
		});
		return await res.json();
	} catch(e) {
		console.log(e);
	} 
	}
	
async function rest_modify(url, data) { 
	try {
		let res = await fetch(url, {
			method: "PUT",
			headers: { "Content-Type": "application/json" },
			body: JSON.stringify(data),
		});
		return await res.json();
	} catch(e) {
		console.log(e);
	}
	}
	
async function rest_delete(url) {
	try {
		let res = await fetch(url, { 
			method: "DELETE" });
		return await res.text(); // res.json();
	} catch(e) {
		console.log(e);
	}
}

$(document).ready(function() {

	let bno = '${param.bno}'; // 글번호
	let writer = '${username}'; // 작성자(로그인 유저)
	loadComments(bno, writer); // 댓글 목록 불러오기
// 댓글 추가 버튼 처리
	$('.comment-add-btn').click(function(e) {
		createComment(bno, writer);
	});
});

