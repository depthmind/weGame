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
					<i class="glyphicon glyphicon-cog"></i> 系统管理 <span>邮件日志列表</span>
				</h2>
			</div>
			<div class="contentpanel">
				<!-- content goes here... -->
				<div class="panel panel-default">
					<div class="panel-heading">
						<div class="panel-btns">
							<a href="" class="minimize">&minus;</a>
						</div>
						<h3 class="panel-title">邮件日志管理列表</h3>
						<div class="row" style="margin-top: 20px">
							<div class="form-group col-sm-10">
							<div class="col-sm-2">
									<input type="text" name="searchOrderId" id="searchOrderId" class="form-control" placeholder="订单ID"  value="${searchMail.orderId }" />
								</div> 
								 <label class="col-sm-1 control-label" style="float:left;width:85px;margin-top:10px;">创建时间：</label>
								<div class="col-sm-2">
									<div class="input-group input-datepicker" style="padding: 0;">
				                        <input readonly="readonly" id="searchStartTime" type="text" name="searchStartTime" class="form-control datepicker" placeholder="请点击输入查询开始日期" value="${searchMail.searchStartTime }" autocomplete="on">
				                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				                    </div>
				                </div>
			                    <div class="col-sm-2">
				                    <div class="input-group input-datepicker" style="padding: 0;">
				                        <input readonly="readonly" id="searchEndTime" type="text" name="searchEndTime" class="form-control datepicker" placeholder="请点击输入查询截止日期" value="${searchMail.searchEndTime }" autocomplete="on">
				                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				                    </div>
			                    </div>
			                      <div class="dateregion col-sm-3">	
			                    	<a class="thismonth" href="javascript:void(0);">本月</a>
			                    	<a class="lastmonth" href="javascript:void(0);">上月</a>	
			                    	<a class="thishalfyear" href="javascript:void(0);">近半年</a>	
			                    	<a class="alltime" href="javascript:void(0);">全部</a>	
							      </div> 	
									<input class="btn btn-primary" type="button" id="searchBtn" value="搜索"/>
									<input type="hidden" id="searchFlag"  value="${flag}" />
								</div>	
							</div>

							</div>	
						</div>
					</div>
					<div class="panel-body">
						<div class="table-responsive">

							<table id="dataTable" class="table">
								<thead>
									<tr>
										<th>订单ID</th>
										<th>邮件类型</th>
										<th>发件账户</th>
										<th>预计发送时间</th>
										<th>发件人名</th>
										<th>发件邮箱 </th>
										<th>收件人名</th>
										<th>收件邮箱</th>
										<th>抄送人名</th>
										<th>抄送邮箱</th>
										<th>主题</th>
										<th>邮件内容</th>
										<th>附件链接</th>
										<th>发送状态</th>
										<th>发送时间</th>
										<th>尝试次数</th>
										<th>创建时间</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
					</div>
				</div>
		<%@ include file="../assets/pages/rightpanel.jsp"%>
	</section>
	<%@ include file="../assets/pages/foot.jsp"%>


<!-- email Modal -->
<div class="modal fade" id="emailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" style="width: 730px;">
    <div class="modal-content">
      <button style="margin: 10px;" type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
      <div class="modal-body" style="clear: both;">
        
      </div>
    </div><!-- modal-content -->
  </div><!-- modal-dialog -->
</div><!-- modal -->

	<script src="${rootPath}assets/js/jquery.datatables.min.js"></script>
	<script src="${rootPath}assets/js/select2.min.js"></script>
	<script src="${rootPath}assets/js/jquery-ui-1.10.3.min.js"></script>
	<script src="${rootPath}assets/js/jquery.validate.min.js"></script>
	<script src="${rootPath}assets/js/datepicker-zh-CN.js"></script>
	<script src="${rootPath}assets/js/datetimepicker-cn.js"></script>

	<script type="text/javascript">
	//设置日历控件
	 $("#searchStartTime").datepicker({
	        dateFormat: "yy-mm-dd",
	        changeYear: true,
	        changeMonth: true
	     });
	    
   	$("#searchEndTime").datepicker({
        dateFormat: "yy-mm-dd",
        changeYear: true,
        changeMonth: true
     });
	var table= $('#dataTable').DataTable({
		searching:false,
		pageLength: 10,
		processing: true,
		language: datatable_local_language, // my.js
		serverSide: true,
		stateSave: true,
		ajax: {
			url: '${rootPath}parameter/mailqueue.do',
			data:function(data){
				data.orderId =$("#searchOrderId").val();
				data.searchStartTime =$("#searchStartTime").val();
				data.searchEndTime =$("#searchEndTime").val();
			},
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
		            	 targets: 0,
		            	 orderable: false,
		            	 render: function(data, type, full, meta ) {
		            		 if(full.orderId==0){
		            			 return "";
		            		 }
		            		 return full.orderId;
		            		 }
		             },
		             {
		            	 targets: 1,
		            	 orderable: false,
		            	 render: function(data, type, full, meta ) {
		            		 return full.mailType;
		            		 }
		             },
		             {
		            	 targets: 2,
		            	 orderable: false,
		            	 render: function(data, type, full, meta ) {
		            		 return full.acount;
		            		 }
		             },
		             {
		            	 targets: 3,
		            	 orderable: false,
		            	 render: function(data, type, full, meta ) {
		            		 if(full.prepSendTime!=null){
			            		 var m = full.prepSendTime.time;
				                	if(full.prepSendTime){
				                		m=new Date(m).format("yyyy-MM-dd hh:mm:ss");
				                		return m;
				                	}else{
				                	m="";
				                	}
			            		 }
			            		 return "";
			            		 }
		             },
		             {
		            	 targets: 4,
		            	 orderable: false,
		            	 render: function(data, type, full, meta ) {
		            		 return full.sendName;
		            		 }
		             },
		             {
		            	 targets: 5,
		            	 orderable: false,
		            	 render: function(data, type, full, meta ) {
		            		 return full.sender;
		            		 }
		             },
		             {
		            	 targets: 6,
		            	 orderable: false,
		            	 render: function(data, type, full, meta ) {
		            		 return full.recieveName;
		            		 }
		             },
		             {
		            	 targets: 7,
		            	 orderable: false,
		            	 render: function(data, type, full, meta ) {
		            		 return full.reciever;
		            		 }
		             },
		             {
		            	 targets: 8,
		            	 orderable: false,
		            	 render: function(data, type, full, meta ) {
		            		 return full.bccName;
		            		 }
		             },
		             {
		            	 targets: 9,
		            	 orderable: false,
		            	 render: function(data, type, full, meta ) {
		            		 return full.bcc;
		            		 }
		             },
		             {
		            	 targets: 10,
		            	 orderable: false,
		            	 render: function(data, type, full, meta ) {
		            		 return full.subject;
		            		 }
		             },
		             {
		            	 targets: 11,
		            	 orderable: false,
		            	 render: function( data, type, full, meta ) {
		            			 var f1=full.content.replace(/<\/?.+?>/g,"");
		            			 var f2=f1.replace(/ /g,"");
		            			 var f3=f2.replace(/<\!--/g,"");
		            			 var f4=f3.replace(/\-->/g,"");
		            			 var f5=f4.substring(0,f4.length/2); 
		            			 if(f5.length > 24){
										return "<div style='cursor:pointer;' class='width150 email-summary'>" + f5.substring(0,28) + "...</div><div style='display:none;' class='email-content'>"+full.content+"</div>"
									}else{
										return "<div class='width150'>" + f5 + "</div>"
									}	
		            		 return  f5;
		            		 }
		             },
		             {
		            	 targets: 12,
		            	 orderable: false,
		            	 render: function(data, type, full, meta ) {
		            		 if(full.fileUrl.length > 24){
									return "<div class='width150' data-toggle='tooltip' data-placement='bottom' title='" + full.fileUrl + "'>" + full.fileUrl.substring(0,28) + "...</div>"
								}else{
									return "<div class='width150'>" + full.fileUrl + "</div>"
								}	
		            		 return full.fileUrl;
		            		 }
		             },
		             {
		            	 targets: 13,
		            	 orderable: false,
		            	 render: function( data, type, full, meta ) {
		            		 if(full.mailstatus=="yes"){
		            			 return "已发送";
		            		 }else{
		            			 return "未发送";
		            		 }
		            		 }
		             },
		             {
		            	 targets: 14,
		            	 orderable: false,
		            	 render: function( data, type, full, meta ) {
		            		 if(full.sendTime!=null){
			            		 var s = full.sendTime.time;
				                	if(full.sendTime){
				                		s=new Date(s).format("yyyy-MM-dd hh:mm:ss");
				                		return s;
				                	}else{
				                		s="";
				                	}
			            		 }
			            		 return "";
			            		 }
		             },
		             {
		            	 targets: 15,
		            	 orderable: false,
		            	 render: function( data, type, full, meta ) {
		            		 return full.tryTimes;
		            		 }
		             },
		             {
		            	 targets: 16,
		            	 orderable: false,
		            	 render: function( data, type, full, meta ) {
		            		 if(full.createTime!=null){
		            		 var q = full.createTime.time;
			                	if(full.createTime){
			                		q=new Date(q).format("yyyy-MM-dd hh:mm:ss");
			                		return q;
			                	}else{
			                	q="";
			                	}
		            		 }
		            		 return "";
		            		 }
		             },
		             ],
		columns: [
		            { data: "orderId" },
		            { data: "mailType" },
		            { data: "acount" },
		            { data: "prepSendTime" },
		            { data: "sendName" },
		            { data: "sender" },
		            { data: "recieveName"},
		            { data: "reciever" },
		            { data: "bbcName"},
		            { data: "bbc" },
		            { data: "subject" },
		            { data: "content"},
		            { data: "fileUrl"},
		            { data: "mailstatus"},
		            { data: "sendTime"},
		            { data: "tryTimes"},
		            { data: "createTime"}
		        ]
		});
	//设置搜索的点击事件
	$('#searchBtn').on( 'click', function () {
			//通知后台，使用界面的条件来重绘table
		$('#searchFlag').val("restart");
        table.draw();
	} );
	if($('#searchFlag').val()=="restart"){
		table.ajax.reload();
	}
	</script>
	<script>
$(document).ready(function () {

	$(".nav-parent").eq(9).addClass("nav-active");
  	$(".nav-parent").eq(9).find(".children").show();
	
	 $('#dataTable').on('click','.email-summary',function(){ 
		var emailcontent = $(this).next(".email-content").html();
		$("#emailModal .modal-body").html(emailcontent);
		$("#emailModal").modal('show');
	});

	$(".thismonth").click(function () {
  		$(this).siblings().removeClass("active");
  		$(this).addClass("active");

  		var today = new Date();
  		var year = today.getFullYear();
  		var month= today.getMonth()+1;//本月
  		var day = today.getDate();

  		 if(month<10){
  	  		$("#searchStartTime").val(year + "-"+"0"+ month + "-"+"0"+ 1);
  	        }else{
  	        $("#searchStartTime").val(year + "-"+ month + "-"+"0"+ 1);
  	        }
  		 if(month<10&&day<10){
  			 $("#searchEndTime").val(year + "-"+"0"+ month + "-"+"0" + day);
  	       }else if(month>=10&&day>=10){
  	    	 $("#searchEndTime").val(year + "-"+ month + "-" + day);
  	       }else if(month>10&&day<10){
  	    	 $("#searchEndTime").val(year + "-"+ month + "-"+"0" + day);
  	       }else if(month<10&&day>10){
  	    	 $("#searchEndTime").val(year + "-"+"0"+ month + "-" + day);
  	       }
  	});
  	$(".lastmonth").click(function () {
  		$(this).siblings().removeClass("active");
  		$(this).addClass("active");

  		var today = new Date();
  		var year = today.getFullYear();
  		var month= today.getMonth();//上月
  		var day = today.getDate();

  		var myDate = new Date(year, month, 0);
		//上个月的最后一天
  		if(month<10){
        	if(month==0){
        		$("#searchStartTime").val(year-1 + "-"+"12" + "-"+"0"+ 1);
        	}else{
        		$("#searchStartTime").val(year + "-"+"0" + month + "-"+"0"+ 1);
        	}
        }else{
        	$("#searchStartTime").val(year + "-"+ month + "-"+"0"+ 1);
        }
		if(month<10){
			if(month==0){
        		$("#searchEndTime").val(year-1 + "-"+"12"+ "-" + myDate.getDate());
        	}else{
        		$("#searchEndTime").val(year + "-"+"0"+ month + "-" + myDate.getDate());
        	}
		}else{
			$("#searchEndTime").val(year + "-"+ month + "-" + myDate.getDate());
		}
  	});
  	
  	$(".thishalfyear").click(function () {
  		$(this).siblings().removeClass("active");
  		$(this).addClass("active");

  		var today = new Date();
  		var year = today.getFullYear();
  		var year1 = year;
  		var month= today.getMonth()+1;//本月
  		if(month<7){
  			year1 = year1-1;
  		}
  		var day = today.getDate();
  		
  		var curDate = (new Date()).getTime();
  	    var halfYear = 365 / 2 * 24 * 3600 * 1000;
  	    var pastResult = curDate - halfYear;  // 半年前的时间（毫秒单位）
  	    var pastDate = new Date(pastResult),
  	        pastYear = pastDate.getFullYear(),
  	        pastMonth = pastDate.getMonth() + 1,
  	        pastDay = pastDate.getDate();
  	    
  		/* var mymonth = 12+month-6; */
  		 if(pastMonth<10&&pastDay<10){
   	  		$("#searchStartTime").val(pastYear + "-"+"0"+ pastMonth + "-"+"0" + pastDay);
   	       }else if(pastMonth>=10&&pastDay>=10){
   	    	$("#searchStartTime").val(pastYear +"-"+ pastMonth + "-" + pastDay); 
   	       }else if(pastMonth>10&&pastDay<10){
   	    	 $("#searchStartTime").val(pastYear +"-"+ pastMonth + "-"+"0"+ pastDay); 
   	       }else if(pastMonth<10&&pastDay>10){
   	    	 $("#searchStartTime").val(pastYear +"-"+"0"+ pastMonth + "-" + pastDay); 
   	       }
   		 
   		   if(month<10&&day<10){
   			 $("#searchEndTime").val(year + "-"+"0"+ month + "-"+"0" + day);
   	       }else if(month>=10&&day>=10){
   	    	 $("#searchEndTime").val(year + "-"+ month + "-" + day);
   	       }else if(month>10&&day<10){
   	    	 $("#searchEndTime").val(year + "-"+ month + "-"+"0" + day);
   	       }else if(month<10&&day>10){
   	    	 $("#searchEndTime").val(year + "-"+"0"+ month + "-" + day);
   	       }
  	});
  	
  	$(".alltime").click(function () {
  		$(this).siblings().removeClass("active");
  		$(this).addClass("active");

  		var today = new Date();
  		var year = today.getFullYear();
  		var year1 = year;
  		var month= today.getMonth()+1;//本月
  		var day = today.getDate();

  		$("#searchStartTime").val(2016 + "-" +"0"+ 1 + "-" +"0"+ 1);
  		 if(month<10&&day<10){
  			 $("#searchEndTime").val(year + "-"+"0"+ month + "-"+"0" + day);
  	       }else if(month>=10&&day>=10){
  	    	 $("#searchEndTime").val(year + "-"+ month + "-" + day);
  	       }else if(month>10&&day<10){
  	    	 $("#searchEndTime").val(year + "-"+ month + "-"+"0" + day);
  	       }else if(month<10&&day>10){
  	    	 $("#searchEndTime").val(year + "-"+"0"+ month + "-" + day);
  	       }
  	});
})
</script>
</body>
</html>
