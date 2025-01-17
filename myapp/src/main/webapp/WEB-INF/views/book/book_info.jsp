<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="resources/bootstrap/css/bootstrap.css">
<link href="resources/bootstrap/css/DetailPage.css" rel="stylesheet"
	type="text/css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style type="text/css">
p.thick {
	font-weight: bold;
	font-size: 20px;
}

.img-ahn {
	width: 250px;
	height: 325px;
}

.checked {
	color: orange;
}
</style>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
	function add(ths, sno) {

		for (var i = 1; i <= 5; i++) {
			var cur = document.getElementById("star" + i)
			cur.className = "fa fa-star"
		}

		for (var i = 1; i <= sno; i++) {
			var cur = document.getElementById("star" + i)
			if (cur.className == "fa fa-star") {
				cur.className = "fa fa-star checked"
			}
		}
	}
	
	$(document).ready(function(){
		var booknum = '${bookinfo[0].bNum}';
		var sessionId = "<%=session.getAttribute("LOGIN")%>";
		$.ajax({
			type: 'post',
			url: 'avg_point',
			dataType:'text',
			headers:{
				"Content-Type":"application/json",
				"X-HTTP-Method-Override":"POST"
			},
			data:JSON.stringify({
				pbNum: booknum
			}),
			success : function(data){
				var star = "<%=session.getAttribute("avg") %>";
				for (var i = 1; i <= 5; i++) {
					var cur = document.getElementById("star0" + i)
					cur.className = "fa fa-star"
				}
				for (var i = 1; i <= star; i++) {
					var cur = document.getElementById("star0" + i)
					if (cur.className == "fa fa-star") {
						cur.className = "fa fa-star checked"
					}
				}
			},
			error : function(){
				sessionStorage.removeItem('avg');
				alert(avg);
			}
		});
		if(sessionId!='null'){
			$.ajax({
				type: 'post',
				url: 'show_point',
				dataType:'text',
				headers:{
					"Content-Type":"application/json",
					"X-HTTP-Method-Override":"POST"
				},
				data:JSON.stringify({
					pId: sessionId,
					pbNum: booknum,
				}),
				success : function(data){
					var star2 = "<%=session.getAttribute("star")%>";
					var cur;
						for (var i = 1; i <= 5; i++) {
							cur = document.getElementById("star" + i)
							cur.className = "fa fa-star"
						}
						for (var i = 1; i <= star2; i++) {
							cur = document.getElementById("star" + i)
							if (cur.className == "fa fa-star") {
								cur.className = "fa fa-star checked"
							}
						}
				},
				error : function(){
					alert("싯파이");
				}
			});
		}else{
			alert("22");
		}
		$(".resister").click(function(){
		
			var sessionId = "<%=session.getAttribute("LOGIN")%>";
			var test = 1;
			var cnt = 0;
			var cur;
			var booknum = '${bookinfo[0].bNum}';

			if (sessionId == 'null') {
				alert("로그인이 필요합니다");
			} else {
				for (var i = 1; i <= 5; i++) {
					cur = $('#star' + i).attr('class');
					if (cur == "fa fa-star checked") {
						cnt++;
					}
				}
				alert("cnt: " + cnt + "," + sessionId + "," + booknum);
				$.ajax({
					type : 'post',
					url : 'insert_point',
					dataType : 'text',
					headers : {
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "POST"
					},
					data : JSON.stringify({
						pId : sessionId,
						pbNum : booknum,
						pScore : cnt
					}),
					success : function(data) {
						if (data == 'success') {
							alert(sessionId + "님 점수를 등록");
						}
					},
					error : function(result, status, error) {
						alert("점수 등록에 문제가 있습니다");
					}
				});
			}
		});
	});
</script>
</head>
<body>
	<%@include file="navi2.jsp"%>
	<br>
	<br>
	<!-- Page Content -->
	<div class="container">

		<!-- Portfolio Item Heading -->
		<h1 class="my-4">
			<small></small>
		</h1>

		<!-- Portfolio Item Row -->
		<div class="row">

			<div class="col-sm">
				<h3 class="my-3">${bookinfo[0].bName}</h3>
				<ul>
					<li><h6>
							<span class="fa fa-star" id="star01"></span> <span class="fa fa-star" id="star02"></span>
							<span class="fa fa-star" id="star03"></span> <span class="fa fa-star" id="star04"></span>
							<span class="fa fa-star" id="star05"></span><%=session.getAttribute("avg") %>
						</h6>
					<li><span class="show">
							<h6>
								내 평점 <span class="fa fa-star" id="star1" onclick="add(this,1)"></span>
								<span class="fa fa-star" id="star2" onclick="add(this,2)"></span>
								<span class="fa fa-star" id="star3" onclick="add(this,3)"></span>
								<span class="fa fa-star" id="star4" onclick="add(this,4)"></span>
								<span class="fa fa-star" id="star5" onclick="add(this,5)"></span>
								<input class="resister" type="button" value="등록" />
							</h6>
					</span></li>
					<li>저자: ${bookinfo[0].bWriter}</li>
					<li>등록일: ${bookinfo[0].bReg}</li>
					<li>장르: ${bookinfo[0].bGenre}</li>
				</ul>
				<%-- <h3 class="my-3">${bookinfo[0].bIntro }</h3>
          <p>${bookinfo[0].bSynop }</p> --%>
				<p>${bookinfo[0].bIntro }</p>
			</div>
			<div class="col-sm">
				<p style="text-align: center;">
					<img class="img-ahn"
						src="/resources/bootstrap/images/${bookinfo[0].bImg}" alt="">
				</p>
			</div>
		</div>
		<!-- /.row -->

		<!--      Related Projects Row
      <h3 class="my-4">Related Projects</h3>

      <div class="row">

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="#">
            <img class="img-fluid" src="http://placehold.it/500x300" alt="">
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="#">
            <img class="img-fluid" src="http://placehold.it/500x300" alt="">
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="#">
            <img class="img-fluid" src="http://placehold.it/500x300" alt="">
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="#">
            <img class="img-fluid" src="http://placehold.it/500x300" alt="">
          </a>
        </div>

      </div>
      /.row -->

	</div>
	<!-- /.container -->

	<div>
		<%@ include file="list.jsp"%>
		<%@include file="footer.jsp"%>
	</div>
</body>
<script src="resources/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="resources/bootstrap/js/bootstrap.js"></script>
</html>