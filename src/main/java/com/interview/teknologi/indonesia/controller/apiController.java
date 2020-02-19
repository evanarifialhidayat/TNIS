/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interview.teknologi.indonesia.controller;

import com.interview.teknologi.indonesia.dao.servicesDao;
import java.util.HashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import com.interview.teknologi.indonesia.services.servicesMapper;
import org.springframework.web.servlet.View;
/**
 *
 * @author arzanka
 */
@RestController
@RequestMapping(path = "/karyawan/api")
public class apiController {
    @Autowired
    private final servicesMapper services; //mapper mybatis
    @Autowired
    private final servicesDao servicesdao; //services dao

    public apiController(servicesMapper services, servicesDao servicesdao) {
        this.services = services;
        this.servicesdao = servicesdao;
    }
   
    @RequestMapping(value="/allprofile", method=RequestMethod.GET)
    public ResponseEntity<?> getUserListAll(){
        HashMap<String, Object> result = new HashMap<>();
        result.put("profile", servicesdao.getUserList());
        return new ResponseEntity<>(result, HttpStatus.OK);
    }
    
    
}
