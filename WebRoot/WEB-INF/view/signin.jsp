<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="./assets/pages/head.jsp" %>
</head>

<body class="signin">
	<div class="signin-topbar">
		<div class="top">
			<div class="container">
				<!-- 此处放logo -->
			</div>
		</div>
		<div class="bottom"></div>
	</div>
	<section>

		<div class="signinpanel">

			<div class="row">

				<div class="right">

					<form method="post" id="form">
						<h4 class="nomargin">登  录</h4>
						<div class="error">
							<label class="error"></label>
						</div>
						<input type="text" class="form-control uname"
							placeholder="账号" name="loginName" required /> <input
							type="password" class="form-control pword" placeholder="密码"
							name="pwd" required /> <br><a href="#"><small></small></a>
						<button class="btn btn-success btn-block">确  定</button>
					</form>
				</div>
				<!-- col-sm-5 -->

			</div>
			<!-- row -->

		</div>
		<!-- signin -->

	</section>

	<%@ include file="./assets/pages/foot.jsp" %>
	<script src="${rootPath}assets/js/jquery.validate.min.js"></script>
	
	<script type="text/javascript">
		jQuery(document).ready(function() {
			jQuery("#form").validate({
				messages: {
					loginName: "请输入用户名!",
					pwd: "请输入密码!"
				},
			    highlight: function(element) {
			      jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
			    },
			    success: function(element) {
			      jQuery(element).closest('.form-group').removeClass('has-error');
			    },
			    invalidHandler : function(){
			      return false;
			    },
			    submitHandler : function(){
			      signin();
			      return false;
			    }
			  });
		});
			      
		function signin() {
			var f = $("#form").serialize();
			$.post('${rootPath}signin.do', f, function(result) {
				
				$("#form div.error").hide();
				$("#form div.error label.error").hide();
				jQuery("#form div.error label.error").text("");
				
				var rmsg = result.msg;
				
				if (result.success) {
					$("#form div.error").hide();
					$("#form div.error label.error").hide();
					jQuery("#form div.error label.error").text("");
					window.parent.location = "${rootPath}main.html";
				} else {
					$("#form div.error").show();
					$("#form div.error label.error").show();
					jQuery("#form div.error label.error").text(rmsg);
				}
			}, "JSON");
		}
	</script>
</body>
</html>
