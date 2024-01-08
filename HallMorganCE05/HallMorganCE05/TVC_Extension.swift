//
//  TVC_Extension.swift
//  HallMorganCE05
//
//  Created by Morgan Hall on 11/7/21.
//   Modified by Morgan Hall on 12/5/21.

import Foundation
import UIKit

extension TableViewController {
    
    //Create method to parse JSON data
    func downloadAndParse(atUrl urlString: String) {
        
        //Create a defualt configuration
        let config = URLSessionConfiguration.default
        
        //Create a session
        let session = URLSession(configuration: config)
        
        //Validate the URL to ensure it is not a broken link
        if let validURL = URL(string: urlString) {
            
            //Create a URLRequest passing in the validURL for our header
            var request = URLRequest(url: validURL)
            
            //Set the header values
            request.setValue("3BZvhxmxIYUsEmraezfQgFLWhC0O4YFkixLszylh", forHTTPHeaderField: "X-API-Key")
            
            //Set the type of request
            request.httpMethod = "GET"
            
            //Create a task to send the request and download whatever is found at the validURL
            let task = session.dataTask(with: request, completionHandler: { opt_data, opt_response, opt_error in
                
                //Bail out on error
                if opt_error != nil { assertionFailure(); return}
                
                //Check the response, status code, and data
                guard let response = opt_response as? HTTPURLResponse,
                      response.statusCode == 200,
                      let data = opt_data
                else { assertionFailure(); return }
                
                //set up do catch block
                do {
                    //De-Serialize data object
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        
                        //Create guard
                        guard let outerData = json["results"] as? [[String: Any]]
                        else {
                            assertionFailure()
                            return
                        }
                        
                        //Loop through the outerData dictionary to access the members dictionary
                        for items in outerData {
                            guard let members = items["members"] as? [[String: Any]]
                            else {
                                assertionFailure()
                                return
                            }
                            
                            //Parse the member JSON
                             for member in members {
                                 
                                guard let fname = member["first_name"] as? String,
                                      let lname = member["last_name"] as? String,
                                      let memTitle = member["title"] as? String,
                                      let memParty = member["party"] as? String,
                                      let memState = member["state"] as? String,
                                      let memId = member["id"] as? String
                                else {
                                     //Throw custom error
                                     throw ParsingError.MemberParsing
                                }
                                
                                //Map to Model Objects
                                let newMember = Member(firstName: fname, lastName: lname, title: memTitle, party: memParty, state: memState, id: memId)
                                //Append new member to the members array
                                self.members.append(newMember)
                                
                             }
                        }
                    }
                    
                }
                catch {
                    
                    //Print error
                    print(error.localizedDescription)
                    
                }
                
                DispatchQueue.main.async {
                    self.filterMembersByParty()
                    self.tableView.reloadData()
                }
                
            })
            
            //resume the task
            task.resume()
            
        }
        
        
    }
    
    //Filter the posts
    func filterMembersByParty() {
        filteredMembers[0] = members.filter({ $0.party == "R" })
        filteredMembers[1] = members.filter({ $0.party == "D" })
        filteredMembers[2] = members.filter({ $0.party == "I" })
    }
    
    
    
    
}
