/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function getDateGrid(grid){
    var visRow = {};
    var i = 0;
    grid.forEachRow(function(id){
            i = grid.getRowIndex(id);
            visRow[i] = [];
            grid.forEachCell(id, function(ncell,ind) {
                    if(ind > 0)
                    visRow[i][ind] = ncell.getValue();
                    else
                    visRow[i][ind] = id;
            });
           // visRow[i][mygrid_d.getColumnsNum()] = id;
    });
    var a_var = JSON.stringify(visRow);
    alert(a_var);
    return false;
    
//{
//    "0":[1,"REPORT","21/09/17"],
//    "1":[2,"MASTER","30/01/18"],
//    "2":[3,"TRANSACTION","16/01/20"],
//    "3":[4,"ADMIN","24/08/17"]
//}
    
}