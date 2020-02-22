/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interview.teknologi.indonesia.servicesLogicImpl;

import com.interview.teknologi.indonesia.services.servicesMapper;
import com.interview.teknologi.indonesia.servicesLogic.servicesAssigment;
import com.interview.teknologi.indonesia.servicesLogic.servicesModule;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author arzanka
 */
@Service
public class servicesModuleImpl implements servicesModule{
    
    @Autowired
    private servicesMapper mapper;

    public servicesModuleImpl(servicesMapper mapper) {
        this.mapper = mapper;
    }

    @Override
    public List getAllListModule() {
        return mapper.getAllDataModuleMapper();
    }
    
    
    
}
