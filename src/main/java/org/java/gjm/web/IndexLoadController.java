package org.java.gjm.web;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.java.gjm.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

@Controller
public class IndexLoadController {
    @Autowired
    private LoginService loginService;

    @RequestMapping("indexload")
    public String load(HttpSession ses){
        Subject subject = SecurityUtils.getSubject();
        Map user= (Map) subject.getPrincipal();
        int locked = (int)user.get("locked");
        if (locked==0){
            loginService.upd1((Integer) user.get("emp_id"));
            ses.setAttribute("num", loginService.findCont());
            ses.setAttribute("user",user);
            return  "/index_show";
        }else{
            return "redirect:/logoutexit.do";
        }
    }

    @RequestMapping("logoutexit")
    public String logout(){
        Subject subject = SecurityUtils.getSubject();
        Map user= (Map) subject.getPrincipal();
        loginService.upd0((Integer) user.get("emp_id"));
        return "redirect:/logout.do";
    }

    @RequestMapping("loadcont")
    public void loadcont(HttpServletResponse res) throws IOException {
        PrintWriter out=res.getWriter();
        int n=loginService.findCont();
        out.print(n+"");
        out.close();
    }

}
