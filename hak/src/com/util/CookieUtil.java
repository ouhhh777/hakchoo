package com.util;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 

/**
 *
 * @author 
 * @version
 * @since 
 *
 * @see
 */
public class CookieUtil {
	  /**
	    * cookie 값을 설정하는 메소드.
	    * @param HttpServletResponse response
	    * @param String cookieName
	    * @param String cookieValue
	    */
	    public void setCookie(HttpServletResponse response, String cookieName, String cookieValue) {
	        int maxAge = (60 * 60 * 24 * 15); // 15day
	        setCookie(response, cookieName, cookieValue, maxAge);
	    }
	 
	    /**
	    * cookie 값을 설정하는 메소드.
	    * @param HttpServletResponse response
	    * @param String cookieName
	    * @param String cookieValue
	    * @param int maxAge
	    */
	    public void setCookie(HttpServletResponse response, String cookieName, String cookieValue, int maxAge) {
	        cookieValue = URLEncoder.encode(cookieValue);
	        Cookie cookie = new Cookie(cookieName, cookieValue);
	        cookie.setMaxAge(maxAge);
	        response.addCookie(cookie);
	    }
	 
	    /**
	    * cookie 값을 찾아서 리턴하는 메소드.
	    * @param HttpServletRequest request
	    * @param String cookieName
	    * @return String
	    */
	    public String getCookie(HttpServletRequest request, String cookieName) {
	        Cookie[] cookies = request.getCookies();
	        String cookieValue = null;
	        for (int i = 0; i < cookies.length; i++) {
	            if (cookieName.equals(cookies[i].getName())) {
	                cookieValue = URLDecoder.decode(cookies[i].getValue());
	                break;
	            }
	        }
	        return cookieValue;
	    }
	    
	    public void delCookie(HttpServletRequest request, HttpServletResponse response){
	    	Cookie[] cookies = request.getCookies();
	        if (cookies != null && cookies.length > 0) {
	            for (int i = 0 ; i < cookies.length ; i++) {
	                if (cookies[i].getName().equals("userId")) {
	                    Cookie cookie = new Cookie("userId", "");
	                    cookie.setMaxAge(0);   
	                    response.addCookie(cookie);
	                }
	            }
	        }

	    }

}