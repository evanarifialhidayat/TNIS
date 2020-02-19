/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interview.teknologi.indonesia.services;

import com.interview.teknologi.indonesia.model.profile;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

/**
 *
 * @author arzanka
 */
@Mapper
public interface servicesMapper {    
    @Select("SELECT * FROM profile")
    public List<profile> getAllDataProfile();
    
}
