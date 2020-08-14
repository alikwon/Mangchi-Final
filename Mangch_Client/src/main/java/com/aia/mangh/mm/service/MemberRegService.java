package com.aia.mangh.mm.service;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.aia.mangh.mm.dao.MemberDao;
import com.aia.mangh.mm.model.Member;
import com.aia.mangh.mm.model.RegRequest;

@Service
public class MemberRegService {

	private MemberDao dao;
	
	@Autowired
	SqlSessionTemplate template;
	
	public int regMember(RegRequest regRequest, HttpServletRequest request) {
		
		Member member = regRequest.toMember();
		
		dao = template.getMapper(MemberDao.class);
		
		int result = 0;

		try {

			MultipartFile file = regRequest.getmImg();

			System.out.println(regRequest);

			if (file != null && !file.isEmpty() && file.getSize() > 0) {
				String uri = "/resources/img/upload";

				String realPath = request.getSession().getServletContext().getRealPath(uri);

				String newFileName = System.nanoTime() + "_" + file.getOriginalFilename();

				File saveFile = new File(realPath, newFileName);
				file.transferTo(saveFile);
				
				String mImg = uri + "/"+ newFileName;
				
				System.out.println("저장 완료 : " + newFileName);

				member.setmImg(mImg);

			} else {
				member.setmImg("defalult.png");
			}

			result = dao.insertMember(member);

		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} 
				
		return result ;
	}
}
