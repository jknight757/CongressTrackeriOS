//
//  MemberDetailView.swift
//  Congress Tracker iOS
//
//  Created by jeffrey knight on 3/25/20.
//  Copyright © 2020 fullsailStudent. All rights reserved.
//

import Foundation
import UIKit

class MemberDetailView: UIViewController, SingleMemberProtocol{

    var selectMemberUri: String?
    var selectMember: SingleMemberDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // do stuff
        let api: ApiCaller = ApiCaller()
        api.cellClickDelegate = self
         print(selectMemberUri!)

        if let uri = selectMemberUri {
            print("----OnPass-------")
            print(uri)
            api.pullSingleMemberData(_url: uri)
        }
    }
    
    func didReceiveMemeberData(result: SingleMemberDetail) {
        selectMember = result
        DispatchQueue.main.async() {
            print("----OnPass-------")
            print(self.selectMember!.first_name)
            print(self.selectMember!.last_name)
        }
      }
      
    
}
