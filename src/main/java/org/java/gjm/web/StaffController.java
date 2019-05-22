package org.java.gjm.web;

import com.alibaba.fastjson.JSON;
import org.java.gjm.service.StaffService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

@Controller
public class StaffController {

    @Autowired
    private StaffService staffService;

    int page=1;
    @RequestMapping("staffindex")
    public String staffindex(Model model){
        int rows=10;
        int counts = staffService.findcounts();
        int pages=counts%rows==0?counts/rows:counts/rows+1;
        List<Map> list=staffService.findAllEmployee((page-1)*rows,rows);
        model.addAttribute("list", list);
        model.addAttribute("dep", staffService.findAllBumen());
        model.addAttribute("page", page);
        model.addAttribute("pages", pages);
        model.addAttribute("counts", counts);
        return "/gjm/empmanager/staffindex";
    }

    @RequestMapping("indexload/{page}")
    public String indexload(@PathVariable("page") String page){
        if (page!=null){
            this.page=Integer.parseInt(page);
        }
        return "redirect:/staffindex.do";
    }



    @RequestMapping("updateLocked")
    public void updateLocked(HttpServletRequest req) {
        int locked=Integer.parseInt(req.getParameter("str"));
        int emp_id=Integer.parseInt(req.getParameter("emp"));
        staffService.updateLocked(locked,emp_id);
    }

    @RequestMapping("findxiangqing/{emp_id}")
    public String findxiangqing(@PathVariable("emp_id") String emp_id, Model model){
        int emp=Integer.parseInt(emp_id);
        Map map=staffService.findByemp_id(emp);
        model.addAttribute("map", map);
        model.addAttribute("emp_id", emp_id);
        model.addAttribute("dep", staffService.findAllBumen());
        return "/gjm/empmanager/findxiangqing";
    }

    @RequestMapping("jurisload/{emp_id}")
    public String jurisload(@PathVariable("emp_id") String emp_id,Model model){
        int emp=Integer.parseInt(emp_id);
        List<Map> list = staffService.findAllMenuByemp_id(emp);
        model.addAttribute("list", list);
        List<Map> listall = staffService.findAll();
        model.addAttribute("listall", listall);
        model.addAttribute("emp_id", emp_id);
        model.addAttribute("dep", staffService.findAllBumen());
        return "/gjm/empmanager/juris";
    }

    @RequestMapping("ajaxloadzhiwu")
    public void ajaxloadzhiwu(HttpServletResponse res,HttpServletRequest req) throws IOException {
        res.setCharacterEncoding("utf-8");
        PrintWriter out=res.getWriter();
        int n=Integer.parseInt(req.getParameter("depid"));
        out.print(JSON.toJSONString(staffService.findjsByDep_id(n)));
        out.close();
    }

    @RequestMapping("tijiao")
    public String tijiao(String empid,String zhiwu){
        staffService.updatebmzw(Integer.parseInt(zhiwu),Integer.parseInt(empid));
        return "redirect:/staffindex.do";
    }

}
