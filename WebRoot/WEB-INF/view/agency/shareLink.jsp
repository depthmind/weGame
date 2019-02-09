<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../assets/pages/head.jsp"%>
<link href="${rootPath }assets/css/jquery.datatables.css" rel="stylesheet">
</head>

<body>
	<%@ include file="../assets/pages/preloader.jsp"%>
	<section>
		<%@ include file="../assets/pages/leftpanel.jsp"%>
		<div class="mainpanel">
			<%@ include file="../assets/pages/headerbar.jsp"%>
			<div class="pageheader">
				<h2>
					代理管理 <span>获取链接</span>
				</h2>
			
			</div>
			<c:if test="${hasPay }" var="flag">
				<div class="contentpanel">
					<!-- content goes here... -->
					<div class="panel panel-default">
						<label>注册链接</label><br>
						<label id="register">${registerLink }</label>
						<button class="register-btn" data-clipboard-action="copy" data-clipboard-target="#register">获取</button>
						<br/>
						<label>充值链接</label><br>
						<label id="recharge">${rechargeLink }</label>
						<button class="recharge-btn" data-clipboard-action="copy" data-clipboard-target="#recharge">获取</button>
					</div>
					<!-- panel -->
				</div>	
			</c:if>
			
			<c:if test="${not flag }"></c:if>
			
		</div>
		<!-- mainpanel -->
		<%@ include file="../assets/pages/rightpanel.jsp"%>
	</section>

	<%@ include file="../assets/pages/foot.jsp"%>
	<script src="${rootPath}assets/js/jquery.datatables.min.js"></script>
	<script src="${rootPath}assets/js/clipboard.js"></script>
	<script src="${rootPath}assets/js/select2.min.js"></script>
    <script src="${rootPath}assets/js/jquery.validate.min.js"></script>
	<script type="text/javascript">
		jQuery(document).ready(function() {

			$(".nav-parent").eq(0).addClass("nav-active");
      		$(".nav-parent").eq(0).find(".children").show();
      		     				
		});
		var clipboard = new Clipboard('.register-btn');
        clipboard.on('success', function(e) {
            alert("复制成功，快去分享吧！");
        });

        clipboard.on('error', function(e) {
        	alert("复制成功，快去分享吧！");
        });
		var clipboard = new Clipboard('.recharge-btn');
        clipboard.on('success', function(e) {
        	alert("复制成功，快去分享吧！");
        });

        clipboard.on('error', function(e) {
        	alert("复制成功，快去分享吧！");
        });
	</script>

</body>
</html>
