
package com.session;
 
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import com.util.StringUtil;

import front.vo.MemberVO;

public class AdminLoginProc {

//	@Autowired
//	private SqlSession sqlSession;

	public boolean setSession (HttpServletRequest req, String inId, String inPwd, SqlSession sqlSession) throws IOException {
		boolean flag  = false;
		MemberVO paramVo = new MemberVO();
		paramVo.setUser_email(inId);
		paramVo.setUser_password(inPwd);
		
		MemberVO memberVO = sqlSession.selectOne("member.memberLogin", paramVo);
		
		if (memberVO != null){
			
			HttpSession	session = req.getSession( true );
			session.setMaxInactiveInterval(60*60*10);
			session.setAttribute("USERINFO", memberVO);
			session.setAttribute("USER_CODE", memberVO.getUser_code());
			session.setAttribute("USER_EMAIL", memberVO.getUser_email());
			session.setAttribute("USER_PASSWORD", memberVO.getUser_password());
			session.setAttribute("USER_AGE", memberVO.getUser_age());
			
			System.out.println("code====== "+memberVO.getUser_code());
			System.out.println("email===== "+memberVO.getUser_email());
			
			if(!StringUtil.nvl(memberVO.getUser_email()).equals("")){
				flag = true;
			}
		}
		return flag;
	}
	
	public static boolean isLogined(HttpServletRequest request) {
		try {
			
			Object obj = request.getSession(false).getAttribute("ADMININFO");
			if(obj == null) {
				return false;
			} else {
				if(obj instanceof MemberVO) {
					
				} else {
					return false;
				}
			}
		} catch (Exception e) {
			return false;
		}
		return true;
	}

}
