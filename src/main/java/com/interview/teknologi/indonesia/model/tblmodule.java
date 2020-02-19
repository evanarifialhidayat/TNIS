/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interview.teknologi.indonesia.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

/**
 *
 * @author arzanka
 */
@Getter
@Setter
@AllArgsConstructor
public class tblmodule {   
    public Long moduleid; 
    public Long deleted;
    public String schema; 
    public String modulelink; 
    public String modulename;

    public tblmodule() {}
    
}
