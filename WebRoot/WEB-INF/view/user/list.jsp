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
					<i class="fa fa-user"></i> 用户管理 <span>用户列表</span>
				</h2>
			
			</div>
			
			<div class="contentpanel">
				<!-- content goes here... -->
				<div class="panel panel-default">
					<div class="panel-heading">
						<div class="panel-btns">
						 	<a href="" class="minimize">&minus;</a>
						</div>
						<!-- panel-btns -->
						<h3 class="panel-title">数据列表</h3>
					</div>
					<div class="panel-body">
						<br />
						<div class="table-responsive">
							<table id="dataTable" class="table">
								<thead>
									<tr>
										<th>用户名</th>
										<th>邮箱</th>
										<th>手机</th>
										<th>编辑</th>
									</tr>
								</thead>
							</table>
						</div>
						<!-- table-responsive -->
					</div>
					<!-- panel-body -->
				</div>
				<!-- panel -->
			</div>
		</div>
		<!-- mainpanel -->
		<%@ include file="../assets/pages/rightpanel.jsp"%>
	</section>

	<%@ include file="../assets/pages/foot.jsp"%>
	<script src="${rootPath}assets/js/jquery.datatables.min.js"></script>
	<script src="${rootPath}assets/js/select2.min.js"></script>
    <script src="${rootPath}assets/js/jquery.validate.min.js"></script>

    <!-- Modal 保存数据时出错-->
    <div class="modal fade" id="msgModal" tabindex="-1" role="dialog"
        aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">信息</h4>
                </div>
                <div class="modal-body">保存数据时出错了</div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
            <!-- modal-content -->
        </div>
        <!-- modal-dialog -->
    </div>
    <!-- modal -->
    
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
    
    <script src="${rootPath}assets/js/jquery.messager.js"></script>
	<script type="text/javascript">
		jQuery(document).ready(function() {

			$(".nav-parent").eq(2).addClass("nav-active");
      		$(".nav-parent").eq(2).find(".children").show();
      		     				
			var t = jQuery('#dataTable').DataTable({
				searching:false,
				pageLength: 10,
				processing: true,
				language: datatable_local_language, // my.js
				serverSide: true,
				stateSave:true,
				ajax: {
					url: '${rootPath}user/list.do',
					
					dataFilter: function(data){
			            var json = jQuery.parseJSON( data );
			            json.recordsTotal = json.countTotal;
			            json.recordsFiltered = json.countFiltered;
			            json.data = json.data;
			            return JSON.stringify( json );
			        }
				},
				columnDefs: [
					{
				           data: "loginName",
				           orderable: false,
				           render: function ( data ) {
				        	   return '<div>' + data +'</div>';
				           },
				               targets: 0
					},
				    {
				           data: "email",
				           orderable: false,
				           render: function ( data ) {
				        	   return '<div>' + data +'</div>';
				           },
				               targets: 1
					},
				    {
				           data: "mobilephone",
				           orderable: false,
				           render: function ( data ) {
				        	   return '<div>' + data +'</div>';
				           },
				               targets: 2
					},
					      {
					          data: "userId",
						      orderable: false,
						      render: function ( data, type, full, meta ) {
						    	  var operations = '<a class="btn btn-success btn-xs" id="'+data+'"><span class="fa fa-edit"></span> 编辑</a>';
						    	  if (1 == full.invalid) {
						    		  operations += '&nbsp; <a class="btn btn-default btn-warning-disable btn-xs" id="'+data+'"><span class="fa fa-minus-circle"></span> 禁用</a>';
						    	  } else {
						    		  operations += '&nbsp; <a class="btn btn-warning btn-warning-enable btn-xs" id="'+data+'"><span class="fa fa-minus-circle"></span> 取消禁用</a>';
						    	  }
				              		return operations;
						  	  },
						      targets: 3
						  },				             
				  {
					  orderable: false,
					  searchable: false
				  },
				],
				columns: [
		            { data: "loginName" },
		            { data: "email" },
		            { data: "mobilephone" },
		            { data: "userId" }
		        ]
			});
			
			$('#dataTable tbody').on( 'click', 'a.btn-success', function () {
		        var data = t.row($(this).parents('tr')).data();
		        edit($(this).attr('id'));
		    } );

			$('#dataTable tbody').on( 'click', 'a.btn-danger', function () {
		        var data = t.row($(this).parents('tr')).data();
		        
		        var userId = $(this).attr('id')
	            $.post('${rootPath}user/countTransfer.do?userId=' + userId, function(result) {
	                var rmsg = result.text.split(",");
	                $("#countDelTransferCase").html(rmsg[0]);
	                $("#countDelTransferCustomer").html(rmsg[1]);
	            }, "JSON");
		        
		        del($(this).attr('id'));
		    } );
			
			$('#dataTable tbody').on( 'click', 'a.btn-warning-disable', function () {
		        var data = t.row($(this).parents('tr')).data();
		        $("#userId").val($(this).attr('id'));
		        
		        var userId = $("#userId").val();
		        disable($(this).attr('id'));
		    } );
			
			$('#dataTable tbody').on( 'click', 'a.btn-warning-enable', function () {
		        var data = t.row($(this).parents('tr')).data();
		        $("#userId").val($(this).attr('id'));
		        
		        var userId = $("#userId").val();
		        enable($(this).attr('id'));
		    } );
			
			$('#confirmDelModal').on( 'click', 'button.btn-danger', function () {
		        var id = $("#confirmDelModal .hiddenId").val();
		        var operator = $("#delTransferOperator").val();
		        if(operator === "" || operator === null){
		        	msg("提示信息","请选择跟单员");
		        } else {
		        	doDel(id,operator);	
		        }
		        
		    } ); 
		    
			// Select2
		    jQuery('select').select2({
		        minimumResultsForSearch: -1
		    });
		    
		    jQuery('select').removeClass('form-control');
			
		});
        
        $("#delPreviousOperator").change(function() {
        	var userId = $("#confirmDelModal .hiddenId").val();
        	$.post('${rootPath}user/countTransfer.do?userId=' + userId, function(result) {
                var rmsg = result.text.split(",");
                $("#countDelTransferCase").html(rmsg[0]);
                $("#countDelTransferCustomer").html(rmsg[1]);
            }, "JSON");
        });
        
        function edit(id) {
			window.parent.location = "${rootPath}user/edit.html?id="+id;
		}
		
		function del(id) {
			$("#confirmDelModal .hiddenId").val("");
			$("#confirmDelModal .hiddenId").val(id);
			$("#confirmDelModal").modal('show');
		}
		
		function disable(id) {
			$("#confirmDisableModal .hiddenId").val("");
			$("#confirmDisableModal .hiddenId").val(id);
			$("#confirmDisableModal").modal('show');
		}
		
		function enable(id) {
			$("#confirmEnableModal .hiddenId").val("");
			$("#confirmEnableModal .hiddenId").val(id);
			$("#confirmEnableModal").modal('show');
		}
		
		function doDel(id,operator){
			$.ajax({
				url: "${rootPath}user/del.do?id=" + id + "&operator=" + operator, 
				async: true,
				success: function(o) {
					window.location.reload();
				},
				error: function(o) {
					alert(2);
				}
			});		
		}	
		
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
		
		function transferUser_submit(){
            var f = $("#form-transferUser").serialize();
            $.post('${rootPath}user/transferUser.do', f, function(result) {
                var rmsg = result.msg;
                if (result.success) {
                    window.parent.location = "${rootPath}user/list.html?flag=old";
                } 
                else {
                    $("#msgModal").modal('show');
                }
            }, "JSON");
        }
		
		  function msg(title,context){
		        $.messager.lays(200, 300); //窗口大小
		        $.messager.anim('show',1000); 
		        $.messager.show(title, context,3000); //标题，内容，时间（秒）
		    }
	</script>

</body>
</html>
