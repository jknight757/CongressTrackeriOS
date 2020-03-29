//
//  MemberDetailView.swift
//  Congress Tracker iOS
//
//  Created by jeffrey knight on 3/25/20.
//  Copyright © 2020 fullsailStudent. All rights reserved.
//

import Foundation
import UIKit

class MemberDetailView: UIViewController, SingleMemberProtocol, MemberImageProtocol{
   
    // UI outlets
    @IBOutlet weak var profImageView: UIImageView!
    @IBOutlet weak var nameTV: UILabel!
    @IBOutlet weak var partyTV: UILabel!
    @IBOutlet weak var stateTV: UILabel!
    @IBOutlet weak var totalVP_TV: UILabel!
    @IBOutlet weak var missedVP_TV: UILabel!
    @IBOutlet weak var VWPP_TV: UILabel!
    @IBOutlet weak var VAPP_TV: UILabel!
    
    var selectMemberUri: String?
    var selectMember: SingleMemberDetail?
    let api: ApiCaller = ApiCaller()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // do stuff
    
        api.cellClickDelegate = self
        api.imageViewDelegate = self

        if let uri = selectMemberUri {
            api.pullSingleMemberData(_url: uri)
            
        }
    }
    
    func didReceiveMemeberData(result: SingleMemberDetail) {
        selectMember = result
        DispatchQueue.main.async() {
        
            var name = self.selectMember!.first_name
            name += ", " + self.selectMember!.last_name
            
            var party = self.selectMember!.roles![0].chamber!
            if(self.selectMember!.current_party! == "R"){
                party += ", Republican"
            }else if(self.selectMember!.current_party! == "D"){
                party += ", Democrat"
            }else{
                party += ", Independent"
            }
                
            
            var state = self.selectMember!.roles![0].state!
            
            state = States.GetUnabreviated(abr: state)
            
            var totalVotes: String = ""
            totalVotes += String(self.selectMember!.roles![0].total_votes!)
            let missedVP: String = String(self.selectMember!.roles![0].missed_votes_pct!) + "%"
            
            let vwpp: String =  String(self.selectMember!.roles![0].votes_with_party_pct!) + "%"
            let vapp: String = String(self.selectMember!.roles![0].votes_against_party_pct!) + "%"

            
            
            self.nameTV.text! = name
            self.partyTV.text! = party
            self.stateTV.text! = state
            self.totalVP_TV.text! = totalVotes
            self.missedVP_TV.text! = missedVP
            self.VWPP_TV.text! = vwpp
            self.VAPP_TV.text! = vapp
            self.api.requestMemberImage(id: self.selectMember!.id)
            
        }
      }
    
    func didReceiveImage(result: UIImage) {
       
        DispatchQueue.main.async() {
            self.profImageView.image = result
        }
    }
       
      
    
}
