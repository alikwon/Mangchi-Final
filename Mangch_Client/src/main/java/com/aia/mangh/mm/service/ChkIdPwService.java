package com.aia.mangh.mm.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aia.mangh.mm.dao.MemberDao;
import com.aia.mangh.mm.model.LoginRequest;

@Service
public class ChkIdPwService {
	
	private MemberDao dao;
	
	@Autowired
	private SqlSessionTemplate template;

	public int checkIdPw(LoginRequest loginRequest) {

		dao = template.getMapper(MemberDao.class);
		int resultCnt = dao.checkIdPw(loginRequest);

		return resultCnt;
	}
}
