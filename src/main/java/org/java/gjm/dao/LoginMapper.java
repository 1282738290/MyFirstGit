package org.java.gjm.dao;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface LoginMapper {

    Map login(@Param("username") String username);

    List<Map> loadMenus(@Param("userId") int userId);

    Map findRoleAndDep(@Param("userId") int userId);

    List<Map> findSubMenus(@Param("mm") String mm);

    List<String> loadPermissions(@Param("userId") int userId);

    void upd0(@Param("emp_id") int emp_id);
    void upd1(@Param("emp_id") int emp_id);
    int findCont();
}
