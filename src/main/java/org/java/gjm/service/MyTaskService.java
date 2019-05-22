package org.java.gjm.service;

import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricTaskInstance;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface MyTaskService {

    List<Map> findAll();

    void addPreReq(Map map);

    List<Map> findAllPreReq(String user);

    void deleteMyTask(String taskid,String processInstanceId,String pre_id);

    Map findPreReqByPre_id(String pre_id);

    void updateMyTask(Map map);

    void songShen(String taskId,String pre_id);

    List<Map> showHistoryTask(String instanceId);

    Map findAllPreReqByPre_id(String pre_req);

    List<Map> findHistoryInstance(String processDefinitionId);
}
