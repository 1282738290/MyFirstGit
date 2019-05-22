package org.java.gjm.service.impl;

import org.java.gjm.dao.LoginMapper;
import org.java.gjm.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class LoginServiceImpl implements LoginService {

    @Autowired
    private LoginMapper loginMapper;

    @Override
    public Map login(String username) {
        return loginMapper.login(username);
    }

    @Override
    public List<Map> loadMenus(int userId) {
        return loginMapper.loadMenus(userId);
    }

    @Override
    public Map findRoleAndDep(int userId) {
        return loginMapper.findRoleAndDep(userId);
    }

    @Override
    public List<Map> findSubMenus(String mm) {
        return loginMapper.findSubMenus(mm);
    }

    @Override
    public List<String> loadPermissions(int userId) {
        return loginMapper.loadPermissions(userId);
    }

    @Override
    public void upd0(int emp_id) {
        loginMapper.upd0(emp_id);
    }

    @Override
    public void upd1(int emp_id) {
        loginMapper.upd1(emp_id);
    }

    @Override
    public int findCont() {
        return loginMapper.findCont();
    }
}
