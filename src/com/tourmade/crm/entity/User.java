package com.tourmade.crm.entity;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.tourmade.crm.common.framework.BaseBean;

/**
 * 用户model
 * 
 * @author machao
 *
 */
public class User extends BaseBean<User> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1423523863575074623L;

	private Integer userId;

	private String name;

	private String loginName;

	private String pwd;
	
	private String email;
	
	private String openId;
	
	private String unionId;
	
	private String mobilephone;
	
	private Date creatTime;
	
	private Date updateTime;
	
	private Integer role_id;
	
	private String imId;
	
	private String imPwd;
	
	private String avator;
	
	private String headImgUrl;
	
	private Integer serviceType;
	
	private String state;
	
	private String nickName;
	
	private String tencentImId;
	
	private Boolean hasPay;
	
	private String agency; // 上级代理
	
	private String rechargeLink;
	
	private String registerLink;
	
	private long amount;
	
	private Integer invalid;
	
	private Date invalidDate;
	
	private String invalidDateStr;
	
	public String getInvalidDateStr() {
		return invalidDateStr;
	}

	public void setInvalidDateStr(String invalidDateStr) {
		this.invalidDateStr = invalidDateStr;
	}

	public Date getInvalidDate() {
		return invalidDate;
	}

	public void setInvalidDate(Date invalidDate) {
		this.invalidDate = invalidDate;
	}

	public Integer getInvalid() {
		return invalid;
	}

	public void setInvalid(Integer invalid) {
		this.invalid = invalid;
	}

	public long getAmount() {
		return amount;
	}

	public void setAmount(long amount) {
		this.amount = amount;
	}

	public String getAgency() {
		return agency;
	}

	public void setAgency(String agency) {
		this.agency = agency;
	}

	public String getRechargeLink() {
		return rechargeLink;
	}

	public void setRechargeLink(String rechargeLink) {
		this.rechargeLink = rechargeLink;
	}

	public String getRegisterLink() {
		return registerLink;
	}

	public void setRegisterLink(String registerLink) {
		this.registerLink = registerLink;
	}

	public Boolean getHasPay() {
		return hasPay;
	}

	public void setHasPay(Boolean hasPay) {
		this.hasPay = hasPay;
	}

	public String getTencentImId() {
		return tencentImId;
	}

	public void setTencentImId(String tencentImId) {
		this.tencentImId = tencentImId;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Integer getServiceType() {
		return serviceType;
	}

	public void setServiceType(Integer serviceType) {
		this.serviceType = serviceType;
	}

	public String getImId() {
		return imId;
	}

	public void setImId(String imId) {
		this.imId = imId;
	}

	public String getImPwd() {
		return imPwd;
	}

	public void setImPwd(String imPwd) {
		this.imPwd = imPwd;
	}

	public String getAvator() {
		return avator;
	}

	public void setAvator(String avator) {
		this.avator = avator;
	}

	public String getHeadImgUrl() {
		return headImgUrl;
	}

	public void setHeadImgUrl(String headImgUrl) {
		this.headImgUrl = headImgUrl;
	}

	public String getOpenId() {
		return openId;
	}

	public void setOpenId(String openId) {
		this.openId = openId;
	}

	public String getUnionId() {
		return unionId;
	}

	public void setUnionId(String unionId) {
		this.unionId = unionId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMobilephone() {
		return mobilephone;
	}

	public void setMobilephone(String mobilephone) {
		this.mobilephone = mobilephone;
	}

	public Date getCreatTime() {
		return creatTime;
	}

	public void setCreatTime(Date creatTime) {
		this.creatTime = creatTime;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public Integer getRole_id() {
		return role_id;
	}

	public void setRole_id(Integer role_id) {
		this.role_id = role_id;
	}

	@Override
	public String toString() {
		return "User [userId=" + userId + ", name=" + name + ", loginName=" + loginName + ", pwd=" + pwd + ", email="
				+ email + ", openId=" + openId + ", unionId=" + unionId + ", mobilephone=" + mobilephone
				+ ", creatTime=" + creatTime + ", updateTime=" + updateTime + ", role_id=" + role_id + ", imId=" + imId
				+ ", imPwd=" + imPwd + ", avator=" + avator + ", headImgUrl=" + headImgUrl + ", serviceType="
				+ serviceType + ", state=" + state + ", nickName=" + nickName + ", tencentImId=" + tencentImId + "]";
	}
}
