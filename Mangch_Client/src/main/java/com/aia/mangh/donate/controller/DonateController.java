package com.aia.mangh.donate.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DonateController {
	
	@RequestMapping("/donate/donateBoard")
	public String donateBoard() {
		return "/donateBoard/donateBoard";
	}

}
