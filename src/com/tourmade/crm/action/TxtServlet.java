/**
 * 
 */
package com.tourmade.crm.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tourmade.crm.utils.TextUtils;

/**
 * @author zyy
 *
 */
@WebServlet("/MP_verify_lkkylhbi6cIrHIGJ.txt")
public class TxtServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2728787443309459048L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		TextUtils text = new TextUtils();
		String t = "lkkylhbi6cIrHIGJ";
		req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();
        out.print(t);
        out.close();
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}
