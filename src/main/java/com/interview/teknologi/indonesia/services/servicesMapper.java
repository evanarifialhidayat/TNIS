/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interview.teknologi.indonesia.services;

import com.interview.teknologi.indonesia.model.profile;
import com.interview.teknologi.indonesia.model.tblassignment;
import com.interview.teknologi.indonesia.model.tblgroup;
import com.interview.teknologi.indonesia.model.tblmodule;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

/**
 *
 * @author arzanka
 */
@Mapper
public interface servicesMapper {    
    @Select("SELECT b.userid, "
            + "(select a.name from tblgroup a where a.groupid = b.groupid limit 1) as namegroupid,"
            + " b.name, b.password, b.profileno  FROM profile b")
    public List<profile> getAllDataProfile();
    
    @Select("SELECT * FROM tblassignment")
    public List<tblassignment> getAllDataAssigmentMapper();    
    
     @Select("SELECT 	"
             + "(select name from tblassignment a where a.assignmentid = b.assignmentid limit 1) as nameasiigment , "
             + "b.name "
             + " FROM tblgroup b")
    public List<tblgroup> getAllDataProfileGroupMapper();    
    
     @Select("SELECT modulename, modulelink  FROM tblmodule ")
    public List<tblmodule> getAllDataModuleMapper();   
    
     @Select("SELECT * FROM tblgroup ")
    public List<tblgroup> getAllDataProfileGroupDroupDown(); 
    
    @Select("SELECT f_insert_profile::character varying as valueall FROM f_insert_profile(#{param.valuedata}::json) ")
    public profile insertDataProfil(@Param("param") profile valuedata); 
}
