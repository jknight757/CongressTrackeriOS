//
//  ApiCall.swift
//  Congress Tracker iOS
//
//  Created by jeffrey knight on 3/25/20.
//  Copyright © 2020 fullsailStudent. All rights reserved.
//

import Foundation

protocol TableViewProtocol{
    func didReceiveData(result: [memberDetail]?)
}

class ApiCaller{
    var tableViewDelegate: TableViewProtocol?
    var congressMembers: [memberDetail] = []
    let senateUrl = "https://api.propublica.org/congress/v1/116/senate/members.json"
    let houseUrl = "https://api.propublica.org/congress/v1/116/house/members.json"
    
    
    
    func passUrl(){
        pullMemberData(_url: senateUrl)
        pullMemberData(_url: houseUrl)
    }
    
    func pullMemberData(_url: String){

              let url = URL(string: _url)
               if let unwrappedURL = url {
                   var request = URLRequest(url: unwrappedURL)
                   request.addValue("ewhK3e7sQB61DVlX2Q4KYjyQeofyme0ZjrQDCK3i", forHTTPHeaderField: "X-API-Key")
                   let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                       // you should put in error handling code, too
                       if let data = data {
                           do {
                               let json = try JSONDecoder().decode(Results.self, from: data) as Results
                               // HERE'S WHERE YOUR DATA IS
                            print(json.results[0].members[0].first_name)
                            print(json.results[0].members[0].last_name)
                            print(json.results[0].members[0].party)
                               
                            self.congressMembers.append(contentsOf: json.results[0].members)
                            print(self.congressMembers.count)
                            print(json.results[0].members.count)
                            
                            self.tableViewDelegate?.didReceiveData(result: self.congressMembers )
                            
                            
                           } catch {
                               print(error.localizedDescription)
                           }
                       }
                   }
                   dataTask.resume()
                
               }
    }
    
}
