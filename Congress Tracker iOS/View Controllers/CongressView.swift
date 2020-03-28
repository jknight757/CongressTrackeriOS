//
//  CongressView.swift
//  Congress Tracker iOS
//
//  Created by jeffrey knight on 3/24/20.
//  Copyright © 2020 fullsailStudent. All rights reserved.
//

import Foundation
import UIKit


class CongressView: ViewController, UITableViewDelegate, UITableViewDataSource, TableViewProtocol, UIPickerViewDelegate, UIPickerViewDataSource{
   
    // View outlets
    @IBOutlet weak var memberTableView: UITableView!
    @IBOutlet weak var chamberPickerView: UIPickerView!
    
    // member Variables
    var congressMembers: [memberDetail] = []
    var filteredMembers: [memberDetail] = []
    var senateMembers: [memberDetail] = []
    var houseMembers: [memberDetail] = []
    var chamberFilter = ["Chamber", "Senate", "House"]
    var currentFilter = "Chamber"
    var selectMemUri = "Error"
    
    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
        
        let api: ApiCaller = ApiCaller()
        
        memberTableView.delegate = self
        memberTableView.dataSource = self
        chamberPickerView.delegate = self
        chamberPickerView.dataSource = self
        api.tableViewDelegate = self
        api.passUrl()
    
    }
    
    // protcol call back method
    // triggered when API call returns data
    func didReceiveData(result: [memberDetail]?, senate: Bool) {
        if let members = result{
            DispatchQueue.main.async() {
                if(senate){
                    self.senateMembers = members
                    self.congressMembers.append(contentsOf: self.senateMembers)
                }else{
                    self.houseMembers = members
                    self.congressMembers.append(contentsOf: self.houseMembers)
                }
                self.filteredMembers = self.congressMembers
                self.memberTableView.reloadData()
            }
        }
    }
    
    // UIPickerView Protocol methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
    }
       
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return chamberFilter.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return chamberFilter[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.currentFilter = self.chamberFilter[row]
        updateTable(filter: self.currentFilter)
        
    }
    
    func updateTable(filter: String){
        switch filter {
        case "Chamber":
            // show all members
            self.filteredMembers = self.congressMembers
            self.memberTableView.reloadData()
        case "Senate":
            //show senate members
            self.filteredMembers  = self.senateMembers
            self.memberTableView.reloadData()
        case "House":
            // show house members
            self.filteredMembers  = self.houseMembers
            self.memberTableView.reloadData()
            print(self.houseMembers.count)
        default:
            self.memberTableView.reloadData()
        }
    }
    
    
    // UITableView Protocol methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return filteredMembers.count
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MemberCell
        
        if(filteredMembers.count != 0){
            var nameStr = filteredMembers[(indexPath as NSIndexPath).row].first_name
            nameStr += " " + filteredMembers[(indexPath as NSIndexPath).row].last_name
            cell.nameTv.text = nameStr
            
            var partyStr = ""
            if(filteredMembers[(indexPath as NSIndexPath).row].party == "R"){
                partyStr += "Republican"
            }else if(filteredMembers[(indexPath as NSIndexPath).row].party == "D"){
                partyStr += "Democrat"
            }else{
                partyStr += "Independent"
            }
            cell.partyTV.text = partyStr
            
            let stateStr = "" + filteredMembers[(indexPath as NSIndexPath).row].state!
            cell.stateTV.text = stateStr
            
            
        }
          return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("----OnClick-------")
        print(filteredMembers[indexPath.row].first_name)
        
        if(filteredMembers.count > 0){
            selectMemUri = filteredMembers[indexPath.row].api_uri
            performSegue(withIdentifier: "MemberDetailSegue", sender: nil)
        }
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("----OnPrepareSegue-------")
        if let  destinationVC = segue.destination as? MemberDetailView{
            destinationVC.selectMemberUri = selectMemUri
        }
    }
    

    
    
    
}
