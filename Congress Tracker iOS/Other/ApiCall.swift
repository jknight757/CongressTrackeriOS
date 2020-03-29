//
//  ApiCall.swift
//  Congress Tracker iOS
//
//  Created by jeffrey knight on 3/25/20.
//  Copyright © 2020 fullsailStudent. All rights reserved.
//

import Foundation
import UIKit

protocol TableViewProtocol{
    func didReceiveData(result: [memberDetail]?, senate: Bool)
}
protocol SingleMemberProtocol{
    func didReceiveMemeberData(result: SingleMemberDetail)
}
protocol MemberImageProtocol{
    func didReceiveImage(result: UIImage)
}

class ApiCaller{
    var tableViewDelegate: TableViewProtocol?
    var cellClickDelegate: SingleMemberProtocol?
    var imageViewDelegate: MemberImageProtocol?
    var congressMembers: [memberDetail] = []
    var senateMembers: [memberDetail] = []
    var houseMembers: [memberDetail] = []
    let senateUrl = "https://api.propublica.org/congress/v1/116/senate/members.json"
    let houseUrl = "https://api.propublica.org/congress/v1/116/house/members.json"
    
    
    
    
    
    func pullSingleMemberData(_url: String){
        
        let url = URL(string: _url)
        if let unwrappedURL = url {
            var request = URLRequest(url: unwrappedURL)
            request.addValue("Oz8Wcrpvam5yPJgLfBcf39DPnFdCKlVhpBiArVkB", forHTTPHeaderField: "X-API-Key")
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                // you should put in error handling code, too
                if let data = data {
                    do {
                        print("----OnPull-------")
                        let string1 = String(data: data, encoding: String.Encoding.utf8) ?? "Data could not be printed"
                        print(string1)
                        print("----OnPull-------")
                        let json = try JSONDecoder().decode(SingleResults.self, from: data) as SingleResults
                        
                        self.cellClickDelegate?.didReceiveMemeberData(result: json.results[0])
                        print("----OnPull-------")
                        print(json.results[0].first_name)
                        print(json.results[0].last_name)
            
                     
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            dataTask.resume()
         
        }
        
    }
    
    func requestMemberImage(id: String){

        let url = URL(string:"https://theunitedstates.io/images/congress/225x275/" + id + ".jpg")!
        
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            self.imageViewDelegate?.didReceiveImage(result: UIImage(data: data)!)
              
           }

//           do{
//               memberImage = BitmapFactory.decodeStream((InputStream)new URL(url).getContent());
//           }catch (MalformedURLException e){
//               e.printStackTrace();
//           }catch (IOException e){
//               e.printStackTrace();
//           }

       }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    
    
    //Pass urls to pull member data
    func passUrl(){
        pullMemberData(_url: senateUrl, _senate: true)
        pullMemberData(_url: houseUrl, _senate: false)
    }
    
    // takes in url and bool to pull senate and house member list
    func pullMemberData(_url: String, _senate: Bool){

              let url = URL(string: _url)
               if let unwrappedURL = url {
                   var request = URLRequest(url: unwrappedURL)
                   request.addValue("Oz8Wcrpvam5yPJgLfBcf39DPnFdCKlVhpBiArVkB", forHTTPHeaderField: "X-API-Key")
                   let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                       // you should put in error handling code, too
                       if let data = data {
                           do {
                               let json = try JSONDecoder().decode(Results.self, from: data) as Results
                      
                            self.congressMembers.append(contentsOf: json.results[0].members)
                            if(_senate){
                                 self.senateMembers.append(contentsOf: json.results[0].members)
                                self.tableViewDelegate?.didReceiveData(result: self.senateMembers, senate: _senate)
                            }else{
                                self.houseMembers.append(contentsOf: json.results[0].members)
                                self.tableViewDelegate?.didReceiveData(result: self.houseMembers, senate: _senate)
                            }
                            
                            
                            
                           } catch {
                               print(error.localizedDescription)
                           }
                       }
                   }
                   dataTask.resume()
                
               }
    }
    
}
