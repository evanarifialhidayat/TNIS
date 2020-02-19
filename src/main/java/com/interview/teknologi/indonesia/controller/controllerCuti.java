/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interview.teknologi.indonesia.controller;

import com.interview.teknologi.indonesia.model.profile;
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
//    @Autowired
//    private final servicesMapper services;
//       
//    public controllerCuti(servicesMapper services) {
//        this.services = services;
//    }
       
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
        return "profil";
    }
    @RequestMapping("/cuti")
    public String cuti(){
        return "cuti";
    }
    @PostMapping("/addProfile")
    public String foobarPost(@ModelAttribute("command") profile command,Model model ) {
        System.out.println(command.getPassword()+"========haha==========="+command.getName());
        profile prof = new profile();     
        prof.setName(command.getName());
        prof.setPassword(command.getPassword());
        model.addAttribute("command",prof);
         return "profil";
//      return "redirect:/karyawan/profil";
    }
 }
