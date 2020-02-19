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
public class tblassignment {
    public Long assignmentid; 
    public Long deleted;
    public String schema; 
    public String name; 

    public tblassignment() {    }
    
}
