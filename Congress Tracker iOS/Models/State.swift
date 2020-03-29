//
//  State.swift
//  Congress Tracker iOS
//
//  Created by jeffrey knight on 3/28/20.
//  Copyright © 2020 fullsailStudent. All rights reserved.
//

import Foundation
class States{
     static var stateAbList = ["AK","AL","AR","AZ","CA","CO","CT","DE","FL","GA","HI","IA","ID",
               "IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MO","MS","MT","NC","ND","NE","NH","NJ","NM","NV","NY",
               "OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VA","VT","WA","WI","WV","WY"]

       static var stateList = ["Alaska","Alabama","Arkansas","Arizona","California","Colorado","Connecticut",
               "Delaware","Florida","Georgia","Hawaii","Iowa","Idaho", "Illinois","Indiana","Kansas",
               "Kentucky","Louisiana","Massachusetts","Maryland","Maine","Michigan", "Minnesota","Missouri","Mississippi",
               "Montana","North Carolina","North Dakota","Nebraska","New Hampshire", "New Jersey","New Mexico","Nevada",
               "New York", "Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota",
               "Tennessee","Texas","Utah", "Virginia","Vermont","Washington","Wisconsin","West Virginia","Wyoming"]
    
    
    
    static func GetUnabreviated(abr: String )->  String{
        var state = "";
        let size = stateAbList.count - 1
        
        for i in 0...size {
            if(stateAbList[i] == abr){
                state = stateList[i];
            }
            
        }
         return state;
      }
    
}
