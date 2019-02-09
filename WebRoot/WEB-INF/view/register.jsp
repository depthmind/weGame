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
						<h4 class="nomargin">注  册</h4>
						<div class="error">
							<label class="error"></label>
						</div>
						<input type="text" class="form-control uname" placeholder="账号" name="loginName" required /> 
						<input type="password" class="form-control pword" placeholder="密码" name="pwd" id="pwd1" required />
						<input type="password" class="form-control pword-repeat" placeholder="密码" name="pwd-repeat" required />
						<input type="text" hidden="hidden" value="${agencyId }"/>
						<button class="btn btn-success btn-block">确  定</button>
						<a href="${rootPath }signin.html">已有账号?去登录>></a>
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
			var formValid = $("#form").validate({
		        rules: {
		            "loginName":{
		                "required":true,        //必填字段
		            },
		            "pwd":{
		                "required":true        
		            },
		            "pwd-repeat":{
		                "required":true,
		                "equalTo": "#pwd1"        //输入值必须和 #pwd 相同
		            }
		        },
		        messages: {
		            "loginName":{
		                "required":"用户名不能为空哦"
		            },
		            "pwd":{
		                "required":"密码不能为空哦"
		            },
		            "pwd-repeat":{
		                "required":"确认密码不能为空哦",
		                "equalTo":"两次输入的密码不一致哦"
		            }
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
				    	register();
				      return false;
				    }
		    });
			
			function register() {
				var f = $("#form").serialize();
				$.post('${rootPath}register.do', f, function(result) {
					
					$("#form div.error").hide();
					$("#form div.error label.error").hide();
					jQuery("#form div.error label.error").text("");
					
					var rmsg = result.success;
					
					if (rmsg) {
						$("#form div.error").hide();
						$("#form div.error label.error").hide();
						jQuery("#form div.error label.error").text("");
						window.parent.location = "${rootPath}signin.html";
					} else {
						$("#form div.error").show();
						$("#form div.error label.error").show();
						jQuery("#form div.error label.error").text(rmsg);
					}
				}, "JSON");
			}
		});
			      
	</script>
</body>
</html>
