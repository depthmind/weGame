package com.tourmade.crm.mapper.user;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.tourmade.crm.common.framework.BaseMapper;
import com.tourmade.crm.entity.EntityList;
import com.tourmade.crm.entity.User;

public interface UserMapper extends BaseMapper {

	public List<User> queryUser(Map<String, Object> params);
	
	public List<User> queryUserAmount(Map<String, Object> params);

	public List<EntityList> queryUserAll();
	
	public long countUser(User user);

	public void saveUser(User user);

	public int updateUser(User user);

	public void deleteUserById(int userId);

	public User getUserById(int userId);

	public String getRoleNameById(int userId);

	public String checkButtonId(String menuName);

	public String checkButtonIdExist(String menuId, String roleId);

	public User signin(User user);

	public List<?> permissionCheckUrl(String username);

	public String permissionCheckRole(String username);

	public List<EntityList> getParameterInfo(String domain);

	public List<EntityList> getUserRoles();

	public List<String> getMenuId(String roleId);

	public String getUrlByMenuName(String menuName);

	public String getMenuNameByMenuId(String Menu);
	
	public List<User> getUserByRoleId(int role_id);

	public String validate(@Param("table") String table, @Param("field") String field,
			@Param("filter_field") String filter_field, @Param("filter_name") String filter_name,
			@Param("name") String name);

	public User selectUserByOpenId(String openId);
	
	public User selectUserByUnionId(String UnionId);
	
	//public void updateUserByOpenId(List<User> userList);
	public void updateUserByOpenId(User user);
	
	public List<User> getAllUserToUpdateUnionId();

	public void updateUserByUserId(Map<String, Object> param);
}
