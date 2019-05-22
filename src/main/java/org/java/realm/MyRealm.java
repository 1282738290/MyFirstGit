package org.java.realm;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.java.gjm.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

public class MyRealm extends AuthorizingRealm {

    @Autowired
    private LoginService loginService;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {

        //获得用户凭证--也就是认证时的第一个参数 map
        Map principal = (Map) principalCollection.getPrimaryPrincipal();

        //得当前用户的id，加载该userId，拥有的访问权限
        int userId = (int) principal.get("emp_id");

        //根据userid到数据库中，加载权限
        List<String> list = loginService.loadPermissions(userId);

        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        //添加访问权限
        info.addStringPermissions(list);
        return info;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        //取得用户凭证（用户名 ）
        String username = authenticationToken.getPrincipal().toString();

        Map user=loginService.login(username);
        //根据用户名到数据库中，判断，用户名是否存在
        if(user==null){
            return null;//用户名不存在，会抛出异常UnknownAccountException
        }
        //取得用户的id，根据用户的id，加载该用户可以访问的所有菜单
        int userId = (int) user.get("emp_id");
        //得到当前用户对应的菜单
        List<Map> menus = loginService.loadMenus(userId);
        for(Map map:menus){
            String mname= (String) map.get("percode");
            String mm=mname.substring(0,mname.indexOf(":"));
            List<Map> subMenus = loginService.findSubMenus(mm + "%");
            map.put("subMenus", subMenus);
        }
        //把该用户可以访问的菜单，也存放到user(集合)中
        user.put("menus",menus );
        //得到当前用户对应的角色和部门信息
        Map dep = loginService.findRoleAndDep(userId);
        //把该角色和部门信息也存放到user(集合)中
        user.put("dep",dep);
        //用户存在，得到该用户的正确密码
        String pwd = (String) user.get("emp_pwd");
        //加盐
        String salf="accp";
        //返回一个AuthenticationInfo，将用户凭证，以及该用户名的正常密码，封装，并且返回,交给securityManager判断，用户输入的密码是否正常
        SimpleAuthenticationInfo info=new SimpleAuthenticationInfo(user,pwd, ByteSource.Util.bytes(salf), "myrealm");
        //如果密码不正确，就会进入loginController
        return info;
    }
}
