package org.java.gjm.service;

import java.util.List;
import java.util.Map;

public interface StaffService {

    List<Map> findAllEmployee(int index,int rows);

    List<Map> findAllMenu(int role_id);

    void updateLocked(int locked,int emp_id);

    Map findByemp_id(int emp_id);

    List<Map> findAllMenuByemp_id(int emp_id);

    List<Map> findAll();

    List<Map> findAllBumen();

    List<Map> findjsByDep_id(int dep_id);

    void updatebmzw(int role_id,int user_id);

    int findcounts();
}
