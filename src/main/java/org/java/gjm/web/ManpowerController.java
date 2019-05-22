package org.java.gjm.web;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.runtime.ProcessInstanceQuery;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.java.gjm.service.MyTaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

@Controller
public class ManpowerController {

    @Autowired
    private RuntimeService runtimeService;
    @Autowired
    private RepositoryService repositoryService;

    @Autowired
    private MyTaskService myTaskService;

    @RequestMapping("end_taskload/{processDefinitionId}")
    public String  end_taskload(@PathVariable("processDefinitionId") String processDefinitionId,Model model){
        List<Map> list = myTaskService.findHistoryInstance(processDefinitionId);
        model.addAttribute("list", list);
        List<Map> list2=myTaskService.findAll();
        if (list2!=null && list2.size()>0){
            model.addAttribute("processDefinitionId",list2.get(0).get("processDefinitionId"));
        }
        return "/gjm/employee/showHistoryTask";
    }

    @RequestMapping("my_taskload")
    public String  my_taskload(Model model){
        Subject subject= SecurityUtils.getSubject();
        Map m= (Map)subject.getPrincipal();
        String name= (String) m.get("name");
        List<Map> list=myTaskService.findAllPreReq(name);
        model.addAttribute("list",list);
        List<Map> list2=myTaskService.findAll();
        if (list2!=null && list2.size()>0){
            model.addAttribute("processDefinitionId",list2.get(0).get("processDefinitionId"));
        }
        return "/gjm/employee/my_task";
    }

    @RequestMapping("per_shenqing")
    public String  per_shenqing(Model model){
        List<Map> list2=myTaskService.findAll();
        if (list2!=null && list2.size()>0){
            model.addAttribute("processDefinitionId",list2.get(0).get("processDefinitionId"));
        }
        return "/gjm/employee/entry_apply";
    }


    @RequestMapping("personnel")
    public  String personnel(@RequestParam Map map){
        Subject subject= SecurityUtils.getSubject();
        Map m= (Map)subject.getPrincipal();
        String name= (String) m.get("name");
        map.put("assges", name);
        myTaskService.addPreReq(map);
        return "redirect:/my_taskload.do";
    }

    @RequestMapping("deleteTask/{taskId}/{processInstanceId}/{pre_id}")
    public String  deleteTask(@PathVariable("taskId") String taskId,@PathVariable("processInstanceId") String processInstanceId,@PathVariable("pre_id") String pre_id){
        myTaskService.deleteMyTask(taskId,processInstanceId,pre_id);
        return "redirect:/my_taskload.do";
    }

    @RequestMapping("updateTask/{pre_id}")
    public String  updateTask(@PathVariable("pre_id") String pre_id,Model model){
       Map pre=myTaskService.findPreReqByPre_id(pre_id);
       model.addAttribute("pre", pre);
        return "/gjm/employee/updateMytask";
    }

    @RequestMapping("/update")
    public String  updateTask(@RequestParam Map map){
        String inv_number = map.get("inv_number").toString();
        map.put("inv_number", Integer.parseInt(inv_number));
        myTaskService.updateMyTask(map);
        return "redirect:/my_taskload.do";
    }

    @RequestMapping("songshenTask/{taskId}/{pre_id}")
    public String  songshenTask(@PathVariable("taskId") String taskId,@PathVariable("pre_id") String pre_id){
        myTaskService.songShen(taskId,pre_id);
        return "redirect:/my_taskload.do";
    }

    //查看图片
    @RequestMapping("showActiveMap/{processInstanceId}")
    public String showActiveMap(@PathVariable("processInstanceId") String processInstanceId,Model model){
        //根据流程实例id（instanceId）得到对应的流程实例
        ProcessInstanceQuery query = runtimeService.createProcessInstanceQuery();
        query.processInstanceId(processInstanceId);//设置要查询的实例id
        ProcessInstance instance = query.singleResult();//得到一个流程实例

        //根据流程部署id，得到该流程实例的流程定义
        String processDefinitionId = instance.getProcessDefinitionId();//得到流程定义id
        //如果要通过流程定义，得到当前流程图的某一个任务节点，需要使用到ProcessDefinition的子类ProcessDefinitionEntity
        ProcessDefinitionEntity processDefinition = (ProcessDefinitionEntity) repositoryService.getProcessDefinition(processDefinitionId);


        //通过实例，获得，当前流程已经执行到哪一个阶段的节点id
        String activityId =instance.getActivityId();
        //通过activtyId从ProcessDefinitionEntity取到某任务的节点
        ActivityImpl act =processDefinition.findActivity(activityId);
        //分别取到当前任务节点的坐标参数:x,y,width,height
        int x=act.getX();
        int y=act.getY();
        int w=act.getWidth();
        int h=act.getHeight();

        model.addAttribute("x", x);
        model.addAttribute("y", y);
        model.addAttribute("width", w);
        model.addAttribute("height", h);

        //得到流程部署id,与png文件的名称
        String deploymentId = processDefinition.getDeploymentId();//部署id
        String png = processDefinition.getDiagramResourceName();//png文件的名称

        //将部署id,png文件的名称，存储在model中
        model.addAttribute("deploymentId", deploymentId);
        model.addAttribute("png",png);

        return "/gjm/employee/showActivitiMap";
    }

    @RequestMapping("showResource/{deploymentId}/{name}")
    public void showResource(@PathVariable("deploymentId") String deploymentId, @PathVariable("name") String name, HttpServletResponse res) throws Exception{

        InputStream in = repositoryService.getResourceAsStream(deploymentId, name);
        OutputStream out = res.getOutputStream();
        byte[] b= new byte[8192];
        int len=0;
        while((len =in.read(b,0,8192))!=-1){
            out.write(b,0, len);
        }
        out.close();
        in.close();
    }

    /**
     * 查询，某一个流程实例，所经历的每一个任务阶段(历史任务)
     * @return
     */
    @RequestMapping("showHistoryTask/{pre_id}")
    public String showHistoryTask(@PathVariable("pre_id") String pre_id,Model model){
        //得到审核意见
        List<Map> list = myTaskService.showHistoryTask(pre_id);
        //得到业务基本信息
        Map map=myTaskService.findAllPreReqByPre_id(pre_id);
        model.addAttribute("list",list);
        model.addAttribute("par",map);
        return "/gjm/employee/audit";
    }

    @RequestMapping("findParticulars/{pre_id}")
    public String  findParticulars(@PathVariable("pre_id") String pre_id,Model model){
        model.addAttribute("par", myTaskService.findAllPreReqByPre_id(pre_id));
        return "/gjm/employee/findParticulars";
    }



}
