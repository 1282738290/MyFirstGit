package org.java.gjm.service;

import java.util.List;
import java.util.Map;

public interface PersonnelService {

    //显示可以拾取的组任务
    List<Map> showGroupTask(String userId);

    void claim(String taskId, String userId);

    void submitAudit(Map<String,Object> m);
}
