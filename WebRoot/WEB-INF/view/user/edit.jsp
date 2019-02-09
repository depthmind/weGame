<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../assets/pages/head.jsp"%>
</head>

<body>
	<%@ include file="../assets/pages/preloader.jsp"%>
	<section>
		<%@ include file="../assets/pages/leftpanel.jsp"%>
		<div class="mainpanel">
			<%@ include file="../assets/pages/headerbar.jsp"%>
			<div class="pageheader">
				<h2>
					<i class="fa fa-user"></i> 用户管理 <span>编辑用户</span>
				</h2>
			</div>
			<div class="contentpanel">
				<!-- content goes here... -->

		<div class="panel panel-default">
        <div class="panel-heading">
          <div class="panel-btns">
            <a href="" class="minimize">&minus;</a>
          </div>
          <h4 class="panel-title">用户基本信息</h4>
          <p>填写下表，完成用户信息修改。</p>
        </div>
        <form class="form-horizontal" id="form">
        <div class="panel-body panel-body-nopadding">
          
	        <div class="section-block"> 
	            <div class="form-group col-sm-6">
	              <label class="col-sm-3 control-label">登录名<span class="asterisk">*</span></label>
	              <div class="col-sm-6">
	                <input readonly="readonly" type="text" id="loginName" name="loginName" placeholder="登录名" class="form-control" value="${user.loginName }" />
	              </div>
	            </div>
	            <div class="form-group col-sm-6">
	              <label class="col-sm-3 control-label">姓名<span class="asterisk">*</span></label>
	              <div class="col-sm-6">
	                <input readonly="readonly" type="text" name="name" placeholder="姓名" class="form-control" value="${user.name }" />
	              </div>
	            </div> 
	            <div class="form-group col-sm-6">
	              <label class="col-sm-3 control-label">手机<span class="asterisk">*</span></label>
	              <div class="col-sm-6">
	                <input readonly="readonly" type="text" name="mobilephone" placeholder="手机" class="form-control" value="${user.mobilephone }" />
	              </div>
	            </div>            
	            <div class="form-group col-sm-6">
	              <label class="col-sm-3 control-label">邮箱<span class="asterisk">*</span></label>
	              <div class="col-sm-6">
	                <input readonly="readonly" type="text" name="email" placeholder="邮箱" class="form-control" value="${user.email }" />
	              </div>
	            </div>
	            <div class="form-group col-sm-6">
	            <label class="col-sm-3 control-label">有效期<span class="asterisk">*</span></label>
                   	<div class="col-sm-6 input-group input-datepicker" style="padding: 0;">
	                    <input readonly="readonly" id="invalidDate" type="text" name="invalidDate" class="form-control datepicker" placeholder="请点击截止日期" value="${user.invalidDateStr}" autocomplete="on">
	                    <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                	</div>
                </div>
	        </div>
          
        </div><!-- panel-body -->
        
        <div class="panel-footer align-center">
        	<input id="editUser" class="btn btn-primary" type="submit" value="保存"/>&nbsp;
			<input class="btn btn-danger" type="button" id="btn-disable" value="禁用"/>&nbsp;
			<input class="btn btn-warning" type="button" id="btn-enable" value="解除禁用"/>&nbsp;
			<input class="btn btn-default" type="button" id="btn-back" value="返回"/>
			<input type="hidden" name="userId" value="${user.userId }" />
		</div><!-- panel-footer -->
     </form>   
     
		<!-- mainpanel -->
		<%@ include file="../assets/pages/rightpanel.jsp"%>
	</section>


<!-- Modal -->
<div class="modal fade" id="msgModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">信息</h4>
      </div>
      <div class="modal-body">
        保存数据时出错了
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      </div>
    </div><!-- modal-content -->
  </div><!-- modal-dialog -->
</div><!-- modal -->

<div class="modal fade" id="confirmDisableModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel"><span class="fa fa-warning"></span> 提示</h4>
      </div>
      <div class="modal-body">
        确定封禁该用户么？
      </div>
      <div class="modal-footer">
        <input type="hidden" class="hiddenId" value="" />
        <button class="btn btn-default" data-dismiss="modal">取消</button>
        <button class="btn btn-danger">删除</button>
      </div>
    </div><!-- modal-content -->
  </div><!-- modal-dialog -->
</div><!-- modal -->

<div class="modal fade" id="confirmEnableModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel"><span class="fa fa-warning"></span> 提示</h4>
      </div>
      <div class="modal-body">
        确定解除对该用户的封禁么？
      </div>
      <div class="modal-footer">
        <input type="hidden" class="hiddenId" value="" />
        <button class="btn btn-default" data-dismiss="modal">取消</button>
        <button class="btn btn-danger">删除</button>
      </div>
    </div><!-- modal-content -->
  </div><!-- modal-dialog -->
</div><!-- modal -->

	<%@ include file="../assets/pages/foot.jsp"%>
	<script src="${rootPath}assets/js/select2.min.js"></script>
	<script src="${rootPath}assets/js/jquery-ui-1.10.3.min.js"></script>
	<script src="${rootPath}assets/js/jquery.datatables.min.js"></script>
	<script src="${rootPath}assets/js/jquery.validate.min.js"></script>
	
	<script type="text/javascript">
		jQuery("#invalidDate").datepicker({
	        dateFormat: "yy-mm-dd",
	        changeYear: true,
	        changeMonth: true,
	     });
		jQuery(document).ready(function() {
			$(".nav-parent").eq(2).addClass("nav-active");
      		$(".nav-parent").eq(2).find(".children").show();
      		
			var invalid = ${user.invalid};
			if ('1' == invalid) {
				$("#btn-enable").attr("type","hidden");
			} else {
				$("#btn-disable").attr("type","hidden");
			}
      		$.validator.addMethod("passrule",function(value,element,params){
      			var re = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,12}$/
      			if(!re.test(value)){
      				return false;
      			}
			});
			jQuery("#form").validate({
				rules: {
					name: {
						required:true,
						isName:true,
					},
				/*    pwd: {
						required:true,
						isPassword:true
					},  */
					email:{
						required:true,
						email:"email",
					},
					mobilephone:{
						required:true,
						isMobile:true
					},
					loginName:{  
			         	required:true,  
			            remote:{                           
			            	url:"${rootPath}validate.do",
			            	type:"post",
			            	data: {
		                         table: function () { return "user"},
		                         field: function () { return "loginName"},
		                         name: function () { 
		                        	 if($("#loginName").val()=="${user.loginName}"){
		                        	 	return "";
		                        	 }
		                        	 else{return $("#loginName").val();}
		                         },
		                    }
			            },
			            isLoginName:true,
			        },
			        invalidDate:{
			        	required:true
			        }
				},
				messages: {
					name:{
						required:"请输入姓名",
						},
					loginName: {
						required:"请输入值",
						remote:"该用户名已存在，请重新输入"
					},
					email: {
						required:"请输入邮箱",
						email:"请输入有效的邮箱"
					},
					mobilephone:{
						required:"请输入手机号"
					},
					invalidDate:{
			        	required:"请选择日期"
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
			      //$("#editUser").attr("disabled","disabled");
			      form_submit();
			      return false;
			    }
			});
			
			//验证手机号码
			jQuery.validator.addMethod("isMobile", function(value, element) {  
    			var length = value.length;  
    			var regPhone = /^1([3578]\d|4[57])\d{8}$/;  
    			return this.optional(element) || ( length == 11 && regPhone.test( value ) );    
			}, "请正确填写您的手机号码");
			//验证密码，6-12位字母和数字的组合  
			jQuery.validator.addMethod("isPassword", function(value, element) {    
			    var tel = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,12}$/;  
			    return this.optional(element) || (tel.test(value));  
			}, "请输入6-12位字母和数字的组合"); 
			jQuery.validator.addMethod("isLoginName", function(value, element) {  
				var length = value.length;  
				return length <=15;    
			}, "请少于15字");
			jQuery.validator.addMethod("isName", function(value, element) {  
				var length = value.length;  
				return length <=15;    
			}, "请少于15字");

			$("#btn-back").click( function () {
				history.go(-1);
		    } ); 
		});
			      
		function form_submit() {
			var f = $("#form").serialize();
			$.post('${rootPath}user/edit.do', f, function(result) {
				var rmsg = result.msg;
				if (result.success) {
					window.location.reload();
				} else {
					$("#msgModal").modal('show');
				}
			}, "JSON");
		}
		
		$("#btn-disable").click(function(){
			$("#confirmDisableModal .hiddenId").val("");
			$("#confirmDisableModal .hiddenId").val("${user.userId }");
			$("#confirmDisableModal").modal('show');
		});
		
		$('#confirmDisableModal').on( 'click', 'button.btn-danger', function () {
	        var id = $("#confirmDisableModal .hiddenId").val();
	        doDisable(id);
	    } );
		
		function doDisable(id){
			$.ajax({
				url: "${rootPath}admin/disable.do?id=" + id, 
				async: true,
				success: function(o) {
					window.location.reload();
				},
				error: function(o) {
					alert(2);
				}
			});		
		}	
		
		$("#btn-enable").click(function(){
			$("#confirmEnableModal .hiddenId").val("");
			$("#confirmEnableModal .hiddenId").val("${user.userId }");
			$("#confirmEnableModal").modal('show');
		});
		
		$('#confirmEnableModal').on( 'click', 'button.btn-danger', function () {
	        var id = $("#confirmEnableModal .hiddenId").val();
	        doEnable(id);
	    } );
		
		function doEnable(id){
			$.ajax({
				url: "${rootPath}admin/enable.do?id=" + id, 
				async: true,
				success: function(o) {
					window.location.reload();
				},
				error: function(o) {
					alert(2);
				}
			});		
		}
	</script>

</body>
</html>
