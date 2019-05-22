package org.java.gjm.dao;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface MyTaskMapper {

    List<Map> findAll();

    void addPreReq(Map map);

    Map findAllPreReq(@Param("processInstanceId") String processInstanceId);

    void deleteMyTask(@Param("pre_id") String pre_id);

    Map findPreReqByPre_id(@Param("pre_id") String pre_id);

    void updateMyTask(Map map);

    List<Map> findAudit(@Param("pre_id") String pre_id);

    void addMessages(@Param("pre_id") String pre_id);

    Map findMessages(@Param("pre_id") String pre_id);

    void updMessages(@Param("status") int status,@Param("pre_id") String pre_id);

    void updateMessages(@Param("pre_id") String pre_id);

}
