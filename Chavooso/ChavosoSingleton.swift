//
//  ChavosoSingleton.swift
//  Chavooso
//
//  Created by Gabriel Taques on 04/05/19.
//  Copyright © 2019 Gabriel Taques. All rights reserved.
//

import Foundation

class ChavosoSingleton{
    
    static let shared = ChavosoSingleton()
    
    var likedList: [String]! = []
    //Initializer access level change now
    private init(){}
    
    func requestForChavosoSingleton(){
        //Code Process
//        locationGranted = true
//        print("Location granted")
    }
    
}
//Access class function in a single line
//ChavosoSingleton.shared.l
