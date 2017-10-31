package com.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.dao.CompanyDao;

@Controller
@SessionAttributes({ "user", "msg" })
public class ControllerServlet {
	@Autowired
	CompanyDao daobean;
	String msg = "";

	@RequestMapping("/start")
	public ModelAndView login() {
		msg = "Lets start";
		return new ModelAndView("loginregister", "message", msg);

	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public ModelAndView register(@RequestParam("email") String email, @RequestParam("passWord") String passWord,
			@RequestParam("firstName") String firstName, @RequestParam("lastName") String lastName,
			@RequestParam("mobileNumber") String mobileNumber, Model model) {
		return new ModelAndView("loginregister", "message",
				daobean.register(email, passWord, firstName, lastName, mobileNumber));
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView loginCheck(@RequestParam("email") String email, @RequestParam("passWord") String passWord,
			Model model) {
		if (daobean.validateLogin(email, passWord)) {
			System.out.println("email" + email);
			msg = "Welcome " + email;
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("user", email);
			model.addAttribute("user", email);
			System.out.println("email1" + email);
			model.addAttribute("msg", msg);
			return new ModelAndView("success", "message", "");

		} else {
			msg = "Login unsuccessful";
			System.out.println("else statement");
			return new ModelAndView("loginregister", "message", msg);
		}
	}

	@RequestMapping("/change-page")
	public ModelAndView passWord(@ModelAttribute("user") String user) {
		return new ModelAndView("passwordreset", "user", user);
	}

	@RequestMapping(value = "/change-password", method = RequestMethod.POST)
	public ModelAndView changePassWord(@ModelAttribute("user") String user, @RequestParam("opass") String opass,
			@RequestParam("npass") String npass) {
		String b = daobean.changePassWord(user, opass, npass);
		return new ModelAndView("success", "message", b);
	}

	@RequestMapping("/set-answer-page")
	public ModelAndView setAnswerPass(@ModelAttribute("user") String user) {
		return new ModelAndView("secquestion", "user", user);
	}

	@RequestMapping(value = "/set-answer", method = RequestMethod.POST)
	public ModelAndView setAnswer(@ModelAttribute("user") String user, @RequestParam("answer") String answer) {
		return new ModelAndView("success", "message", daobean.setAnswerForSec(user, answer));
	}

	@RequestMapping("/details-page")
	public ModelAndView setDetails(@ModelAttribute("user") String user) {
		return new ModelAndView("details", "user", user);
	}

	@RequestMapping(value = "/details", method = RequestMethod.POST)
	public ModelAndView getDetails(@ModelAttribute("user") String user, @RequestParam("cname") String cname,
			@RequestParam("caddress") String caddress, @RequestParam("baddress") String baddress) {
		return new ModelAndView("success", "message", daobean.setDetails(user, cname, caddress, baddress));
	}
	
	@RequestMapping("/forgot-page")
	public ModelAndView forgotPasswordPage() {
		return new ModelAndView("forgotpassword");
	}
	
	@RequestMapping("/selectAddress")
	public @ResponseBody  String selectAddressOfComapny(@RequestParam("nameforselect") String name){
		System.out.println("inside selectaddress");
		System.out.println("name"+name);
		String str = daobean.selectAddress(name);
		return str;
		
	}
	
	@RequestMapping(value="/forgot-password", method=RequestMethod.POST)
	public ModelAndView resetPassword(@RequestParam("email") String email,@RequestParam("answer")String answer, @RequestParam("npass")String npass,Model model){
		model.addAttribute("msg","Welcome "+email);
		return new ModelAndView("success", "message", daobean.resetPass(email,answer,npass));
	}

	@RequestMapping("/invoice")
	public ModelAndView getInvoice(@ModelAttribute("user") String user) {
		HashMap<String,Object> model=new HashMap<String,Object>();
		List<Map> l = daobean.getCompanyAddress(user);
		List<String> l1 = daobean.getCompanyList();
		ModelAndView mav = new ModelAndView();
		model.put("flist1", l);
		model.put("flist2", l1);
		model.put("message", "this is invoice page");
		//mav.addObject("list", l);
		return new ModelAndView("invoice","model",model);
	}

	@RequestMapping(value = "/logout", method = RequestMethod.POST)
	public ModelAndView Logout(SessionStatus status) {
		status.setComplete();
		return new ModelAndView("loginregister", "message", "Logged out");
	}

	@RequestMapping("/back")
	public String backToHome() {
		return "success";
	}

}