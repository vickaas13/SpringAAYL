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

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String root() {
		return "index";
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public ModelAndView register(@RequestParam("email") String email, @RequestParam("passWord") String passWord,
			@RequestParam("firstName") String firstName, @RequestParam("lastName") String lastName,
			@RequestParam("mobileNumber") String mobileNumber, Model model) {
		return new ModelAndView("index", "message",
				daobean.register(email, passWord, firstName, lastName, mobileNumber));
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView loginCheck(@RequestParam("email") String email, @RequestParam("passWord") String passWord,
			Model model) {
		String name = daobean.validateLogin(email, passWord);
		if (name != null) {
			model.addAttribute("user", email);
			System.out.println("email1" + email);
			model.addAttribute("msg", name);
			return new ModelAndView("success", "message", "");

		} else {
			msg = "Login unsuccessful";
			System.out.println("else statement");
			return new ModelAndView("index", "message", msg);
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

	@RequestMapping(value = "/forgot-password", method = RequestMethod.POST)
	public ModelAndView resetPassword(@RequestParam("email") String email, @RequestParam("answer") String answer,
			@RequestParam("npass") String npass, Model model) {
		String str = daobean.resetPass(email, answer, npass);
		if (str.equals("Unsuccessful"))
			return new ModelAndView("index", "message", "Unsuccessful");
		else {
			model.addAttribute("msg", str);
			model.addAttribute("user", email);
			return new ModelAndView("success", "msg", str);
		}
	}

	@RequestMapping("/selectAddress")
	public @ResponseBody String selectAddressOfComapny(@RequestParam("nameforselect") String name) {
		System.out.println("inside selectaddress");
		System.out.println("name" + name);
		String str = daobean.selectAddress(name);
		return str;

	}

	@RequestMapping(value = "/getCurrentInvoiceId", method = RequestMethod.POST)
	public @ResponseBody int getInvoiceId(@ModelAttribute("user") String user) {
		int i = daobean.getInvoiceId();
		i++;
		System.out.println("i value:" + i);
		return i;
	}

	@RequestMapping("/selectPrice")
	public @ResponseBody Double selectPriceOfItem(@RequestParam("nameforselect1") String item) {
		System.out.println("inside selectprice");
		System.out.println("item" + item);
		double d = Double.parseDouble(daobean.selectPrice(item));
		return d;

	}

	@RequestMapping("/invoice")
	public ModelAndView getInvoice(@ModelAttribute("user") String user) {
		HashMap<String, Object> model = new HashMap<String, Object>();
		List<Map> l = daobean.getCompanyAddress(user);
		List<String> l1 = daobean.getCompanyList(user);
		List<String> l2 = daobean.getItemsList();
		System.out.println("l2:data" + l2);
		ModelAndView mav = new ModelAndView();
		model.put("flist1", l);
		model.put("flist2", l1);
		model.put("flist3", l2);
		// mav.addObject("list", l);
		return new ModelAndView("invoice", "model", model);
	}

	@RequestMapping(value = "/saveInvoice", method = RequestMethod.GET)
	public @ResponseBody String saveInvoice1(@ModelAttribute("user") String user, @RequestParam("id") int id,
			@RequestParam("duedate") String date, @RequestParam("caddress") String caddress,
			@RequestParam("baddress") String baddress, @RequestParam("totalprice") int totalprice) {
		System.out.println("save invoice" + id + " " + date + " " + caddress + " " + baddress + " " + totalprice);
		String str = daobean.saveInvoiceDetails(user, id, date, caddress, baddress, totalprice);
		if (str.equals("success")) {
			return "successful";
		}
		return "failure";
	}

	@RequestMapping(value = "/logout", method = RequestMethod.POST)
	public ModelAndView Logout(SessionStatus status) {
		status.setComplete();
		return new ModelAndView("index", "message", "Logged out");
	}

	@RequestMapping("/back")
	public String backToHome() {
		return "success";
	}

}
