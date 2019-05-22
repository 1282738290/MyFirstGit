package org.java.gjm.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class LoginController {

    @RequestMapping("/login")
    public String login(HttpServletRequest req, HttpSession ses){
        int n=0;
        if (ses.getAttribute("n")!=null){
            n= (Integer) ses.getAttribute("n");
        }
        ses.setAttribute("n", n+1);
        String errName="";
        if (req.getAttribute("shiroLoginFailure")!=null){
            errName =(String) req.getAttribute("shiroLoginFailure");
        }
        if (errName==""){
            if (n>0){
                req.setAttribute("msg", "请先登录后访问！");
            }
        }else if (errName.equals("org.apache.shiro.authc.UnknownAccountException")){
            req.setAttribute("msg", "此用户名不存在!");
        }else if(errName.equals("org.apache.shiro.authc.IncorrectCredentialsException")){
            req.setAttribute("msg", "密码输入有误，请重试！");
        }
        //去到登录界面
        return "/login";

    }
}
