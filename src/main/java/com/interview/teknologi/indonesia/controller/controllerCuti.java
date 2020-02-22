/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interview.teknologi.indonesia.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.interview.teknologi.indonesia.model.profile;
import com.interview.teknologi.indonesia.model.tblassignment;
import com.interview.teknologi.indonesia.services.servicesMapper;
import com.interview.teknologi.indonesia.servicesLogic.servicesAssigment;
import com.interview.teknologi.indonesia.servicesLogic.servicesModule;
import com.interview.teknologi.indonesia.servicesLogic.servicesProfileGroup;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author arzanka
 */
@Controller
@EnableAutoConfiguration
@RequestMapping(value = "/karyawan")
public class controllerCuti {
    @Autowired
    private servicesAssigment assigment;
    
    @Autowired
    private servicesProfileGroup profileGroup;
    
    @Autowired
    private servicesModule module;
    
    @Autowired
    private servicesMapper mapper;

    public controllerCuti(servicesAssigment assigment,servicesMapper mapper,
            servicesProfileGroup profileGroup,servicesModule module) {
        this.assigment = assigment;
        this.mapper = mapper;
        this.profileGroup = profileGroup;
        this.module = module;
    }
    
    
       
    @RequestMapping("/index")
    public String index(){
        return "index";
    }
    
    @RequestMapping("/dasboard")
    public String dasboard(){
        return "dasboard";
    }
    
    @RequestMapping("/profil")
    public String profil(Model model){     
        profile prof = new profile(); 
        model.addAttribute("command",prof);
        model.addAttribute("listallprofilegroup",mapper.getAllDataProfileGroupDroupDown());
        model.addAttribute("listall",mapper.getAllDataProfile());
        return "profil";
    }
    @RequestMapping("/cuti")
    public String cuti(){
        return "cuti";
    }
    @RequestMapping("/assignment")
    public String assignment(Model model){
        model.addAttribute("listall",assigment.getAllListAssignment());
        return "assignment";
    }
    @RequestMapping("/profilgroup")
    public String profilgroup(Model model){
        model.addAttribute("listall",profileGroup.getAllListProfileGroup());
        return "profilgroup";
    }
    @RequestMapping("/module")
    public String module(Model model){
        model.addAttribute("listall",module.getAllListModule());
        return "module";
    }
    @PostMapping("/addProfile")
    public String foobarPost(@ModelAttribute("command") profile command,Model model ) {
        profile prof = new profile();     
        prof.setName(command.getName());
        prof.setPassword(command.getPassword());
        prof.setGroupid(command.getGroupid());
        model.addAttribute("command",prof);
        if(prof != null)
            if(prof.getName()!=null)
                model.addAttribute("validasiedit","edit");        
        model.addAttribute("listallprofilegroup",mapper.getAllDataProfileGroupDroupDown());     
        String profileJson ="{ \"data\" : [{\"schema\" : \"tnis\", \"groupid\" : \""+prof.getGroupid()+"\",\"name\" : \""+prof.getName()+"\",\"password\": \""+prof.getPassword()+"\"}]}";
        prof.setValuedata(profileJson);
        
        mapper.insertDataProfil(prof);
        
         return "profil";
//      return "redirect:/karyawan/profil";
    }
 }
