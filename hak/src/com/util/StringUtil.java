package com.util;
 
import java.io.File;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.sql.Blob;
import java.sql.Clob;
import java.text.DecimalFormat;
import java.util.Random;

import org.apache.log4j.Logger;

import sun.misc.BASE64Encoder;

/**
 *
 * @author 
 * @version
 * @since 
 *
 * @see
 */
public class StringUtil {

	static Logger logger = Logger.getLogger(StringUtil.class);
    /**
     * Constructor
     */
    public StringUtil() {
    }
    
    /**
     * <pre>
     * </pre>
     *
     * @param String text
     *
     * @return String
     */
    public  static String getEUC_KR(String text)
    {
        String rtn;

        rtn = "";

        if (text == null)
            return rtn;
        else {
            try {
                return new String(text.getBytes("8859_1"),"euc-kr");
            }
            catch (UnsupportedEncodingException UEE)
            {
                return rtn;
            }
        }
    }

    /**
     * @param String text
     *
     * @return String
     */
    public  static String get8859_1(String text)
    {
        String rtn;

        rtn = "";

        if (text == null)
            return rtn;
        else {
            try {
                return new String(text.getBytes("euc-kr"),"8859_1");
            }
            catch (UnsupportedEncodingException UEE)
            {
                return rtn;
            }
        }
    }

    /**
     * <pre>
     * </pre>
     *
     * @param String text
     * @param String fromEncode
     * @param String toEncode
     *
     * @return String
     */
    public  static String getConvertCharset(String text, String fromEncode, String toEncode)
    {
        String rtn;

        rtn = "";

        if (text == null)
            return rtn;
        else {
            try {
                return new String(text.getBytes(fromEncode),toEncode);
            }
            catch (UnsupportedEncodingException UEE)
            {
                return rtn;
            }
        }
    }

    /**
     * <pre>
     * </pre>
     *
     * @param String str
     * @param String rep
     * @param String tok
     *
     * @return String
     */
    public  static String getReplace(String str, String rep, String tok)
    {
        String retStr = "";

        if (str==null) return "";
        if (str.equals("")) return "";

        for(int i = 0, j = 0; (j = str.indexOf(rep,i)) > -1 ; i = j+rep.length()) {
            retStr += (str.substring(i,j) + tok);
        }
        return (str.indexOf(rep) == -1) ? str : retStr + str.substring(str.lastIndexOf(rep)+rep.length(),str.length());
    }

    /**
     * <pre>
     * & --->> &amp;
     * < --->> &lt;
     * > --->> &gt;
     * ' --->> &acute;
     * " --->> &quot;
     * | --->> &brvbar;
     * </pre>
     *
     * @param String str
     *
     * @return String
     */
    public  static String getSpecialCharacters(String str)
    {
        str = getReplace(str, "&", "&amp;");
        str = getReplace(str, "<", "&lt;");
        str = getReplace(str, ">", "&gt;");
        str = getReplace(str, "'", "&acute;");
        str = getReplace(str, "\"", "&quot;");
        str = getReplace(str, "|", "&brvbar;");
        str = getReplace(str, "\n", "<BR>");
        str = getReplace(str, "\r", "");

        return str;
    }

    /**
     * <pre>
     * &amp;    --->> &
     * &lt;     --->> <
     * &gt;     --->> >
     * &acute;  --->> '
     * &quot;   --->> "
     * &brvbar; --->> |
     * </pre>
     *
     * @param String str
     *
     * @return String
     */
    public  static String getRreplaceSpecialCharacters(String str)
    {
        str = getReplace(str, "<BR>", "\n");
        str = getReplace(str, "&amp;", "&");
        str = getReplace(str, "&lt;", "<");
        str = getReplace(str, "&gt;", ">");
        str = getReplace(str, "&acute;", "'");
        str = getReplace(str, "&quot;", "\"");
        str = getReplace(str, "&brvbar;", "|");

        return str;
    }

    /**
     * <pre>
     * </pre>
     *
     * @param String str
     *
     * @return String
     */
    public static String getComma(String str)
    {
        return getComma(str,true);
    }

    /**
     * <pre>
     * </pre>
     *
     * @param String str
     * @param boolean isTruncated
     *
     * @return String
     */
    public static String getComma(String str, boolean isTruncated)
    {
        DecimalFormat commaFormat; 

        if (str==null)
            return "";
        else if (str.trim().equals(""))
            return "";
        else if (str.trim().equals("&nbsp;"))
            return "&nbsp;";
        else {
            
            int pos = str.indexOf(".");
            if (pos!=-1) {
                if (!isTruncated) {
                    commaFormat = new DecimalFormat("#,##0.00");
                    return commaFormat.format(Float.parseFloat(str.trim()));
                }
                else {
                    commaFormat = new DecimalFormat("#,##0");
                    return commaFormat.format(Long.parseLong(str.trim().substring(0,pos)));
                }
            }
            else {
                commaFormat = new DecimalFormat("#,##0");
                return commaFormat.format(Long.parseLong(str.trim()));
            }
        }
    }

    /**
     * <pre>
     * </pre>
     *
     * @param Long lstr
     *
     * @return String
     */
    public  static String getComma(Long lstr)
    {
        DecimalFormat commaFormat; 
        commaFormat = new DecimalFormat("#,##0");

        if (lstr==null) return "";
        else return commaFormat.format(lstr);
    }


    
    public static String nvl(String beforeStr,String afterStr){
    	String res = "";
    	
    	if(beforeStr==null){
    		res = afterStr;
    	}else if(beforeStr=="null"){
    		res = afterStr;
    	}else{
    		res = beforeStr;
    	}
    	return res;
    }
    public static String nvl(String beforeStr){
    	String res = null;
    	
    	if(beforeStr==null){
    		res = "";
    	}else if(beforeStr=="null"){
    		res = "";
    	}else{
    		res = beforeStr;
    	}
    	return res;
    }
    public static String NVL(String beforeStr,String afterStr){
    	String res = "";
    	
    	if(beforeStr==null){
    		res = afterStr;
    	}else if(beforeStr=="null"){
    		res = afterStr;
    	}else{
    		res = beforeStr;
    	}
    	return res;
    }
    public static String NVL(String beforeStr){
    	String res = null;
    	
    	if(beforeStr==null){
    		res = "";
    	}else if(beforeStr=="null"){
    		res = "";
    	}else{
    		res = beforeStr;
    	}
    	return res;
    }
    
    public static String NVL(Object obj){
    	String res = null;
    	
    	if(obj==null){
    		res = "";
    	}else if(obj=="null"){
    		res = "";
    	}else{
    		res = obj.toString();
    	}
    	return res;
    }
    
	public static String longBr(String str,int length){
    	String rst = "";
    	if(str.length()>length){
    		rst = str.substring(0,length)+"<br>"+str.substring(length,str.length());
    	}else{
    		rst = str;
    	}
    	return rst;
    }
	
    
    /**
     * 
     * @param str
     * @return
     */
    public  static String toJS(String str) {
		return str.replace("\\", "\\\\")
		          .replace("\'", "\\\'")
		          .replace("\"", "\\\"")
		          .replace("\r\n", "\\n")
		          .replace("\n", "\\n");
	}
    
    
    /**
     * @param c
     * @return
     * @throws Exception
     * @since 2011.8.11 (�ɼ���)
     */
    public static String clobToString(Clob c) throws Exception
    {
    	StringBuffer res = new StringBuffer();
    	try
    	{
    		if(c!=null)
    		{
    			int lengthof=(int)c.length();
    			java.io.Reader readClobis = c.getCharacterStream();
    			char[] ch = new char[lengthof];
    			for (int i=0 ; i < lengthof  ; i++)
    			{
    				ch[i] = (char)readClobis.read();
    				res.append(ch[i]);
    			}
    		}
    	}
    	catch(Exception e)
    	{
    		logger.error(e.getMessage());
    		throw e;
    	}
    	return res.toString();
    }
    
    public static String blobToString(Blob c) throws Exception
    {
    	StringBuffer res = new StringBuffer();
    	try
    	{
    		if(c!=null)
    		{
    			int lengthof=(int)c.length();
    			InputStream readClobis = c.getBinaryStream();
    			char[] ch = new char[lengthof];
    			for (int i=0 ; i < lengthof  ; i++)
    			{
    				ch[i] = (char)readClobis.read();
    				res.append(ch[i]);
    			}
    		}
    	}
    	catch(Exception e)
    	{
    		logger.error(e.getMessage());
    		throw e;
    	}
    	return res.toString();
    }
//  암호화
public  static String encrypt(String value){
    	String retVal = "";
       
    	try {
    		//value = new String(value.getBytes("UTF-8"), "ISO-8859-1");
    		byte[] plainText = null; // 평문
    		plainText = value.getBytes();
       
    		BASE64Encoder encoder = new BASE64Encoder();
    		retVal = encoder.encode(plainText);
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return retVal;
}
//
//
//    //복호화
//    public  static String decrypt(String encodedString) {
//    	String retVal = "";
//    	try {
//    		byte[] plainText = null; // 해쉬 값
//    		BASE64Decoder decoder = new BASE64Decoder();
//    		plainText = decoder.decodeBuffer (encodedString ); 
//    		
//    		retVal =new String(plainText);
//    		//retVal = new String(retVal.getBytes("ISO-8859-1"), "UTF-8");
//    	} catch(Exception e){
//    		e.printStackTrace();
//    	}
//    	
//    	return retVal;
//    }
    
    public static String randomPw( int length ) {
		StringBuffer buffer = new StringBuffer();
		Random random = new Random();
		
		String chars[] = "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z".split( "," );
		for( int i = 0; i < length; i++ ) {
			buffer.append( chars[random.nextInt( chars.length )] );
		}
		return buffer.toString();
	}
    
    public static String random( int length ) {
		StringBuffer buffer = new StringBuffer();
		Random random = new Random();
		
		String[] chars = "1,2,3,4,5,6,7,8,9,0".split( "," );
		for( int i = 0; i < length; i++ ) {
			buffer.append( chars[random.nextInt( chars.length )] );
		}
		return buffer.toString();
	}
    
    //영문과 숫자 조합
    public static String randomIntEng(int length) {
    	Random rnd =new Random();

    	StringBuffer buf =new StringBuffer();

    	for(int i=0;i<length;i++){
    	    if(rnd.nextBoolean()){
    	        buf.append((char)((int)(rnd.nextInt(26))+97));
    	    }else{
    	        buf.append((rnd.nextInt(10))); 
    	    }
    	}
    	return buf.toString();
    }
    
    public static String trim(String str, String defValue) {
 		if (str == null || "".equals(str)) {
 			return defValue;
	    } else if (str.trim().length() == 0) {
	    	return defValue;
	    } else {
	    	return str.trim();
	    }
 	}
    
    
    public static void removeFile(String fileStr) {
		File file = new File(fileStr);
		
		if(file.isFile()) {
			file.delete();
		}
	}
    
    //말줄임
    public static String ellipsis(String text, int length){
        String ellipsisString = "...";
        String outputString = text;
     
        if(text.length()>0 && length>0){
            if(text.length()>length){
                outputString = text.substring(0, length);
                outputString += ellipsisString;
            }
        }
        
        return outputString;
    }
    
    //HTML 태그 제거
    public static String removeTab(String str) {
    	//String returnStr = str.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
    	String returnStr = str.replaceAll("<[^>]*>", " ");
    	
    	return returnStr;
    }
    
    public static String nl2br(String str) {
    	str = str.replaceAll("\r\n", "<br>");
    	str = str.replaceAll("\r", "<br>");
    	str = str.replaceAll("\n", "<br>");
	  
    	return str;
    }
    
}