package org.java.gjm.service;


import java.util.List;
import java.util.Map;

public interface LoginService {

   // Map findUserByUsername(String username);

    Map login(String username);

    List<Map> loadMenus(int userId);

    Map findRoleAndDep(int userId);

    List<Map> findSubMenus(String mm);

    List<String> loadPermissions(int userId);

    void upd0(int emp_id);
    void upd1(int emp_id);
    int findCont();
}
