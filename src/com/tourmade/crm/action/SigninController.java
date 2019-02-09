package com.tourmade.crm.action;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tourmade.crm.common.Constants;
import com.tourmade.crm.common.action.BaseSimpleFormController;
import com.tourmade.crm.common.model.base.value.baseconfig.Json;
import com.tourmade.crm.entity.User;
import com.tourmade.crm.service.UserService;
import com.tourmade.crm.utils.RSAUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/")
public class SigninController extends BaseSimpleFormController {

	@Autowired
	private UserService service;

	/**
	 * 用户注册（进入注册界面）
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/register.html", method = { RequestMethod.POST, RequestMethod.GET })
	public String register(Model model, String from) {
		if (StringUtils.isNotBlank(from)) {
			try {
				KeyFactory keyFactory = KeyFactory.getInstance(Constants.RSA_ALGORITHM);
		        PKCS8EncodedKeySpec pkcs8KeySpec = new PKCS8EncodedKeySpec(Base64.decodeBase64(Constants.PRIVATE_KEY));
		        RSAPrivateKey privateKey = (RSAPrivateKey) keyFactory.generatePrivate(pkcs8KeySpec);
				String agencyId = RSAUtils.privateDecrypt(from, privateKey);
				model.addAttribute("agencyId", agencyId);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "/register";
	}
	
	@RequestMapping(value = "/register.do")
	@ResponseBody
	public Json saveUser(HttpServletRequest request, User user) {
		Json json = new Json();
		int result = service.saveUser(user);
		String baseUrlRegister = (String) request.getAttribute("rootPath") + "register.htm?from=";
		String baseUrlRecharge = (String) request.getAttribute("rootPath") + "register.htm?from=";

		KeyFactory keyFactory;
		try {
			keyFactory = KeyFactory.getInstance(Constants.RSA_ALGORITHM);
			X509EncodedKeySpec x509KeySpec = new X509EncodedKeySpec(Base64.decodeBase64(Constants.PUBLIC_KEY));
			RSAPublicKey publicKey = (RSAPublicKey) keyFactory.generatePublic(x509KeySpec);
			String from = RSAUtils.publicEncrypt(result + "", publicKey);
			String registerLink = baseUrlRegister + from;
			String rechargeLink = baseUrlRecharge + from;
			user.setRegisterLink(registerLink);
			user.setRechargeLink(rechargeLink);
			service.updateUser(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		boolean flag = result > 0 ? true : false;
		json.setSuccess(flag);
		return json;
	}
	
	/**
	 * 用户登录（进入登录界面）
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/signin.html", method = { RequestMethod.POST, RequestMethod.GET })
	public String signin(Model model) {
		return "/signin";
	}
	
	/**
	 * 跳转404页面
	 */
	@RequestMapping(value = "/notfound.html", method = { RequestMethod.POST, RequestMethod.GET })
	public String notFonud(Model model) {
		return "/notfound";
	}

	/**
	 * 用户登出
	 * 
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/signout.html", method = { RequestMethod.POST, RequestMethod.GET })
	public String loginout(HttpSession session, HttpServletRequest request) {
		if (session != null) {
			session.invalidate();
		}

		return "redirect:/signin.html";
	}

	/**
	 * 执行登录操作
	 * 
	 * @param request
	 * @param session
	 * @param model
	 * @param user
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/signin.do")
	@ResponseBody
	public Json dosignin(HttpServletRequest request, HttpSession session, Model model, User user) {
		Json json = new Json();
		if (user.getLoginName() == null || user.getPwd() == null || user.getLoginName().trim().length() < 1
				|| user.getPwd().trim().length() < 1) {
			json.setMsg("用户名或密码为空");
		} else {
			User realUser = service.signin(user);
			if (null != realUser) {
				// 将登录者的权限ID和可以访问的URl放在session中
				List<String> menuNameList = new ArrayList<String>();
				List<String> urlList = new ArrayList<String>();
				String roleID = service.permissionCheckRole(realUser.getLoginName());
				// 通过roleid获取menuid,再通过menuid和roleId获取menuname
				// String menuId = service.checkButtonId("修改跟单员权限");
				List<String> menuIdList = service.getMenuId(roleID);
				for (String menuId : menuIdList) {
					String menuName = service.getMenuNameByMenuId(menuId);
					menuNameList.add(menuName);
					if (!"".equals(menuName) || menuName != null) {
						String url = service.getUrlByMenuName(menuName);
						urlList.add(url);
					}
				}
				JSONArray menuNameListJson = JSONArray.fromObject(menuNameList);
				session.setAttribute("menuNameList", menuNameListJson);

				JSONArray menuIdListJson = JSONArray.fromObject(menuIdList);
				// 将用户id存入session中
				session.setAttribute("loginUserId", user.getUserId());
				session.setAttribute("menuIdList", menuIdListJson);
				session.setAttribute("url", urlList);
				session.setAttribute("roleID", roleID);
				// session.setAttribute("url", url);
				json.setSuccess(true);
				json.setMsg("登录成功");
	    		//设置过期时间  单位秒
				request.getSession().setMaxInactiveInterval(86400);
				request.getSession().setAttribute(Constants.LOGIN_KEY, realUser);
			} else {
				json.setMsg("用户名或密码错误");
			}
		}
		return json;
	}
	
	@RequestMapping(value="/wechatsignin.do", produces="application/json;charset=utf-8")
	public String wechatLoginCallBack(HttpServletRequest request, HttpServletResponse response, HttpSession session, String code, String state) {
		logger.info("wechat login callback");
		
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
				logger.info("openId=" + openId);
				logger.info("accessToken=" + accessToken);
				//user = userService.getUserByOpenId(openId);
				user = service.getUserByUnionId(unionId);
				if (user != null) {
					String loginName = user.getLoginName();
					String password = user.getPwd();
					
					List<String> menuNameList = new ArrayList<String>();
					List<String> urlList = new ArrayList<String>();
					String roleID = service.permissionCheckRole(user.getLoginName());
					logger.info("roleID=" + roleID);
					// 通过roleid获取menuid,再通过menuid和roleId获取menuname
					// String menuId = service.checkButtonId("修改跟单员权限");
					List<String> menuIdList = service.getMenuId(roleID);
					for (String menuId : menuIdList) {
						String menuName = service.getMenuNameByMenuId(menuId);
						menuNameList.add(menuName);
						if (!"".equals(menuName) || menuName != null) {
							String url = service.getUrlByMenuName(menuName);
							urlList.add(url);
						}
					}
					JSONArray menuNameListJson = JSONArray.fromObject(menuNameList);
					session.setAttribute("menuNameList", menuNameListJson);

					JSONArray menuIdListJson = JSONArray.fromObject(menuIdList);
					session.setAttribute("menuIdList", menuIdListJson);
					session.setAttribute("url", urlList);
					session.setAttribute("roleID", roleID);
					// session.setAttribute("url", url);
					//json.setSuccess(true);
					//json.setMsg("登录成功");
					request.getSession().setAttribute(Constants.LOGIN_KEY, user);
					return "redirect:/main.html";
				} else {
					return "redirect:/nouser.html";
				}
			}
			
		}
		return "redirect:/signin.html";
	}
}
