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
public class profile {
    public Long userid;
    public Long deleted;
    public String schema;
    public String profileno;
    public Long groupid;
    public Integer tnisvalidasi;    
    public String name; 
    public String password;
    public String valuedata;
    public String namegroupid;

    public profile() {}

}
