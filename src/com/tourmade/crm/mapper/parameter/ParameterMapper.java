package com.tourmade.crm.mapper.parameter;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.tourmade.crm.common.framework.BaseMapper;
import com.tourmade.crm.entity.EntityList;
import com.tourmade.crm.entity.Parameter;

public interface ParameterMapper extends BaseMapper {
	
	public List<Parameter> queryParameter(Map<String, Object> params);
	
	public long countParameter(Parameter Parameter);
	
	public void saveParameter(Parameter Parameter);

	public void updateParameter(Parameter Parameter);

	public void deleteParameterById(int ParameterId);
	
	public Parameter getParameterById(int ParameterId);
	
	public List<EntityList> selectAllActivityName();
	
	public List<EntityList> selectAllDestinationName();
	
	
	public List<EntityList> selectAllAreaCode();
	
	List<Parameter> selectParameterByParaDomain(String paraDomain);
	
	public String selectParaValue(@Param("chinese")String chinese,@Param("domain")String domain);
	
	public String selectParaValueById(@Param("enterpriseId")Integer enterpriseId,@Param("domain")String domain);
}