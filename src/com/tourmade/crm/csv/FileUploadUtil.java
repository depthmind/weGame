package com.tourmade.crm.csv;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLConnection;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.aliyun.oss.OSSClient;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.DataInputStream;  
import java.io.DataOutputStream;  
import java.io.InputStreamReader;  
import java.net.HttpURLConnection;  
import java.net.MalformedURLException;  
public class FileUploadUtil {
    static Logger logger = Logger.getLogger(FileUploadUtil.class);
    /**
     * 写文件到本地文件夹
     *
     * 返回生成的文件名
     */
    public static boolean copyStreamFile(InputStream inputStream, String filePath, String fileName) throws IOException {
        File file = new File(filePath);
        if (!file.exists()) {
            file.mkdirs();
        }

        OutputStream outputStream = null;
        try {
            outputStream = new FileOutputStream(filePath + File.separator + fileName);
            int readBytes = 0;
            byte[] buffer = new byte[10000];
            while ((readBytes = inputStream.read(buffer, 0, 10000)) != -1) {
                outputStream.write(buffer, 0, readBytes);
            }
            return true;
        } catch (IOException ioe) {
            logger.error(ioe.getMessage(), ioe);
            throw ioe;
        } finally {
            if (outputStream != null) {
                try {
                    outputStream.close();
                } catch (IOException e) {
                    logger.error(e.getMessage(), e);
                }
            }
            if (inputStream != null) {
                try {
                    inputStream.close();
                } catch (IOException e) {
                    logger.error(e.getMessage(), e);
                }
            }
        }

    }

    public static String formatPath(String path) {
        path = path.replaceAll("\\\\", "/");
        if (!path.endsWith("/")) {
            path = path + "/";
        }
        return path;
    }

    /**
     * 运行环境绝对路径
     *
     */
    public static String getRealPath(HttpServletRequest request) {
        return request.getSession().getServletContext().getRealPath("/");
    }

    /**
     * 获取上传文件的文件流
     *
     */
    public static Map<String, Object> getUploadInputStreamAndName(HttpServletRequest request) throws Exception {
        if (ServletFileUpload.isMultipartContent(request)) {
            Map<String, Object> map = new HashMap<String, Object>();
            MultipartHttpServletRequest req = (MultipartHttpServletRequest) request;
            for (Iterator<String> iterator = req.getFileNames(); iterator.hasNext();) {
                String type = iterator.next();
                MultipartFile multipartFile = req.getFile(type);
                String fileName = multipartFile.getOriginalFilename();
                map.put("inputStream", multipartFile.getInputStream());
                map.put("fileName", fileName);
                if(StringUtils.isNotBlank(fileName)){
                	map.put("postfix", fileName.substring(fileName.lastIndexOf("."), fileName.length()));
                }else{
                	map.put("postfix","");
                }
                return map;
            }
        }
        return null;
    }

    /**
     * 上传文件
     *
     */
    public static Map<String, Object> upload(String uploadPath, HttpServletRequest request) {
        try {
            Map<String, Object> map = getUploadInputStreamAndName(request);
            if (map == null || map.isEmpty()) {
                return null;
            }
//          uploadPath=formatPath(uploadPath);
            uploadPath = uploadPath.replaceAll("\\\\", "/");
            if (!uploadPath.endsWith("/")) {
                uploadPath = uploadPath + "/";
            }
            File savePath = new File(uploadPath);
            //logger.info("最终文件存储路径---------"+uploadPath);
            if (!savePath.exists() && !savePath.isDirectory()) {
                savePath.mkdirs();
            }
            String fileName = map.get("fileName").toString();

            //logger.info(fileName);
            String postfix = map.get("postfix").toString();
            InputStream inputStream = (InputStream) map.get("inputStream");
            String file = uuid22() + postfix;
            //String file = fileName;
            //logger.info("开始上传:\npath:" + uploadPath + "\nfile:" + fileName + "--->" + file);
            FileUploadUtil.copyStreamFile(inputStream, uploadPath, file);

            map.put("fileUrl", uploadPath + file);
            return map;
        } catch (Exception e) {
            logger.error("文件上传错误!", e);
            return null;
        }
    }

    /**
     * 通过base64编码压缩到22位
     *
     * @return
     */
    public synchronized static String uuid22() {
        return compressedUuid();
    }

    // 直接返回一个对象的JSON字符串，用于POST请求的应答消息
    public static void writeStringResponse(HttpServletResponse res, Object bean) {
        JSONObject obj = (JSONObject) (bean instanceof JSONObject ? bean : JSONObject.toJSON(bean));
        String json = obj.toString();
        try {
            // 设置输出文本格式为json
            res.setContentType("application/json");
            res.setCharacterEncoding("utf-8");
            // 获得输出流对象PrintWriter
            PrintWriter out = res.getWriter();
            // 输出json对象，这里可以封装用户提取出来的json字符串
            out.print(json);
            out.flush();
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
        }
    }

    private static String compressedUuid() {
        UUID uuid = UUID.randomUUID();
        return compressedUUID(uuid);
    }

    protected static String compressedUUID(UUID uuid) {
        byte[] byUuid = new byte[16];
        long least = uuid.getLeastSignificantBits();
        long most = uuid.getMostSignificantBits();
        long2bytes(most, byUuid, 0);
        long2bytes(least, byUuid, 8);
        String compressUUID = Base64.encodeBase64URLSafeString(byUuid);
        return compressUUID;
    }

    protected static void long2bytes(long value, byte[] bytes, int offset) {
        for (int i = 7; i > -1; i--) {
            bytes[offset++] = (byte) ((value >> 8 * i) & 0xFF);
        }
    }
    
    public static boolean DeleteFolder(String uploadPath) { 
    	boolean flag = false;  
		File file = new File(uploadPath);  
		// 判断目录或文件是否存在  
		if (!file.exists()) {  // 不存在返回 false  
			return flag;  
		} else {  
			// 判断是否为文件  
			if (file.isFile()) {  // 为文件时调用删除文件方法  
				return deleteFile(uploadPath);  
			} else {  // 为目录时调用删除目录方法  
				return deleteDirectory(uploadPath);  
			}  
		}  
    }
  //删除单个文件
  	public static boolean deleteFile(String uploadPath) {  
  		boolean flag = false;  
  	    File file = new File(uploadPath);  
  	    // 路径为文件且不为空则进行删除  
  	    if (file.isFile() && file.exists()) {  
  	        file.delete();  
  	        flag = true;  
  	    }  
  	    return flag;  
  	} 
  	//删除文件夹
  	public static boolean deleteDirectory(String uploadPath) {  
  	    //如果sPath不以文件分隔符结尾，自动添加文件分隔符  
  	    if (!uploadPath.endsWith(File.separator)) {  
  	    	uploadPath = uploadPath + File.separator;  
  	    }  
  	    File dirFile = new File(uploadPath);  
  	    //如果dir对应的文件不存在，或者不是一个目录，则退出  
  	    if (!dirFile.exists() || !dirFile.isDirectory()) {  
  	        return false;  
  	    }  
  	    boolean flag = true;  
  	    //删除文件夹下的所有文件(包括子目录)  
  	    File[] files = dirFile.listFiles();  
  	    for (int i = 0; i < files.length; i++) {  
  	        //删除子文件  
  	        if (files[i].isFile()) {  
  	            flag = deleteFile(files[i].getAbsolutePath());  
  	            if (!flag) break;  
  	        } //删除子目录  
  	        else {  
  	            flag = deleteDirectory(files[i].getAbsolutePath());  
  	            if (!flag) break;  
  	        }  
  	    }  
  	    if (!flag) return false;  
  	    //删除当前目录  
  	    if (dirFile.delete()) {  
  	        return true;  
  	    } else {  
  	        return false;  
  	    }  
  	} 
  	
  	//读文件
   public static boolean  downloadFile(String fileAddress, HttpServletResponse response ) throws IOException{
	   try {  
//		   File dirFile = new File(localFileAddress);
//	        if(!dirFile.exists()){//文件路径不存在时，自动创建目录
//	          dirFile.createNewFile();
//	        }
		   logger.info("下载时，服务器文件存储地址："+fileAddress);
//		  logger.info("下载时，本地文件存储地址："+localFileAddress);
		   String fileContent = "";
           BufferedReader br=new BufferedReader(new InputStreamReader(new FileInputStream(fileAddress),"utf-8"));
           String line;   
           while ((line = br.readLine()) != null) {   
               fileContent += line;   
           } 
//           URL url = new URL(fileAddress);
//           URLConnection con = url.openConnection();
//           FileInputStream stream = new FileInputStream(con.getInputStream().toString());
//           BufferedReader br=new BufferedReader(new InputStreamReader(stream,"utf-8"));
//           String line;   
//           while ((line = br.readLine()) != null) {   
//               fileContent += line;   
//           } 
           BufferedWriter bw=new BufferedWriter(new OutputStreamWriter(new FileOutputStream(response.getOutputStream().toString()),"utf-8"));
           bw.write(fileContent);
//           int len = 0;  
//           while ((len = is.read(buffer)) !=-1) {  
//             os.write(buffer, 0, len);  
//           }  
           br.close();
           bw.close(); 
           return true;
         }  
         catch (Exception e) {  
           return false;  
         } 
       }
}