package com.tourmade.crm.entity;

import java.sql.Date;

import com.tourmade.crm.common.framework.BaseBean;

public class PlayerRecharge extends BaseBean<PlayerRecharge> {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2835649080480948245L;

	private Integer rechargeId;
	
	private String playerId;
	
	private String playerName;
	
	private String playerAccount;
	
	private Float amount;
	
	private String paymentMethod;
	
	private String agencyId;
	
	private Date createTime;
	
	private Date updateTime;
	
	private Integer isDel;

	public Integer getRechargeId() {
		return rechargeId;
	}

	public void setRechargeId(Integer rechargeId) {
		this.rechargeId = rechargeId;
	}

	public String getPlayerId() {
		return playerId;
	}

	public void setPlayerId(String playerId) {
		this.playerId = playerId;
	}

	public String getPlayerName() {
		return playerName;
	}

	public void setPlayerName(String playerName) {
		this.playerName = playerName;
	}

	public String getPlayerAccount() {
		return playerAccount;
	}

	public void setPlayerAccount(String playerAccount) {
		this.playerAccount = playerAccount;
	}

	public Float getAmount() {
		return amount;
	}

	public void setAmount(Float amount) {
		this.amount = amount;
	}

	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public String getAgencyId() {
		return agencyId;
	}

	public void setAgencyId(String agencyId) {
		this.agencyId = agencyId;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public Integer getIsDel() {
		return isDel;
	}

	public void setIsDel(Integer isDel) {
		this.isDel = isDel;
	}
}
