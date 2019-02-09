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
					业绩查询 <span>充值记录</span>
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
						<h3 class="panel-title">总金额:${totalAmount }</h3>
					</div>
					<div class="panel-body">
						<%-- <div>总金额:${totalAmount }</div> --%>
						<div class="table-responsive">
							<table id="dataTable" class="table">
								<thead>
									<tr>
										<!-- <th>玩家ID</th> -->
										<th>玩家姓名</th>
										<th>玩家账户</th>
										<th>金额</th>
										<th>支付方式</th>
										<!-- <th>编辑</th> -->
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
	<script type="text/javascript">
		jQuery(document).ready(function() {

			$(".nav-parent").eq(0).addClass("nav-active");
      		$(".nav-parent").eq(0).find(".children").show();
      		     				
			var t = jQuery('#dataTable').DataTable({
				searching:false,
				pageLength: 10,
				processing: true,
				language: datatable_local_language, // my.js
				serverSide: true,
				stateSave:true,
				ajax: {
					url: '${rootPath}agency/achievement.do',
					
					dataFilter: function(data){
			            var json = jQuery.parseJSON( data );
			            json.recordsTotal = json.countTotal;
			            json.recordsFiltered = json.countFiltered;
			            json.data = json.data;
			            return JSON.stringify( json );
			        }
				},
				columnDefs: [
		                     /* {
				                data: "playerId",
				                orderable: false,
				                render: function ( data ) {
				                	return data;
			                    },
			                  targets: 0
						      }, */
						      {
						           data: "playerName",
						           orderable: false,
						           render: function ( data ) {
						        	   return data;
						           },
						               targets: 0
							  },
						      {
					                data: "playerAccount",
					                orderable: false,
					                render: function ( data ) {
					                	return data;
				                    },
				                  targets: 1
							      },
							      {
							          data: "amount",
								      orderable: false,
								      render: function ( data, type, full, meta ) {
						              		return data;
								  	  },
								      targets: 2
								  },
								  {
							          data: "paymentMethod",
								      orderable: false,
								      render: function ( data, type, full, meta ) {
						              		return data;
								  	  },
								      targets: 3
								  },
							      /* {
							          data: "rechargeId",
								      orderable: false,
								      render: function ( data, type, full, meta ) {
						              		return '<a class="btn btn-success btn-xs" id="'+data+'"><span class="fa fa-edit"></span> 编辑</a>&nbsp; <a class="btn btn-danger btn-xs" id="'+data+'"><span class="fa fa-minus-circle"></span> 删除</a>';
								  	  },
								      targets: 4
								  }, */				             
							      				             
							      				             
				  {
					  orderable: false,
					  searchable: false,
				      targets: [0,1,2]
				  },
				],
				columns: [
		            /* { data: "palyerId" }, */
		            { data: "playerName" },
		            { data: "playerAccount" },
		            { data: "amount" },
		            { data: "paymentMethod" }
		            /* { data: "rechargeId" } */
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
			
			$('#dataTable tbody').on( 'click', 'a.btn-warning', function () {
		        var data = t.row($(this).parents('tr')).data();
		        $("#userId").val($(this).attr('id'));
		        
		        var userId = $("#userId").val();
	            
	            $.post('${rootPath}user/countTransfer.do?userId=' + userId, function(result) {
	                var countGroup = result.text.split(",");
	                $("#countTransferCase").html(countGroup[0]);
	                $("#countTransferCustomer").html(countGroup[1]);
	            }, "JSON");
	            
	            
		        transfer($(this).attr('id'));
		    } );
			
		});
		
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
		
	</script>

</body>
</html>
