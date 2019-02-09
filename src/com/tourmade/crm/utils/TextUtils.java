/**
 * 
 */
package com.tourmade.crm.utils;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.UnsupportedEncodingException;

/**
 * @author liuhan
 *
 */
public class TextUtils {

	  public String readTxtFile(String filePath){
		  InputStream in = TextUtils.class.getResourceAsStream(filePath);
		  StringBuffer sb = new StringBuffer(); 
          try { 
                  Reader r = new InputStreamReader(in, "GBK"); 
                  int length = 0; 
                  for (char[] c = new char[1024]; (length = r.read(c)) != -1;) { 
                          sb.append(c, 0, length); 
                  } 
                  r.close(); 
          } catch (UnsupportedEncodingException e) { 
                  e.printStackTrace(); 
          } catch (FileNotFoundException e) { 
                  e.printStackTrace(); 
          } catch (IOException e) { 
                  e.printStackTrace(); 
          } 
          return sb.toString();
	    }
}
