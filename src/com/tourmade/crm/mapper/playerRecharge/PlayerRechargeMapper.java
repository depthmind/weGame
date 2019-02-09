package com.tourmade.crm.mapper.playerRecharge;

import java.util.List;
import java.util.Map;

import com.tourmade.crm.common.framework.BaseMapper;
import com.tourmade.crm.entity.PlayerRecharge;

public interface PlayerRechargeMapper extends BaseMapper {
	List<PlayerRecharge> selectPlayerRechargeByAgencyId(Map<String, Object> map);
	
	long countPlayerRechargeByAgencyId(String agencyId);
	
	float countAmountByAgencyId(String agencyId);
	
	float countAmount();
	
	List<PlayerRecharge> selectAgencyPlayerRechargeByAgencyId(Map<String, Object> map);
	
	long countAgencyPlayerRechargeByAgencyId(String agencyId);
	
	float countAgencyAmountByAgencyId(String agencyId);
}
