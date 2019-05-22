package org.java.gjm.service.impl;

import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.java.gjm.dao.MyTaskMapper;
import org.java.gjm.dao.PersonnelMapper;
import org.java.gjm.service.PersonnelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class PersonnelServiceImpl implements PersonnelService {

    @Autowired
    private TaskService taskService;

    @Autowired
    private MyTaskMapper myTaskMapper;

    @Autowired
    private PersonnelMapper personnelMapper;

    @Override
    //显示可以拾取的组任务
    public List<Map> showGroupTask(String userId) {
        TaskQuery query = taskService.createTaskQuery();
        query.taskCandidateUser(userId);
        List<Task> tasklist = query.list();//当前用户可以参与办理的组任务
        //创建List<map>，存放对应的业务数据
        List<Map> list = new ArrayList<>();

        for(Task t:tasklist){
            //取到当前任务对应的业务数据
            //得到当前任务对应的流程实例id
            String processInstanceId = t.getProcessInstanceId();
            //得到业务数据
            Map<String, Object> map =myTaskMapper.findAllPreReq(processInstanceId);

            //把当前任务的相关信息，也存放到map中返回
            map.put("taskId",t.getId());//任务id
            map.put("taskName",t.getName());//任务名称
            map.put("startTime",t.getCreateTime());//创建时间

            list.add(map);
        }
        return list;
    }

    /**
     * 拾取 任务
     */
    @Override
    public void claim(String taskId, String userId) {
        //判断，当前用户是否有资格拾取该任务
        TaskQuery query = taskService.createTaskQuery();
        query.taskId(taskId);
        query.taskCandidateUser(userId);

        if(query.singleResult()!=null){
            taskService.claim(taskId, userId);
        }
    }

    /**
     * 提交审核意见 ，要完成两个操作
     *   1、向审核表中，添加一条审核记录
     *   2、让工作流向后推进一步(完成任务)
     */
    @Override
    public void submitAudit(Map<String,Object> m) {

        //生成审核意见 表的id
        String id = UUID.randomUUID().toString();
        m.put("id",id);//存放 id
        m.put("createtime",new Date());//审核时间
        int rs_audit2=Integer.parseInt(m.get("rs_audit").toString());
        m.put("rs_audit", rs_audit2);

        personnelMapper.submitAudit(m);//添加审核记录

        /********获得当前是第几级审核(firstAudit,secondAudit,thirdAudit)***********/
        String auditType=m.get("audit_type").toString();//审核类型

        /*******获得审核状态  1:通过，0：不通过********/
        int rs_audit =Integer.parseInt(m.get("rs_audit").toString());//审核状态
        myTaskMapper.updMessages(rs_audit, m.get("pre_id").toString());
        //创建map，保存流程变量
        Map<String,Object> variables = new HashMap<String, Object>();
        variables.put(auditType,rs_audit); //设置流程变量

        //获得任务id
        String taskId = (String) m.get("taskId");
        taskService.complete(taskId,variables);//完成任务
    }
}
