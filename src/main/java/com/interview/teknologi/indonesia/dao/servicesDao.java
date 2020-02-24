/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interview.teknologi.indonesia.dao;

import com.interview.teknologi.indonesia.model.cuti;
import com.interview.teknologi.indonesia.model.profile;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.interview.teknologi.indonesia.services.servicesMapper;

/**
 *
 * @author arzanka
 */
@Service
@Transactional
public class servicesDao{
    @Autowired
    private final servicesMapper mapperservices;

    public servicesDao(servicesMapper mapperservices) {
        this.mapperservices = mapperservices;
    }

    
    
    public List<profile> getUserList() {
        List<profile> userList = mapperservices.getAllDataProfile();
        
       

//        for (user us : useryList){
//            user user = new user();
//            user.setName(us.getName());
//        }
        if(userList.size() > 0)
                    return userList;
        else{
                    profile profile = new profile();
                    userList = new ArrayList();
                    userList.add(profile);
                    return userList;
        }
    }
    
     public List<cuti> getCutiListNow() {
        List<cuti> cutiList = mapperservices.getAllDataCutiDefaultNow();
        if(cutiList.size() > 0)
                    return cutiList;
        else{
                    cuti cut = new cuti();
                    cutiList = new ArrayList();
                    cutiList.add(cut);
                    return cutiList;
        }
    }
     
       public List<cuti> getCutiListFilter(long cutiid) {
        List<cuti> cutiList = mapperservices.getAllDataCutiDefaultFilter(cutiid);
        if(cutiList.size() > 0)
                    return cutiList;
        else{
                    cuti cut = new cuti();
                    cutiList = new ArrayList();
                    cutiList.add(cut);
                    return cutiList;
        }
    }
    
}
