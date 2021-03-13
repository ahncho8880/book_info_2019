<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	boolean logon = false;
	String userID = (String)session.getAttribute("LOGIN");
	if(userID!=null)
		logon=true;
%>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top"> <a
		class="navbar-brand" href="main">みんなの本</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
		
			<li class="nav-item"><a class="nav-link" href="allnewbookNavi">NEW BOOKS</a>
			</li>
			<li class="nav-item"><a class="nav-link" href="allhitbookNavi">HIT BOOKS</a>
			</li>
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false">CATAGORY</a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href='allcatagorybookNavi?bGenre=1'>novel</a> <a
						class="dropdown-item" href='allcatagorybookNavi?bGenre=2'>essay</a> <a class="dropdown-item"
						href='allcatagorybookNavi?bGenre=3'>nation</a> <a class="dropdown-item" href='allcatagorybookNavi?bGenre=4'>self
						devolopement</a> <a class="dropdown-item" href='allcatagorybookNavi?bGenre=5'>history</a>
				</div></li>

			<form class="form-inline" action="search" method="GET">
				<input class="form-control mr-sm-2" type="search"
					placeholder="Search" aria-label="Search" name="bName">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			</form>
			
		</ul>
		<%
		if(logon){
			%>
		<ul class="nav navbar-nav navbar-right">
			<li class="nav-item"><a class="nav-link" href="dologout">logout</a></li>
		</ul>
		
		<%
		}else{
	%>
		<ul class="nav navbar-nav navbar-right">
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false">connection</a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="dologin">login</a> <a
						class="dropdown-item" href="dojoin">new account</a>
				</div></li>
		</ul>
		<%
		}
		%>
	</div>
	</nav>