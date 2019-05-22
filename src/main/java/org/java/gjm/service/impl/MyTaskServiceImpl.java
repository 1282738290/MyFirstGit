package org.java.gjm.service.impl;

import org.activiti.engine.*;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.history.HistoricTaskInstanceQuery;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.runtime.ProcessInstanceQuery;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.java.gjm.dao.MyTaskMapper;
import org.java.gjm.service.MyTaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.InputStream;
import java.util.*;

@Service
public class MyTaskServiceImpl implements MyTaskService {

    @Autowired
    private MyTaskMapper myTaskMapper;
    @Autowired
    private RepositoryService repositoryService;
    @Autowired
    private RuntimeService runtimeService;
    @Autowired
    private IdentityService identityService;
    @Autowired
    private TaskService taskService;
    @Autowired
    private HistoryService historyService;

    @Override
    public List<Map> findAll() {
        return myTaskMapper.findAll();
    }

    @Transactional
    @Override
    public void addPreReq(Map map) {
        //启动流程实例
        String uuid = UUID.randomUUID().toString();
        String userid = map.get("assges").toString();
        identityService.setAuthenticatedUserId(userid);
        ProcessInstance instance = runtimeService.startProcessInstanceByKey("pre_shenqing", uuid);
        // 在service中，需要向map中，添加:id,createtime,processInstance_id
        map.put("pre_id", uuid);
        map.put("createtime", new Date());
        map.put("processInstanceId", instance.getProcessInstanceId());
        map.put("processDefinitionId", instance.getProcessDefinitionId());
        myTaskMapper.addMessages(uuid);
        myTaskMapper.addPreReq(map);
    }

    @Override
    public List<Map> findAllPreReq(String user) {
        //创建任务查询接口
        TaskQuery query = taskService.createTaskQuery();

        //指定查询哪一个用户的任务
        query.taskAssignee(user);

        //查询，得到所有的任务
        List<Task> tasklist = query.list();

        List<HistoricTaskInstance>  historylist= historyService.createHistoricTaskInstanceQuery().list();

        //返回的集合中，不仅要包含工作流的信息，还要包含对应的业务数据
        List<Map> list = new ArrayList<Map>();

        //对每一个任务循环迭代，分别取得每一个任务，对应的业务数据，存储在集合中
        for (Task t : tasklist) {
            //根据任务，得到该任务的流程实例id
            String processInstanceId = t.getProcessInstanceId();
            //获得该流程实例，对应的业务数据
            Map<String, Object> m = myTaskMapper.findAllPreReq(processInstanceId);
            //把该业务数据，对应的工作流的信息，也封装到map中
            m.put("taskId", t.getId());//任务id
            m.put("taskName", t.getName());//任务名称
            m.put("assignee", t.getAssignee());//任务办理人
            m.put("createtime", t.getCreateTime());//任务的开始时间
            m.put("taskDefKey", t.getTaskDefinitionKey());//每一个任务对应的id的名称
            Map sta=myTaskMapper.findMessages( m.get("pre_id").toString());
            m.put("sta",Integer.parseInt(sta.get("status").toString()));
            list.add(m);
        }

       // 指定要存储数据库中的bpmn文件与png文件名称
       /* String bpmn = "Pre_shenqing.bpmn";
        String png = "Pre_shenqing.png";

        // 用输入流，读取这两个文件
        InputStream bpmn_in = this.getClass().getClassLoader()
                .getResourceAsStream("diagrams/" + bpmn);
        InputStream png_in = this.getClass().getClassLoader()
                .getResourceAsStream("diagrams/" + png);

        // alt+shift+l
        // 通过RepositoryService创建deployment对象，用于部署流程定义到数据库
        Deployment deploy = repositoryService.createDeployment()
                .name("人员申请")
                .addInputStream(bpmn, bpmn_in).addInputStream(png, png_in)
                .deploy();

        System.out.println("流程定义部署成功!");
        System.out.println("流程定义的ID是:" + deploy.getId());
        System.out.println("部署时间:" + deploy.getDeploymentTime());*/
        return list;
    }

    @Override
    public void deleteMyTask(String taskId,String processInstanceId, String pre_id) {
       // taskService.deleteTask(taskId,true);
        // 删除流程实例
        runtimeService.deleteProcessInstance(processInstanceId, "删除任务---");

        historyService.deleteHistoricTaskInstance(taskId);
        //删除业务数据
        myTaskMapper.deleteMyTask(pre_id);
    }

    @Override
    public Map findPreReqByPre_id(String pre_id) {
        return myTaskMapper.findPreReqByPre_id(pre_id);
    }

    @Override
    public void updateMyTask(Map map) {
        myTaskMapper.updateMyTask(map);
    }

    @Override
    public void songShen(String taskId,String pre_id) {
        myTaskMapper.updateMessages(pre_id);
        //送审，提交任务
        taskService.complete(taskId);
    }

    @Override
    public List<Map> showHistoryTask(String pre_id) {
        //查询审核意见信息
        return myTaskMapper.findAudit(pre_id);
    }

    @Override
    public Map findAllPreReqByPre_id(String pre_req) {
        return myTaskMapper.findPreReqByPre_id(pre_req);
    }

    //查询审核完成的流程实例
    @Override
    public List<Map> findHistoryInstance(String processDefinitionId){
        List<HistoricProcessInstance> list = historyService.createHistoricProcessInstanceQuery()
                                                           .processDefinitionId(processDefinitionId).list();
        //返回的集合中，不仅要包含工作流的信息，还要包含对应的业务数据
        List<Map> listall = new ArrayList<Map>();

        //对每一个任务循环迭代，分别取得每一个任务，对应的业务数据，存储在集合中
        for (HistoricProcessInstance t : list) {
            //根据任务，得到该任务的流程实例id
            String businessKey = t.getBusinessKey();
            //获得该流程实例，对应的业务数据
            Map<String, Object> m = myTaskMapper.findPreReqByPre_id(businessKey);
            m.put("endtime2", t.getEndTime());
            m.put("starttime2", t.getStartTime());
            m.put("deleteReason", t.getDeleteReason());
            m.put("activityId", t.getStartActivityId());
            listall.add(m);
        }
        return  listall;
    }
}
