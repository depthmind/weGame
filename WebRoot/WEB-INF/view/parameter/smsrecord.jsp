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
					<i class="glyphicon glyphicon-cog"></i> 系统管理 <span>短信日志列表</span>
				</h2>
			</div>

			<div class="contentpanel">
				<div class="panel panel-default">
					<div class="panel-heading">
						<div class="panel-btns">
							<a href="" class="minimize">&minus;</a>
						</div>
						<!-- panel-btns -->
						<h3 class="panel-title">短信日志管理列表</h3>
						<div class="row" style="margin-top: 20px">
							<div class="form-group col-sm-10">
							 <label class="col-sm-1 control-label" style="float:left;width:85px;margin-top:10px;">发送时间：</label>
								<div class="col-sm-2">
									<div class="input-group input-datepicker" style="padding: 0;">
				                        <input readonly="readonly" id="searchStartTime" type="text" name="searchStartTime" class="form-control datepicker" placeholder="请点击输入查询开始日期" value="${searchSmsRecord.searchStartTime}" autocomplete="on">
				                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				                    </div>
				                </div>
			                    <div class="col-sm-2">
				                    <div class="input-group input-datepicker" style="padding: 0;">
				                        <input readonly="readonly" id="searchEndTime" type="text" name="searchEndTime" class="form-control datepicker" placeholder="请点击输入查询截止日期" value="${searchSmsRecord.searchEndTime}" autocomplete="on">
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
								<input type="hidden" id="searchFlag" name="flag" value="${flag}" />
							</div>	
						</div>
					

					</div>
					<div class="panel-body">
						<br />
						<div class="table-responsive">

							<table id="dataTable" class="table">
								<thead>
									<tr>
										<th>短信ID</th>
										<th>短信MD5</th>
										<th>收件人名</th>
										<th>收件号码</th>
										<th>短信类型</th>
										<th>参数</th> 
										<th>请求ID</th> 
										<th>备注</th> 
 										<th>发送时间</th> 
 										<th>创建时间</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
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

    <script src="${rootPath}assets/js/jquery-ui-1.10.3.min.js"></script>
	<script src="${rootPath}assets/js/jquery.datatables.min.js"></script>
	<script src="${rootPath}assets/js/select2.min.js"></script>
	<script src="${rootPath}assets/js/jquery.validate.min.js"></script>
	<script src="${rootPath}assets/js/jquery-ui-timepicker-addon.js"></script>


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
			
			 var table = jQuery('#dataTable').DataTable({
				searching:false,
			 	pageLength: 10,
			 	processing: true,
			 	language: datatable_local_language, // my.js
			 	serverSide: true,
			 	stateSave:true,
			 	ajax: {
			 		url: '${rootPath}parameter/smsrecord.do',
			 		data:function ( data ) {
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
					            		 if(full.messageId.length > 24){
												return "<div class='width150' data-toggle='tooltip' data-placement='bottom' title='" + full.messageId + "'>" + full.messageId.substring(0,28) + "...</div>"
											}else{
												return "<div class='width150'>" + full.messageId + "</div>"
											}	
					            		 return full.messageId;
					            		 }
					             },
					             {
					            	 targets: 1,
					            	 orderable: false,
					            	 render: function(data, type, full, meta ) {
					            		 if(full.messageMD5.length > 24){
												return "<div class='width170' data-toggle='tooltip' data-placement='bottom' title='" + full.messageMD5 + "'>" + full.messageMD5.substring(0,28) + "...</div>"
											}else{
												return "<div class='width170'>" + full.messageMD5 + "</div>"
											}	
					            		 return full.messageMD5;
					            		 }
					             },
					             {
					            	 targets: 2,
					            	 orderable: false,
					            	 render: function(data, type, full, meta ) {
					            		 return full.smsReceiverName;
					            		 }
					             },
					             {
					            	 targets: 3,
					            	 orderable: false,
					            	 render: function(data, type, full, meta ) {
					            		 return full.smsReceiver;
					            		 }
					             },
					             {
					            	 targets: 4,
					            	 orderable: false,
					            	 render: function(data, type, full, meta ) {
					            		 return full.smsType;
					            		 }
					             },
					             {
					            	 targets: 5,
					            	 orderable: false,
					            	 render: function(data, type, full, meta ) {
					            		 return full.parameter;
					            		 }
					             },
					             {
					            	 targets: 6,
					            	 orderable: false,
					            	 render: function(data, type, full, meta ) {
					            		 return full.requestId;
					            		 }
					             },
					             {
					            	 targets: 7,
					            	 orderable: false,
					            	 render: function(data, type, full, meta ) {
					            		 return full.comment;
					            		 }
					             },
					             {
					            	 targets: 8,
					            	 orderable: false,
					            	 render: function( data, type, full, meta ) {
					            		 if(full.sendTime!=null){
						            		 var m = full.sendTime.time;
							                	if(full.sendTime){
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
					            	 targets: 9,
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
					            { data: "messageId" },
					            { data: "messageMD5" },
					            { data: "smsReceiverName" },
					            { data: "smsReceiver" },
					            { data: "smsType" },
					            { data: "parameter" },
					            { data: "requestId" },
					            { data: "comment" },
					            { data: "sendTime"},
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
