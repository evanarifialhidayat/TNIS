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
public class cuti {
    public Long cutiid;
    public Long deleted;
    public String schema;
    public String keperluan;
    public String datefrom;
    public String dateto;
    public String description;
    public String status ;
    public String cutino ;
    public cuti(){}
}
