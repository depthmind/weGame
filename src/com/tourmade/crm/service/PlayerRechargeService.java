package com.tourmade.crm.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tourmade.crm.common.framework.BaseService;
import com.tourmade.crm.common.framework.bean.QueryResult;
import com.tourmade.crm.common.model.base.value.baseconfig.PageHelper;
import com.tourmade.crm.entity.PlayerRecharge;
import com.tourmade.crm.mapper.playerRecharge.PlayerRechargeMapper;

@Service
@Transactional(readOnly = false)
public class PlayerRechargeService extends BaseService {

	@Autowired
	private PlayerRechargeMapper mapper;
	
	/**
	 * 查询代理下的所有充值记录
	 * 
	 * @param agencyId
	 * @return
	 */
	public QueryResult<PlayerRecharge> findAllPlayerRechargeByAgencyId(PlayerRecharge playerRecharge, PageHelper ph,String agencyId) {
		QueryResult<PlayerRecharge> result = new QueryResult<PlayerRecharge>();
		Map<String, Object> map = new HashMap<String, Object>();
		List<PlayerRecharge> list = new ArrayList<PlayerRecharge>();
		long count = 0L;
		
		String seachValue = ph.getSearch().get("value");
		
		if (null != seachValue && !"".equals(seachValue)) {
			if (null == playerRecharge) {
				playerRecharge = new PlayerRecharge();
			}
			playerRecharge.setSeachValue(seachValue);
		}
		map.put("start", ph.getStart());
		map.put("length", ph.getLength());
		map.put("agencyId", agencyId);
		try {
			list = mapper.selectPlayerRechargeByAgencyId(map);
			count = mapper.countPlayerRechargeByAgencyId(agencyId);
		} catch (Exception e) {
			logger.error("PlayerRechargeService.findAllPlayerRechargeByAgencyId() --> " + agencyId + "-->" + e.getMessage());
		}
		result.setData(list);
		result.setCountTotal(count);
		result.setCountFiltered(count);
		
		return result;
	}
	
	/**
	 * 查询代理销售额
	 * @param agencyId
	 * @return
	 */
	public float countAmountByAgencyId(String agencyId) {
		float result = 0L;
		try {
			result = mapper.countAmountByAgencyId(agencyId);
		} catch (Exception e) {
			logger.error("PlayerRechargeService.countAmountByAgencyId() --> " + agencyId + "-->" + e.getMessage());
		}
		return result;
	}
	
	/**
	 * 管理员查询所有代理销售额
	 * @param agencyId
	 * @return
	 */
	public float countAmount() {
		float result = 0L;
		try {
			result = mapper.countAmount();
		} catch (Exception e) {
			logger.error("PlayerRechargeService.countAmount() --> " + e.getMessage());
		}
		return result;
	}
	
	/**
	 * 查询代理下级的销售额
	 * @param agencyId
	 * @return
	 */
	public float countAgencyAmountByAgencyId(String agencyId) {
		float result = 0L;
		try {
			result = mapper.countAgencyAmountByAgencyId(agencyId);
		} catch (Exception e) {
			logger.error("PlayerRechargeService.countAgencyAmountByAgencyId() --> " + agencyId + "-->" + e.getMessage());
		}
		return result;
	}
	
	public QueryResult<PlayerRecharge> findAllAgencyPlayerRechargeByAgencyId(PlayerRecharge playerRecharge, PageHelper ph,String agencyId) {
		QueryResult<PlayerRecharge> result = new QueryResult<PlayerRecharge>();
		Map<String, Object> map = new HashMap<String, Object>();
		List<PlayerRecharge> list = new ArrayList<PlayerRecharge>();
		long count = 0L;
		
		String seachValue = ph.getSearch().get("value");
		
		if (null != seachValue && !"".equals(seachValue)) {
			if (null == playerRecharge) {
				playerRecharge = new PlayerRecharge();
			}
			playerRecharge.setSeachValue(seachValue);
		}
		map.put("start", ph.getStart());
		map.put("length", ph.getLength());
		map.put("agencyId", agencyId);
		try {
			list = mapper.selectAgencyPlayerRechargeByAgencyId(map);
			count = mapper.countAgencyPlayerRechargeByAgencyId(agencyId);
		} catch (Exception e) {
			logger.error("PlayerRechargeService.findAllAgencyPlayerRechargeByAgencyId() --> " + agencyId + "-->" + e.getMessage());
		}
		result.setData(list);
		result.setCountTotal(count);
		result.setCountFiltered(count);
		
		return result;
	}
}
