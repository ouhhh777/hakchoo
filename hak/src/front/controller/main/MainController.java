package front.controller.main;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.session.AdminLoginProc;
import com.util.StringUtil;

import front.vo.AddressVO;
import front.vo.ContactVO;
import front.vo.HakVO;
import front.vo.MemberVO;
import net.sf.json.JSONObject;


@Controller
public class MainController {
	@Autowired
	private SqlSession sqlSession;
	AdminLoginProc loginProc = new AdminLoginProc();
//	private GoogleConnectionFactory googleConnectionFactory;
//	
//	private OAuth2Parameters googleOAuth2Parameters;
	
	// go to Main
	@RequestMapping("/Index")
	public ModelAndView Index(HttpServletRequest request, HttpServletResponse response) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		List<AddressVO> addressVo = new ArrayList<AddressVO>();
		addressVo = sqlSession.selectList("address.find_si_name_list");					//시 정보 가져오기
		resultMap.put("addressVo", addressVo);
		
		ModelAndView mav = new ModelAndView("/index", "resultMap", resultMap);
		return mav;
	}
	
	//구 정보 가져오기
	@RequestMapping(value = "/Find_gu_info", method = RequestMethod.POST)
	public ModelAndView Find_gu_info(HttpServletRequest request, HttpServletResponse response , RedirectAttributes redirectAttr) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String dataPack = request.getParameter("paramPack");
		JSONObject dataObj = JSONObject.fromObject(dataPack);
		HashMap jasonMap = (HashMap)JSONObject.toBean(dataObj, HashMap.class);
		
		String si_name = jasonMap.get("address_name").toString();
		int si_code = sqlSession.selectOne("address.find_si_code_by_si_name", si_name);
		
		List<AddressVO> addressVo = new ArrayList<AddressVO>();
		addressVo = sqlSession.selectList("address.find_gu_name_list", si_code);					//시 정보 가져오기
		resultMap.put("addressVo", addressVo);
	
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
    }
	
	//동 정보 가져오기
	@RequestMapping(value = "/Find_dong_info", method = RequestMethod.POST)
	public ModelAndView Find_dong_info(HttpServletRequest request, HttpServletResponse response , RedirectAttributes redirectAttr) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String dataPack = request.getParameter("paramPack");
		JSONObject dataObj = JSONObject.fromObject(dataPack);
		HashMap jasonMap = (HashMap)JSONObject.toBean(dataObj, HashMap.class);
		
		String gu_name = jasonMap.get("address_name").toString();
		int gu_code = sqlSession.selectOne("address.find_gu_code_by_gu_name", gu_name);
		
		List<AddressVO> addressVo = new ArrayList<AddressVO>();
		addressVo = sqlSession.selectList("address.find_dong_name_list", gu_code);					//시 정보 가져오기
		
		resultMap.put("addressVo", addressVo);
	
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
    }
	
	// email check
	@RequestMapping("/CheckAllEmail")
	public ModelAndView CheckAllEmail(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttr, MemberVO paramVO) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String dataPack = request.getParameter("paramPack");
		JSONObject dataObj = JSONObject.fromObject(dataPack);
		HashMap jasonMap = (HashMap)JSONObject.toBean(dataObj, HashMap.class);
		
		paramVO.setUser_email(jasonMap.get("user_email").toString());
		List<MemberVO> memberVo = sqlSession.selectList("member.selAllMember", paramVO);
		
		resultMap.put("memberVo", memberVo);
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}
	
	
	// sign up process
		@RequestMapping("/SignMember")
		public ModelAndView SignMember(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttr, MemberVO paramVO) throws IOException {
			response.setCharacterEncoding("utf-8");
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			String dataPack = request.getParameter("paramPack");
			JSONObject dataObj = JSONObject.fromObject(dataPack);
			HashMap jasonMap = (HashMap)JSONObject.toBean(dataObj, HashMap.class);
			String user_email = jasonMap.get("user_email").toString();
			paramVO.setUser_email(jasonMap.get("user_email").toString());
			paramVO.setUser_password(StringUtil.encrypt(jasonMap.get("user_password").toString()));
			paramVO.setUser_age(jasonMap.get("user_age").toString());
			
			int insertResult = sqlSession.insert("member.insMember", paramVO);
			
			
			resultMap.put("insertResult",insertResult);
			ModelAndView mav = new ModelAndView("jsonView", resultMap);
			return mav;
		}
		
		// Login
		@RequestMapping("/CheckLogin")
		public ModelAndView CheckLogin(HttpServletRequest request, HttpServletResponse response, MemberVO paramVO) throws IOException {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			String dataPack = request.getParameter("paramPack");
			JSONObject dataObj = JSONObject.fromObject(dataPack);
			HashMap jasonMap = (HashMap)JSONObject.toBean(dataObj, HashMap.class);
			
			paramVO.setUser_email(jasonMap.get("user_email").toString());
			paramVO.setUser_password(StringUtil.encrypt(jasonMap.get("user_password").toString()));
			List<MemberVO> memberIdVO = sqlSession.selectList("member.memberLogin", paramVO);
			
			if(memberIdVO.size() > 0){
				loginProc.setSession(request, memberIdVO.get(0).getUser_email(), memberIdVO.get(0).getUser_password(), sqlSession);	//session 생성
			}
			
			resultMap.put("memberIdVO", memberIdVO);
			ModelAndView mav = new ModelAndView("jsonView", resultMap);
			return mav;
		}
		
		// Logout
		@RequestMapping("/Logout")
		public String Logout(HttpServletRequest request, HttpServletResponse response) throws DataAccessException, SQLException, IOException {
		HttpSession	session = request.getSession();
		session.removeAttribute("USERINFO");
		session.removeAttribute("USER_CODE");
		session.removeAttribute("USER_EMAIL");
		session.removeAttribute("USER_PASSWORD");
		session.removeAttribute("USER_AGE");
		// remove session
		return "redirect:/hak/Index";
		}
		
		
		// Contact 삽입
		@RequestMapping("/RequestContact")
		public ModelAndView RequestContact(HttpServletRequest request, HttpServletResponse response) throws IOException {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			String dataPack = request.getParameter("paramPack");
			JSONObject dataObj = JSONObject.fromObject(dataPack);
			HashMap jasonMap = (HashMap)JSONObject.toBean(dataObj, HashMap.class);
			
			ContactVO contactVo = new ContactVO();
			
			contactVo.setContact_type(jasonMap.get("type").toString());
			contactVo.setContact_content(jasonMap.get("content").toString());
			contactVo.setContact_user_email(jasonMap.get("email").toString());
			
			sqlSession.insert("contact.insert_contact", contactVo);
			
			ModelAndView mav = new ModelAndView("jsonView", resultMap);
			return mav;
		}
		
		// 학원 데이터 가져오기
		@RequestMapping("/RequestHakData")
		public ModelAndView RequestHakData(HttpServletRequest request, HttpServletResponse response) throws IOException {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			String dataPack = request.getParameter("paramPack");
			JSONObject dataObj = JSONObject.fromObject(dataPack);
			HashMap jasonMap = (HashMap)JSONObject.toBean(dataObj, HashMap.class);
			
			HakVO hakVo = new HakVO();
			
			hakVo.setNeX(Float.parseFloat(jasonMap.get("swX").toString()));
			hakVo.setSwY(Float.parseFloat(jasonMap.get("swY").toString()));
			hakVo.setNeX(Float.parseFloat(jasonMap.get("neX").toString()));
			hakVo.setNeY(Float.parseFloat(jasonMap.get("neY").toString()));
			List<HakVO> listVo = new ArrayList<HakVO>();
			
			listVo = sqlSession.selectList("hak.search_hak", hakVo);
			
			resultMap.put("hakInfo", listVo);
			ModelAndView mav = new ModelAndView("jsonView", resultMap);
			return mav;
		}
}
