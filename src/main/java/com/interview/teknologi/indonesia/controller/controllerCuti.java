/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interview.teknologi.indonesia.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.interview.teknologi.indonesia.model.cuti;
import com.interview.teknologi.indonesia.model.profile;
import com.interview.teknologi.indonesia.model.tblassignment;
import com.interview.teknologi.indonesia.services.servicesMapper;
import com.interview.teknologi.indonesia.servicesLogic.servicesAssigment;
import com.interview.teknologi.indonesia.servicesLogic.servicesModule;
import com.interview.teknologi.indonesia.servicesLogic.servicesProfileGroup;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/** tes leptop baru TNIS
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
    
    @RequestMapping("/logout")
    public String logout(HttpServletRequest request){
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
         return "index";
    }
    
    @RequestMapping("/dasboard")
    public String dasboard(@ModelAttribute("command") profile command, Model model ,HttpSession session,HttpServletRequest request){
        profile prof = new profile();
        prof.setName(command.getName());
        prof.setPassword(command.getPassword());
        model.addAttribute("command",prof);
        profile data = mapper.getDataLogin(prof);
        if(data == null)
             return "index";
        else{
            if(data.getTnisvalidasi() == 1){
                request.getSession().setAttribute("loginsuper", "loginsuper");
                request.getSession().setAttribute("userid", data.getUserid());
            }else{
                request.getSession().setAttribute("loginsuper", "user");
                request.getSession().setAttribute("userid", data.getUserid());
            }
            model.addAttribute("user",session.getAttribute("loginsuper"));
             return "dasboard";
        }
    }
    
    @RequestMapping("/assignment")
    public String assignment(Model model,HttpSession session){
        model.addAttribute("listall",assigment.getAllListAssignment());
         model.addAttribute("user",session.getAttribute("loginsuper"));
        return "assignment";
    }
    @RequestMapping("/profilgroup")
    public String profilgroup(Model model,HttpSession session){
        model.addAttribute("listall",profileGroup.getAllListProfileGroup());
         model.addAttribute("user",session.getAttribute("loginsuper"));
        return "profilgroup";
    }
    @RequestMapping("/module")
    public String module(Model model,HttpSession session){
        model.addAttribute("listall",module.getAllListModule());
         model.addAttribute("user",session.getAttribute("loginsuper"));
        return "module";
    }
    
    @RequestMapping("/profil")
    public String profil(Model model,HttpSession session){     
        profile prof = new profile(); 
        model.addAttribute("user",session.getAttribute("loginsuper"));
        model.addAttribute("command",prof);
        if("loginsuper".equals(session.getAttribute("loginsuper").toString())){
            model.addAttribute("listallprofilegroup",mapper.getAllDataProfileGroupDroupDown());  
            model.addAttribute("listall",mapper.getAllDataProfile());
        }else{
            int userid = Integer.parseInt(""+session.getAttribute("userid"));
            model.addAttribute("listall",mapper.getAllDataProfileUserid(userid));  
        }
        return "profil";
    }
    @PostMapping("/addProfile")
    public String foobarPost(@ModelAttribute("command") profile command,Model model ,HttpSession session) {
        profile prof = new profile();     
        prof.setName(command.getName());
        prof.setPassword(command.getPassword());
        prof.setGroupid(command.getGroupid());
        model.addAttribute("command",prof);
        if(prof != null)
            if(prof.getName()!=null)
                model.addAttribute("validasiedit","edit");        
         
        String profileJson ="{ \"data\" : [{\"validasi\" : \"new\", \"groupid\" : \""+prof.getGroupid()+"\",\"name\" : \""+prof.getName()+"\",\"password\": \""+prof.getPassword()+"\"}]}";
        prof.setValuedata(profileJson);
        
        mapper.insertDataProfil(prof);
         model.addAttribute("user",session.getAttribute("loginsuper"));
         
         if("loginsuper".equals(session.getAttribute("loginsuper").toString())){
            model.addAttribute("listallprofilegroup",mapper.getAllDataProfileGroupDroupDown());     
            model.addAttribute("listall",mapper.getAllDataProfile());
        }else{
            int userid = Integer.parseInt(""+session.getAttribute("userid"));
            model.addAttribute("listall",mapper.getAllDataProfileUserid(userid));  
        }
         
         return "profil";
//      return "redirect:/karyawan/profil";
    }
    
     @PostMapping("/editProfileProcess")
    public String editProfileProcess(@ModelAttribute("command") profile command,Model model ,HttpSession session) {
        profile prof = new profile();     
        prof.setName(command.getName());
        prof.setPassword(command.getPassword());
        prof.setGroupid(command.getGroupid());
        model.addAttribute("command",prof);
        if(prof != null)
            if(prof.getName()!=null)
                model.addAttribute("validasiedit","edit");        
        long userid = Integer.parseInt(""+session.getAttribute("userid"));
        String profileJson ="{ \"data\" : [{\"validasi\" : \"edit\", \"groupid\" : \""+prof.getGroupid()+"\",\"name\" : \""+prof.getName()+"\",\"password\": \""+prof.getPassword()+"\",\"userid\": \""+userid+"\"}]}";
        prof.setValuedata(profileJson);
        
        mapper.insertDataProfil(prof);
         model.addAttribute("user",session.getAttribute("loginsuper"));
         
         if("loginsuper".equals(session.getAttribute("loginsuper").toString())){
            model.addAttribute("listallprofilegroup",mapper.getAllDataProfileGroupDroupDown());     
            model.addAttribute("listall",mapper.getAllDataProfile());
        }else{
            model.addAttribute("listall",mapper.getAllDataProfileUserid(userid));  
        }
         
         return "profil";
//      return "redirect:/karyawan/profil";
    }
    
    @GetMapping("/editProfile")
    public String editCuti( Model model,HttpSession session) {
       long userid = Integer.parseInt(""+session.getAttribute("userid"));
       profile profparam = new profile();
       profparam.setUserid(userid);
        profile prof = mapper.editDataProfil(profparam);
        model.addAttribute("command",prof);
         model.addAttribute("user",session.getAttribute("loginsuper"));
          model.addAttribute("listallprofilegroup",mapper.getAllDataProfileGroupDroupDown());     
    return "editProfile";
    }
    
    @RequestMapping("/cuti")
    public String cuti(Model model,HttpSession session){
        cuti cut = new cuti(); 
        model.addAttribute("command",cut);
        
         model.addAttribute("user",session.getAttribute("loginsuper"));
          if("loginsuper".equals(session.getAttribute("loginsuper").toString())){
              model.addAttribute("listall",mapper.getAllDataCuti());
          }else{
               int userid = Integer.parseInt(""+session.getAttribute("userid"));
              model.addAttribute("listall",mapper.getAllDataCutiUserId(userid));
          }
        return "cuti";
    }
    @PostMapping("/addCuti")
    public String addCuti(@ModelAttribute("command") cuti command,Model model ,HttpSession session) {
        cuti cut = new cuti();     
        cut.setKeperluan(command.getKeperluan());
        cut.setDatefrom(command.getDatefrom());
        cut.setDateto(command.getDateto());
        cut.setDescription(command.getDescription());
        cut.setStatus(command.getStatus());
         int userid = Integer.parseInt(""+session.getAttribute("userid"));
        model.addAttribute("command",cut);
        if(cut != null)
           model.addAttribute("validasiedit","edit");        
        model.addAttribute("listallprofilegroup",mapper.getAllDataProfileGroupDroupDown());     
        String profileJson ="{ \"data\" : [{\"validasi\" : \"new\", \"keperluan\" : \""+cut.getKeperluan()+"\",\"datefrom\" : \""+cut.getDatefrom()+"\",\"dateto\": \""+cut.getDateto()+"\",\"description\": \""+cut.getDescription()+"\",\"status\":\""+cut.getStatus()+"\",\"userid\":\""+userid+"\"}]}";
        cut.setValuedata(profileJson);
        
        mapper.insertDataCuti(cut);
         model.addAttribute("user",session.getAttribute("loginsuper"));
         return "cuti";
    }
    @GetMapping("/editCuti/{cutiid}")
    public String editCuti(@PathVariable("cutiid") long cutiid, Model model,HttpSession session) {
        cuti cut = mapper.editDataCuti(cutiid);
        model.addAttribute("command",cut);
         model.addAttribute("user",session.getAttribute("loginsuper"));
    return "editCuti";
    }
     @GetMapping("/deletedCuti/{cutiid}")
    public String deletedCuti(@PathVariable("cutiid") long cutiid, Model model,HttpSession session) {
        mapper.deletedDataCuti(cutiid);
         model.addAttribute("user",session.getAttribute("loginsuper"));
    return "redirect:/karyawan/cuti";
    }
    @PostMapping("/addCutiProcess")
    public String addCutiProcess(@ModelAttribute("command") cuti command,Model model,HttpSession session ) {
        cuti cut = new cuti();     
        cut.setKeperluan(command.getKeperluan());
        cut.setDatefrom(command.getDatefrom());
        cut.setDateto(command.getDateto());
        cut.setDescription(command.getDescription());
        cut.setStatus(command.getStatus());
        cut.setCutiid(command.getCutiid());
        int userid = Integer.parseInt(""+session.getAttribute("userid"));
        model.addAttribute("command",cut);
        if(cut != null)
           model.addAttribute("validasiedit","edit");        
        model.addAttribute("listallprofilegroup",mapper.getAllDataProfileGroupDroupDown());     
        String profileJson ="{ \"data\" : [{\"validasi\" : \"new\", \"keperluan\" : \""+cut.getKeperluan()+"\",\"datefrom\" : \""+cut.getDatefrom()+"\",\"dateto\": \""+cut.getDateto()+"\",\"description\": \""+cut.getDescription()+"\",\"status\":\""+cut.getStatus()+"\",\"cutiid\": \""+cut.getCutiid()+"\",\"userid\":\""+userid+"\"}]}";
        cut.setValuedata(profileJson);
        
        mapper.insertDataCuti(cut);
         model.addAttribute("user",session.getAttribute("loginsuper"));
         return "editCuti";
    }
 }
