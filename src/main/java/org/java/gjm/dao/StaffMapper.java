package org.java.gjm.dao;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface StaffMapper {

    List<Map> findAllEmployee(@Param("index") int index,@Param("rows") int rows);

    List<Map> findAllMenu(@Param("role_id") int role_id);

    void updateLocked(@Param("locked") int locked,@Param("emp_id") int emp_id);

    Map findByemp_id(@Param("emp_id") int emp_id);

    List<Map> findAll();

    List<Map> findAllBumen();

    List<Map> findjsByDep_id(@Param("dep_id") int dep_id);

    void updatebmzw(@Param("role_id") int role_id,@Param("user_id") int user_id);

    int findcounts();
}
