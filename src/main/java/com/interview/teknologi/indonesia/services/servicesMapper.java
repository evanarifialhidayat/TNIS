/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interview.teknologi.indonesia.services;

import com.interview.teknologi.indonesia.model.cuti;
import com.interview.teknologi.indonesia.model.profile;
import com.interview.teknologi.indonesia.model.tblassignment;
import com.interview.teknologi.indonesia.model.tblgroup;
import com.interview.teknologi.indonesia.model.tblmodule;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

/**
 *
 * @author arzanka
 */
@Mapper
public interface servicesMapper {    
    @Select("SELECT b.userid, "
            + "(select a.name from tblgroup a where a.groupid = b.groupid limit 1) as namegroupid,"
            + " b.name, b.password, b.profileno  FROM profile b where deleted=0")
    public List<profile> getAllDataProfile();
    
    @Select("SELECT * FROM tblassignment where deleted=0 ")
    public List<tblassignment> getAllDataAssigmentMapper();    
    
     @Select("SELECT 	"
             + "(select name from tblassignment a where a.assignmentid = b.assignmentid limit 1) as nameasiigment , "
             + "b.name "
             + " FROM tblgroup b where deleted=0")
    public List<tblgroup> getAllDataProfileGroupMapper();    
    
     @Select("SELECT modulename, modulelink  FROM tblmodule where deleted=0")
    public List<tblmodule> getAllDataModuleMapper();   
    
     @Select("SELECT * FROM tblgroup where deleted=0 ")
    public List<tblgroup> getAllDataProfileGroupDroupDown(); 
    
    @Select("SELECT f_insert_profile::character varying as valueall FROM f_insert_profile(#{param.valuedata}::json) ")
    public profile insertDataProfil(@Param("param") profile valuedata); 
    
    
    @Select("SELECT * FROM cuti where deleted=0 ")
    public List<cuti> getAllDataCuti(); 
    
    @Select("SELECT f_insert_cuti::character varying as valueall FROM f_insert_cuti(#{param.valuedata}::json) ")
    public cuti insertDataCuti(@Param("param") cuti valuedata); 
    
    @Update("UPDATE cuti   SET deleted=1 WHERE cutiid = #{cutiid}")
     public long deletedDataCuti(long cutiid); 
     
     @Select("SELECT * FROM cuti where deleted=0 and cutiid= #{cutiid}")
     public cuti editDataCuti(long cutiid);
}
