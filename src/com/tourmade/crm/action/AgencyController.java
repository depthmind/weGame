package com.tourmade.crm.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tourmade.crm.common.action.BaseSimpleFormController;
import com.tourmade.crm.common.framework.bean.QueryResult;
import com.tourmade.crm.common.framework.util.JSONUtilS;
import com.tourmade.crm.common.model.base.value.baseconfig.PageHelper;
import com.tourmade.crm.entity.PlayerRecharge;
import com.tourmade.crm.entity.User;
import com.tourmade.crm.service.ParameterService;
import com.tourmade.crm.service.PlayerRechargeService;

@Controller
@RequestMapping("/agency")
public class AgencyController extends BaseSimpleFormController {

	@Autowired
	private PlayerRechargeService playerRechargeService;
	@Autowired
	private ParameterService parameterService;

	@RequestMapping(value = "/achievement.html", produces = "application/json;charset=utf-8")
	public String achievement(HttpServletRequest request, HttpServletResponse response, Model model) {
		float totalAmount = playerRechargeService.countAmountByAgencyId("1");
		model.addAttribute("totalAmount", totalAmount);
		return "/agency/achievement";
	}

	@RequestMapping(value = "/achievement.do", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String achievementData(HttpServletRequest request, HttpServletResponse response,
			PlayerRecharge playerRecharge, PageHelper page) {
		QueryResult<PlayerRecharge> pageResult = playerRechargeService.findAllPlayerRechargeByAgencyId(playerRecharge,
				page, "1");
		String result = JSONUtilS.object2json(pageResult);
		return result;
	}
	
	@RequestMapping(value = "/agencyAchievement.html", produces = "application/json;charset=utf-8")
	public String agencyAchievement(HttpServletRequest request, HttpServletResponse response, Model model) {
		float totalAmount = playerRechargeService.countAgencyAmountByAgencyId("1");
		model.addAttribute("totalAmount", totalAmount);
		return "/agency/agencyAchievement";
	}
	
	@RequestMapping(value = "/agencyAchievement.do", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String agencyAchievementData(HttpServletRequest request, HttpServletResponse response,
			PlayerRecharge playerRecharge, PageHelper page) {
		QueryResult<PlayerRecharge> pageResult = playerRechargeService.findAllAgencyPlayerRechargeByAgencyId(playerRecharge,
				page, "1");
		String result = JSONUtilS.object2json(pageResult);
		return result;
	}
	
	@RequestMapping(value = "/shareLink.html", produces = "application/json;charset=utf-8")
	public String shareLink(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = (User) request.getSession().getAttribute("loginUser");
		String isCharge = parameterService.getParaValue("是否开启收费模式", "agency.isCharge");
		boolean flag = user.getHasPay();
		if ("1".equals(isCharge) && !flag) {
			return "redirect:/agencyRecharge.html"; //如果开启收费模式且用户未支付，直接跳转到支付页面
		} else {
			model.addAttribute("hasPay", true);
			model.addAttribute("registerLink", user.getRegisterLink());
			model.addAttribute("rechargeLink", user.getRechargeLink());
		}
		return "/agency/shareLink";
	}
}
