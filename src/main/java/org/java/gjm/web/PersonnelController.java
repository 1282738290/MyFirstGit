package org.java.gjm.web;

import org.activiti.engine.IdentityService;
import org.activiti.engine.TaskService;
import org.activiti.engine.impl.persistence.entity.GroupEntity;
import org.activiti.engine.impl.persistence.entity.UserEntity;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.java.gjm.service.MyTaskService;
import org.java.gjm.service.PersonnelService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class PersonnelController {

    @Autowired
    private PersonnelService personnelService;

    @Autowired
    private MyTaskService myTaskService;

    @Autowired
    private IdentityService identityService;

    @Autowired
    private TaskService taskService;

    /**
     * 查询个人待办任务
     * @return
     */
    @RequestMapping("showPersonTask")
    public String showPersonTask(Model model){
        Subject subject= SecurityUtils.getSubject();
        Map m= (Map)subject.getPrincipal();
        String name= (String) m.get("emp_user");
        List<Map> list=myTaskService.findAllPreReq(name);
        model.addAttribute("list",list);
        return "/gjm/personnel/pre_index";
    }

    @RequestMapping("task_picking")
    public String  task_picking(Model model){
        Subject subject= SecurityUtils.getSubject();
        Map m= (Map)subject.getPrincipal();
        String userId= (String) m.get("emp_user");
        //获得组任务
        List<Map> list = personnelService.showGroupTask(userId);
        model.addAttribute("list",list);
        return "/gjm/personnel/pickingtask";
    }

    /**
     * 拾取任务
     * @return
     */
    @RequestMapping("claim/{taskId}")
    public String claim(@PathVariable("taskId") String taskId){
        Subject subject= SecurityUtils.getSubject();
        Map m= (Map)subject.getPrincipal();
        String userId= (String) m.get("emp_user");
        personnelService.claim(taskId, userId);
        return "redirect:/task_picking.do";
    }

    /**
     * 任务退回
     * @return
     */
    @RequestMapping("tasksend/{taskId}")
    public String tasksend(@PathVariable("taskId") String taskId){
        taskService.claim(taskId, null);
        return "redirect:/showPersonTask.do";

    }

    /**
     * 审核之前，显示审核的采购单详情
     * @param taskId 任务id
     *  orderId:采购单id
     *  taskDefKey:当前是 哪一个阶段 的审核
     * @return
     */
    @RequestMapping("audit/{taskId}/{pre_id}/{taskDefKey}")
    public String showOrderDetail(Model model,@PathVariable("taskId") String taskId,@PathVariable("pre_id") String pre_id,@PathVariable("taskDefKey") String taskDefKey){

        //把这个三参数，保存在model
        model.addAttribute("taskId",taskId);
        model.addAttribute("pre_id",pre_id);
        model.addAttribute("taskDefKey",taskDefKey);//标识 哪一个阶段 审核

        //根据采购单的id，找到该采购单的详细业务数据，显示在页面，方便工作人员审核
        Map<String,Object> map = myTaskService.findAllPreReqByPre_id(pre_id);

        model.addAttribute("par", map);//存储该采购单详情

        return "/gjm/personnel/showOrderDetail";

    }

    /**
     * 提交审核意见
     * @return
     */
    @RequestMapping("submitAudit")
    public String submitAudit(@RequestParam Map<String,Object> m, HttpSession ses){
        Subject subject= SecurityUtils.getSubject();
        Map mc= (Map)subject.getPrincipal();
        String user= (String) mc.get("name");
        Map m2= (Map) mc.get("dep");
        m.put("user",user);//把审核人存放到map中
        m.put("dep_name", m2.get("dep_name").toString());
        personnelService.submitAudit(m);
        return "redirect:/showPersonTask.do";
    }

    @RequestMapping("loading")
    public void addCandidateGroup(){

        List<String> list=new ArrayList<>();
        list.add("xufen");
        list.add("zengjie");
        list.add("andy");

        List<String> list2=new ArrayList<>();
        list2.add("徐芬");
        list2.add("曾杰");
        list2.add("安迪");

        List<String> list3=new ArrayList<>();
        list3.add("行政部");
        list3.add("财务部");
        list3.add("后勤部");

        for (int i=0;i<list.size();i++) {
            //添加用户
            String userId = list.get(i);//用户id
            if (identityService.createUserQuery().userId(userId).singleResult() == null) {
                //用户id不存在
                //创建一个新的用户
                UserEntity user = new UserEntity();

                user.setId(userId);//设置用户id
                user.setFirstName(list2.get(i));//用户名称
                identityService.saveUser(user);//把用户信息添加到用户表
            }
            //添加组
            String groupId=i+3+"";//部门编号
            if(identityService.createGroupQuery().groupId(groupId).singleResult()==null){
                //组不存在
                GroupEntity group = new GroupEntity();

                group.setId(groupId);//设置组的编号
                group.setName(list3.get(i));//设置组的名称

                identityService.saveGroup(group);//把组信息，添加到候选组表中
            }
            //配置员工与组的关系
            identityService.deleteMembership(userId, groupId);//如果已存在关联，删除关联
            identityService.createMembership(userId, groupId);//创建关联

        }






        //添加用户
        String userId2="maguo";//用户id
        if(identityService.createUserQuery().userId(userId2).singleResult()==null){
            //用户id不存在
            //创建一个新的用户
            UserEntity user = new UserEntity();

            user.setId(userId2);//设置用户id
            user.setFirstName("马果");//用户名称

            identityService.saveUser(user);//把用户信息添加到用户表
        }

        //添加组
        String groupId2="2";//部门编号
        if(identityService.createGroupQuery().groupId(groupId2).singleResult()==null){
            //组不存在
            GroupEntity group = new GroupEntity();

            group.setId(groupId2);//设置组的编号
            group.setName("人事部");//设置组的名称

            identityService.saveGroup(group);//把组信息，添加到候选组表中
        }
        //配置员工与组的关系
        identityService.deleteMembership(userId2, groupId2);//如果已存在关联，删除关联
        identityService.createMembership(userId2, groupId2);//创建关联




        //添加用户
        String userId3="admin";//用户id
        if(identityService.createUserQuery().userId(userId3).singleResult()==null){
            //用户id不存在
            //创建一个新的用户
            UserEntity user = new UserEntity();

            user.setId(userId3);//设置用户id
            user.setFirstName("菜徐坤");//用户名称

            identityService.saveUser(user);//把用户信息添加到用户表
        }

        //添加组
        String groupId3="1";//部门编号
        if(identityService.createGroupQuery().groupId(groupId3).singleResult()==null){
            //组不存在
            GroupEntity group = new GroupEntity();

            group.setId(groupId3);//设置组的编号
            group.setName("总经办");//设置组的名称

            identityService.saveGroup(group);//把组信息，添加到候选组表中
        }
        //配置员工与组的关系
        identityService.deleteMembership(userId3, groupId3);//如果已存在关联，删除关联
        identityService.createMembership(userId3, groupId3);//创建关联

        System.out.println("关联已配置");
    }

}
