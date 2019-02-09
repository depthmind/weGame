/**
 * 
 */
package com.tourmade.crm.action;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tourmade.crm.common.Constants;
import com.tourmade.crm.common.action.BaseSimpleFormController;
import com.tourmade.crm.entity.User;
import com.tourmade.crm.service.UserService;

import net.sf.json.JSONObject;

/**
 * @author zyy
 *
 */
@Controller
@RequestMapping("/individual")
public class IndividualCenterController extends BaseSimpleFormController {

	@Autowired
	private UserService userService;
	
	@RequestMapping(value = "/individualCenter.html", produces = "application/json;charset=utf-8")
	public String individualCenter(HttpServletRequest request, Model model) {
		User user;
		
		user = (User) request.getSession().getAttribute(Constants.LOGIN_KEY);
		
		model.addAttribute("user",user);
		return "/individual/edit";
	}
	
	@RequestMapping(value = "/wechatBind", produces = "application/json;charset=utf-8")
	public String wechatBind(HttpServletRequest request, String code, String state) {
		String accessTokenUrl;
		String appId;
		String secret;
		String responseMsg = null;
		String accessToken;
		String openId;
		String unionId;
		PostMethod postMethod;
		HttpClient httpClient;
		User user;
		Integer userId;
		Map<String, Object> param = new HashMap<String, Object>();
		
		user = (User) request.getSession().getAttribute(Constants.LOGIN_KEY);
		userId = user.getUserId();
		appId = Constants.WX_OPEN_PLATFORM_APPID;
		secret = Constants.WX_OPEN_PLATFORM_SECRET;
		accessTokenUrl = "https://api.weixin.qq.com/sns/oauth2/access_token"
				+ "?appid=" + appId
				+ "&secret=" + secret
				+ "&code=" + code
				+ "&grant_type=authorization_code";
		
		httpClient = new HttpClient();
		postMethod = new PostMethod(accessTokenUrl);
		postMethod.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET,"utf-8");
		
		try {
			int statusCode = httpClient.executeMethod(postMethod);
			if (statusCode == HttpStatus.SC_OK) {
				InputStream inputStream = postMethod.getResponseBodyAsStream();
				responseMsg = IOUtils.toString(inputStream, "utf-8");
			}
		} catch (IOException e) {
			logger.error("调用微信接口失败------接口地址为：" + accessTokenUrl);
		} finally {
			postMethod.releaseConnection();
		}
		
		if (responseMsg != null) {
			JSONObject jsonObj = JSONObject.fromObject(responseMsg);
			logger.info("jsonObj=" + jsonObj.toString());
			if (!jsonObj.has("errcode")) {
				accessToken = jsonObj.getString("access_token");
				openId = jsonObj.getString("openid");
				unionId = jsonObj.getString("unionid");
				param.put("openId", openId);
				param.put("unionId", unionId);
				param.put("userId", userId);
				userService.wechatBind(param);
				logger.info("openId=" + openId);
				logger.info("accessToken=" + accessToken);
			}
			
		}
		
		return "redirect:/individual/individualCenter.html";
	}
	
}
