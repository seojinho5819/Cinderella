<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<title>Javascript date example</title>
<meta charset="utf-8">
</head>
<body>
	<h1>Javascript Date Example</h1>
	<hr />
	<p id="time-result"></p>
</body>
<script type="text/javascript">
	var d = new Date();
	var currentDate = d.getFullYear() + "년 " + (d.getMonth() + 1) + "월 "
			+ d.getDate() + "일";
	var currentTime = d.getHours() + "시 " + d.getMinutes() + "분 "
			+ d.getSeconds() + "초";
	var result = document.getElementById("time-result");
	result.innerHTML = "오늘 날짜는 " + currentDate + ", 시간은 " + currentTime
			+ " 입니다.";
</script>
</html>