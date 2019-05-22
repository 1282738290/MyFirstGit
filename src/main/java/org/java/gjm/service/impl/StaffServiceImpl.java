package org.java.gjm.service.impl;

import org.java.gjm.dao.LoginMapper;
import org.java.gjm.dao.StaffMapper;
import org.java.gjm.service.StaffService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class StaffServiceImpl implements StaffService {

    @Autowired
    private StaffMapper staffMapper;

    @Autowired
    private LoginMapper loginMapper;

    @Override
    public List<Map> findAllEmployee(int index,int rows) {
        return staffMapper.findAllEmployee(index,rows);
    }

    @Override
    public List<Map> findAllMenu(int role_id) {
        return staffMapper.findAllMenu(role_id);
    }

    @Override
    public void updateLocked(int locked,int emp_id) {
        staffMapper.updateLocked(locked,emp_id);
    }

    @Override
    public Map findByemp_id(int emp_id) {
        return staffMapper.findByemp_id(emp_id);
    }

    List<Integer> aa=null;
    @Override
    public List<Map> findAllMenuByemp_id(int emp_id){
        aa=new ArrayList<>();
        List<Map> menus=loginMapper.loadMenus(emp_id);
        for(Map map:menus){
            aa.add((Integer)map.get("id"));
            String mname= (String) map.get("percode");
            String mm=mname.substring(0,mname.indexOf(":"));
            List<Map> subMenus = loginMapper.findSubMenus(mm + "%");
            for(Map m1 :subMenus){
                aa.add((Integer)m1.get("id"));
            }
            map.put("subMenus", subMenus);
        }
        return menus;
    }

    @Override
    public List<Map> findAll() {
        List<Map> menus=staffMapper.findAll();
        for(Map map:menus){
            if(aa.contains(map.get("id"))){
                map.put("sta", 0);
            }else{
                map.put("sta", 1);
            }
            String mname= (String) map.get("percode");
            String mm=mname.substring(0,mname.indexOf(":"));
            List<Map> subMenus = loginMapper.findSubMenus(mm + "%");
            for(Map map2:subMenus){
                if(aa.contains(map2.get("id"))){
                    map2.put("subs", 0);
                }else{
                    map2.put("subs", 1);
                }
            }
            map.put("sMenus", subMenus);
        }
        return menus;
    }

    @Override
    public List<Map> findAllBumen() {
        return staffMapper.findAllBumen();
    }

    @Override
    public List<Map> findjsByDep_id(int dep_id) {
        return staffMapper.findjsByDep_id(dep_id);
    }

    @Override
    public void updatebmzw(int role_id, int user_id) {
        staffMapper.updatebmzw(role_id, user_id);
    }

    @Override
    public int findcounts() {
        return staffMapper.findcounts();
    }
}
