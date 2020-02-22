/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interview.teknologi.indonesia.servicesLogicImpl;

import com.interview.teknologi.indonesia.services.servicesMapper;
import com.interview.teknologi.indonesia.servicesLogic.servicesAssigment;
import com.interview.teknologi.indonesia.servicesLogic.servicesProfileGroup;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author arzanka
 */
@Service
public class servicesProfileGroupImpl implements servicesProfileGroup{
    
    @Autowired
    private servicesMapper mapper;

    public servicesProfileGroupImpl(servicesMapper mapper) {
        this.mapper = mapper;
    }

    @Override
    public List getAllListProfileGroup() {
       return mapper.getAllDataProfileGroupMapper();
    }
    
    
}
