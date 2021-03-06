package com.tourmade.crm.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tourmade.crm.common.action.BaseSimpleFormController;
import com.tourmade.crm.common.framework.bean.QueryResult;
import com.tourmade.crm.common.framework.util.JSONUtilS;
import com.tourmade.crm.common.model.base.value.baseconfig.Json;
import com.tourmade.crm.common.model.base.value.baseconfig.PageHelper;
import com.tourmade.crm.entity.Parameter;
import com.tourmade.crm.service.ParameterService;

@Controller
@RequestMapping("/parameter")
public class ParameterController extends BaseSimpleFormController {

	@Autowired
	private ParameterService service;

	@RequestMapping(value = "/list.html", method = { RequestMethod.POST, RequestMethod.GET })
	public String list(Model model) {
		return "/parameter/list";
	}
	
	@RequestMapping(value = "/list.do",produces="application/json;charset=utf-8")
	@ResponseBody
	public String queryData(HttpServletRequest request, HttpSession session, Model model, Parameter parameter, PageHelper page) {

		QueryResult<Parameter> pageResult = service.queryParameter(parameter, page, request);
		String result = JSONUtilS.object2json(pageResult);
		return result;
	}
	
	@RequestMapping(value = "/add.html", method = { RequestMethod.POST, RequestMethod.GET })
	public String add(Model model) {
		return "/parameter/add";
	}

	@RequestMapping(value = "/add.do")
	@ResponseBody
	public Json doAdd(HttpServletRequest request, HttpSession session, Model model, Parameter parameter) {
		
		Json json = new Json();
		
		try {
			parameter.setValue(parameter.getValue().trim());
			service.saveParameter(parameter);
			json.setSuccess(true);
		} catch (Exception e) {
			json.setSuccess(false);
			logger.error("ParameterController.doAdd() --> " + parameter.toString() + "\n" + e.getMessage());
		}
		
		return json;
	}

	@RequestMapping(value = "/edit.html", method = { RequestMethod.POST, RequestMethod.GET })
	public String edit(Model model, String id) {
		
		if (null != id && !"".equals(id)) {
			int parameterId = Integer.parseInt(id);
			Parameter parameter = service.getParameterById(parameterId);
			model.addAttribute("parameter",parameter);
		}
		
		
		return "/parameter/edit";
	}

	@RequestMapping(value = "/edit.do")
	@ResponseBody
	public Json doEdit(HttpServletRequest request, HttpSession session, Model model, Parameter parameter) {

		Json json = new Json();
		
		try {
			service.updateParameter(parameter);
			json.setSuccess(true);
		} catch (Exception e) {
			json.setSuccess(false);
			logger.error("ParameterController.doEdit() --> " + parameter.toString() + "\n" + e.getMessage());
		}
		
		return json;
	}
	
	@RequestMapping(value = "/del.do")
	@ResponseBody
	public Json doDel(HttpServletRequest request, HttpSession session, Model model, String id) {

		Json json = new Json();
		try {
			if (null != id && !"".equals(id)) {
				int parameterId= Integer.parseInt(id);
				service.deleteParameterById(parameterId);
				json.setSuccess(true);
			} else {
				json.setSuccess(false);
			}
		} catch (Exception e) {
			json.setSuccess(false);
			logger.error("ParameterController.doDel() --> " + id + "\n" + e.getMessage());
		}
		
		return json;
	}
}
