package com.tourmade.crm.common;

public class Constants {
	
	public static final String LOGIN_KEY = "loginUser";
	
	public static final String ACCESS_TOKEN = "access_token";
	
	public static final String WEIXIN_ORDER_TIMEOUT_TEMPLATE_ID = "odPp7nu6Vv4NXE3kViculSZUKpPw349AEgHpZeEiig4"; //订单超时提醒
	
	//public static final String WEIXIN_NEW_ORDER_TEMPLATE_ID = "JnyDHCuvP_9-xNdARiey_fuh9U_mCU6PQvF3RueY2Jc"; //订单提交提醒
	public static final String WEIXIN_NEW_ORDER_TEMPLATE_ID = "l9b8pLIYoCeHCLpY4pPGOTCl1ELGebetJRPMjYCwkn4"; //订单提交提醒
	
	public static final String WEIXIN_BILL_TEMPLATE_ID = "N6_o4p_SdKvDEFJTJHXFUJx28XtF6cIUvGFPD-967pg"; //付款提醒
	
	public static final String WEIXIN_TRAVEL_REMIND_TEMPLATE_ID = "KIaMLGvkNcXmo7VESX0zaPU0qkgpoXjZkRYiAtVps98";
	
	public static final String WEIXIN_FEEDBACK_TEMPLATE_ID = "sDCPEg3Rlqr969w56cOtru0HMOL09xTo66XkMRTjaoI";
	
	public static final String WEIXIN_GROUP_FOLLOW_TEMPLATE_ID = "OPENTM405776226"; //跟进提醒
	
	public static final String PAYMENT_ITEM_TUANKUAN = "团款"; 
	
	public static final String PAYMENT_ITEM_TICKET = "机票"; 
	
	public static final String PAYMENT_ITEM_PASSPORT = "签证"; 
	
	public static final String ORDER_SOURCE_AGENT = "地接社"; 
	
	public static final String WX_OPEN_PLATFORM_APPID = "wx26a4560e67033101"; //应用唯一标识，在微信开放平台提交应用审核通过后获得
	
	public static final String WX_OPEN_PLATFORM_SECRET = "81ff1fef94f38de5d0364b9430179831"; //应用密钥AppSecret，在微信开放平台提交应用审核通过后获得
	
	public final static String TENCENT_SDKAPPID = "1400032415"; //腾讯sdkappid
	
	public final static String TENCENT_ACCOUNT_TYPE = "13151"; //腾讯ACCOUNTType
	
	public final static String TENCENT_ADMIN = "admin"; //腾讯管理员账户
	
	public final static String GROUP_FACE_URL = "http://cdn-files.tourmade.com/logo-tourmade.jpg"; //腾讯管理员账户
	
	public final static String SMS_PRODUCT = "Dysmsapi";

	public final static String SMS_DOMAIN = "dysmsapi.aliyuncs.com";

	public static final String DYVMS_PRODUCT = "Dyplsapi";

	public static final String DYVMS_DOMAIN = "dyplsapi.aliyuncs.com";
	
	public static final String STATISTICS_SOURCE = "source"; //来源统计
	
	public static final String STATISTICS_PROMOTE = "promote"; //来源统计
	
	public static final String STATISTICS_COST = "cost"; //费用统计
	
	public static final String STATISTICS_DESTINATION = "destination"; //目的地页面统计
	
	public static final String STATISTICS_ROUTE = "route"; //线路页面统计
	
	public static final String STATISTICS_AGENT = "agent"; //销售页面统计
	
	public static final Integer MEMBER_POINT_INCREASE = 1; //增加积分
	
	public static final Integer MEMBER_POINT_DECREASE = 2; //扣除积分
	
	public static final String MODIFY_MEMBER_POINT_REWARD = "1"; //增加积分--奖励
	
	public static final String MODIFY_MEMBER_POINT_CONSUME = "2"; //增加积分--消费
	
	public static final String MODIFY_MEMBER_POINT_WRITE_OFF = "3"; //增加积分--核销
	
	public static final String MODIFY_MEMBER_POINT_REFUND = "4"; //增加积分--退款
	
	public static final String CASE_STATUS_PENGDING_ZERO = "0"; //待处理
	
	public static final String CASE_STATUS_COMMUNICATION_ONE = "1"; //客服沟通中
	
	public static final String CASE_STATUS_DESIGN_TWO = "2"; //地接设计中
	
	public static final String CASE_STATUS_DEAL_THREE = "3"; //成行
	
	public static final String CASE_STATUS_ORDER_NOT_DEAL_FOUR = "4"; //订单未成行
	
	public static final String CASE_STATUS_INVAILD_FIVE = "5"; //无效
	
	public static final String CASE_STATUS_CASE_NOT_DEAL_SIX = "6"; //询单未成行
	// 阿里云云呼中心配置
	public static final String ALIYUN_CLIENT_ID = "4950059436650104798"; 
	
	public static final String ALIYUN_CLIENT_SECRET = "V9ibOeFOpNow3mjRWaBjz8oar54FtYpixrQpLX9qLcZp5vKBoM9yUXyrDV0Pc8qO"; 
	
	public static final String CALL_BACK_URL = "http://test.tourmade.com/TmCRM/aliyun/auth/callback"; 
	
	public static final String ALIYUN_TOKEN_ENDPOINT ="http://oauth.aliyun.com/v1/token";
	
	public static final String RSA_ALGORITHM = "RSA";
	
	//公钥
	public static final String PUBLIC_KEY ="MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBANvlYHFXBXRA8JxTPQV_M22_9Mzb5Vc0gZdqqG6ISs_Ul0--R77BH69eU0oJbxOzwGZUZBIcLbOJS9Z_JTp_WcsCAwEAAQ";
	
	//私钥
	public static final String PRIVATE_KEY ="MIIBVgIBADANBgkqhkiG9w0BAQEFAASCAUAwggE8AgEAAkEA2-VgcVcFdEDwnFM9BX8zbb_0zNvlVzSBl2qobohKz9SXT75HvsEfr15TSglvE7PAZlRkEhwts4lL1n8lOn9ZywIDAQABAkEAu4p3pHKJbkrsawb65jNEU3gBeq6YfLWFSPRoTkzjMTgUSgbyhiprnpI_0YNucTBHyqrrn-SWxktCTy6lHWOTsQIhAPEIZbJ4GkQ9pT2j38ShFoLKv3VnLTdzU6ONUzBzLZa3AiEA6Yz55pqxN-cX2qrrmw5FJtceqeX8_gYWhzvbiZX4YY0CID1Hm0NykYsD-TzgqwV8xxJdpaudnbtZUMxmI95PiimlAiEAguDjsh0CLuer8HhT6-KFUgy_PEqMCfZzbXlXv7RxKokCIQCZPIMg79Pj2Ip0uphdMPfkFLSBI_1YjzHzMrLqOPwh4w";
}
