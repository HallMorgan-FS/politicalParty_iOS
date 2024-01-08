//
//  Member.swift
//  HallMorganCE05
//
//  Created by Morgan Hall on 11/7/21.
//  Modified by Morgan Hall on 12/5/21.

import Foundation
import UIKit

enum ParsingError: Error {
    case MemberParsing
    case Generic
}

class Member {
    
    //Stored Properties
    var firstName: String
    var lastName: String
    var title: String
    var party: String
    var state: String
    var id: String
    var photo: UIImage!
    
    //Computed Properties
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    
    var partyAndState: String {
        return "\(party) - \(state)"
    }
    
    
    var fullParty: String {
        
        get {
            
            switch party {
            case "R":
                return "Republican"
            case "D":
                return "Democrat"
            case "I":
                return "Independent"
            default:
                return "Unaffiliated"
            }
        
        }
    }
    
    
    var backgroundColor: UIColor {
        
        get {
            
            switch party {
            case "R":
                return UIColor.systemRed
            case "D":
                return UIColor.systemBlue
            case "I":
                return UIColor.systemYellow
            default:
                return UIColor.systemYellow
            }
            
        }
        
    }
    
    
    //Initializers
    init(firstName: String, lastName: String, title: String, party: String, state: String, id: String) {
        
        //Store the parsed information
        self.firstName = firstName
        self.lastName = lastName
        self.title = title
        self.party = party
        self.state = state
        self.id = id
    
    
    
    
    
    
    }
}
