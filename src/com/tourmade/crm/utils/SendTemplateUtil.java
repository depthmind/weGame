/**
 * 
 */
package com.tourmade.crm.utils;

import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;

import com.tourmade.crm.common.framework.util.HttpRequestUtil;

import net.sf.json.JSONObject;

/**
 * @author zyy
 *
 */
public class SendTemplateUtil {
	public String sendTemplateMessage(Map<String, String> msgPara) {
		String message;
		String first = msgPara.get("first");
		String keyword1 = msgPara.get("productName"); //订单编号
		String keyword2 = msgPara.get("orderCode"); //客人姓名
		String keyword3 = msgPara.get("number"); //销售姓名
		String accessToken = msgPara.get("accessToken");
		String openId = msgPara.get("openId");
		String templateId = msgPara.get("templateId");
		String remark = "为避免打扰您,我们将不会再提醒您,请您及时关注"; 
		final String url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=" + accessToken;
		String param = "{\"touser\":\""+ openId 
				+"\",\"template_id\":\"" + templateId 
				+ "\",\"url\":\"\",\"topcolor\":\"#FF0000\",\"data\":{\"first\": {\"value\":\"" + first 
				+ "\",\"color\":\"#173177\"},\"keyword1\":{\"value\":\"" + keyword1 
				+"\",\"color\":\"#173177\"},\"keyword2\":{\"value\":\"" + keyword2 + 
				"\",\"color\":\"#173177\"},\"keyword3\":{\"value\":\"" + keyword3 + 
				//"\",\"color\":\"#173177\"},\"keyword4\":{\"value\":\"" + "" + 
				"\",\"color\":\"#173177\"},\"remark\":{\"value\":\"" + "" + 
				"\",\"color\":\"#173177\"}}}";
		message = HttpRequestUtil.sendPost(url, param);
		return message;
	}
	
	public String sendTravelRemindTemplateMessage(Map<String, String> msgPara) {
		String message;
		String first = msgPara.get("first");
		String keyword1 = msgPara.get("orderCode"); //订单编号
		//String keyword2 = msgPara.get("destination"); //目的地
		//String keyword3 = msgPara.get("contact"); //联系人
		//String keyword4 = msgPara.get("contactPhone"); //联系方式
		String keyword2 = msgPara.get("startTime"); //出行时间
		String keyword3 = msgPara.get("destination"); //出行时间
		String accessToken = msgPara.get("accessToken");
		String openId = msgPara.get("openId");
		String templateId = msgPara.get("templateId");
		String remark = "祝您旅途愉快！ 有任何疑问，可直接回复本服务号咨询或拨打【4008130006】"; 
		final String url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=" + accessToken;
		String param = "{\"touser\":\""+ openId 
				+"\",\"template_id\":\"" + templateId 
				+ "\",\"url\":\"\",\"topcolor\":\"#FF0000\",\"data\":{\"first\": {\"value\":\"" + first 
				+ "\",\"color\":\"#173177\"},\"keyword1\":{\"value\":\"" + keyword1 
				+"\",\"color\":\"#173177\"},\"keyword2\":{\"value\":\"" + keyword2 + 
				"\",\"color\":\"#173177\"},\"keyword3\":{\"value\":\"" + keyword3 + 
				//"\",\"color\":\"#173177\"},\"keyword4\":{\"value\":\"" + keyword4 + 
				"\",\"color\":\"#173177\"},\"remark\":{\"value\":\"" + remark + 
				"\",\"color\":\"#173177\"}}}";
		message = HttpRequestUtil.sendPost(url, param);
		return message;
	}
	
	public String sendFeedbackTemplateMessage(Map<String, String> msgPara) {
		String message;
		String first = msgPara.get("first");
		String keyword1 = msgPara.get("orderCode"); //订单编号
		String keyword2 = msgPara.get("destination"); //目的地
		String keyword3 = msgPara.get("salesName"); //定制师
		String feedbackUrl = msgPara.get("url"); //跳转链接
		String accessToken = msgPara.get("accessToken");
		String openId = msgPara.get("openId");
		String templateId = msgPara.get("templateId");
		String remark = "感谢您的支持"; 
		final String url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=" + accessToken;
		String param = "{\"touser\":\""+ openId 
				+"\",\"template_id\":\"" + templateId 
				+"\",\"url\":\"" + feedbackUrl 
				+ "\",\"url\":\"\",\"topcolor\":\"#FF0000\",\"data\":{\"first\": {\"value\":\"" + first 
				+ "\",\"color\":\"#173177\"},\"keyword1\":{\"value\":\"" + keyword1 
				+"\",\"color\":\"#173177\"},\"keyword2\":{\"value\":\"" + keyword2 + 
				"\",\"color\":\"#173177\"},\"keyword3\":{\"value\":\"" + keyword3 + 
				//"\",\"color\":\"#173177\"},\"keyword4\":{\"value\":\"" + keyword4 + 
				"\",\"color\":\"#173177\"},\"remark\":{\"value\":\"" + remark + 
				"\",\"color\":\"#173177\"}}}";
		message = HttpRequestUtil.sendPost(url, param);
		return message;
	}
	
	/**
	 * 
	 * @date 2018年3月19日 下午1:49:34
	 * @author liuhan
	 * @todo 每天早上8点检查超过24小时没有人跟进的IM群组，之后发送微信模板消息给跟单员
	 */
	public String sendTemplateMsg2Operator(Map<String, String> sendPara) {
		String message;
		String first = sendPara.get("first");
		String keyword1 = sendPara.get("groupNum"); //群组数量
		String keyword2 = sendPara.get("time"); //跟进时间
		String accessToken = sendPara.get("accessToken");
		String openId = sendPara.get("openId");
		String templateId = sendPara.get("templateId");
		String remark = "请及时处理"; 
		final String url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=" + accessToken;
		String param = "{\"touser\":\""+ openId 
				+"\",\"template_id\":\"" + templateId 
				//+"\",\"url\":\"" + feedbackUrl 
				+ "\",\"url\":\"\",\"topcolor\":\"#FF0000\",\"data\":{\"first\": {\"value\":\"" + first 
				+ "\",\"color\":\"#173177\"},\"keyword1\":{\"value\":\"" + keyword1 
				+"\",\"color\":\"#173177\"},\"keyword2\":{\"value\":\"" + keyword2 + 
				"\",\"color\":\"#173177\"},\"remark\":{\"value\":\"" + remark + 
				"\",\"color\":\"#173177\"}}}";
		message = HttpRequestUtil.sendPost(url, param);
		return message;
	}
}
