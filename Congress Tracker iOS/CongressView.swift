//
//  CongressView.swift
//  Congress Tracker iOS
//
//  Created by jeffrey knight on 3/24/20.
//  Copyright © 2020 fullsailStudent. All rights reserved.
//

import Foundation
import UIKit


class CongressView: ViewController, UITableViewDelegate, UITableViewDataSource, TableViewProtocol{

    
    @IBOutlet weak var memberTableView: UITableView!
    
    var congressMembers: [memberDetail] = []
    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
        
        let api: ApiCaller = ApiCaller()
        
        memberTableView.delegate = self
        memberTableView.dataSource = self
        api.tableViewDelegate = self
        
        api.passUrl()
    
    }
    
    // protcol call back method
    // triggered when API call returns data
    func didReceiveData(result: [memberDetail]?) {
        if let members = result{
            DispatchQueue.main.async() {
                self.congressMembers = members
                self.memberTableView.reloadData()
            }
        }
    }

   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return congressMembers.count
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MemberCell
        
        if(congressMembers.count != 0){
            var nameStr = congressMembers[(indexPath as NSIndexPath).row].first_name
            nameStr += " " + congressMembers[(indexPath as NSIndexPath).row].last_name
            cell.nameTv.text = nameStr
            
            var partyStr = ""
            if(congressMembers[(indexPath as NSIndexPath).row].party == "R"){
                partyStr += "Republican"
            }else if(congressMembers[(indexPath as NSIndexPath).row].party == "D"){
                partyStr += "Democrat"
            }else if(congressMembers[(indexPath as NSIndexPath).row].party == "I"){
                partyStr += "Independent"
            }
            cell.partyTV.text = partyStr
            
            let stateStr = "" + congressMembers[(indexPath as NSIndexPath).row].state
            cell.stateTV.text = stateStr
            
            
        }
          return cell
    }
    
    
    
}
