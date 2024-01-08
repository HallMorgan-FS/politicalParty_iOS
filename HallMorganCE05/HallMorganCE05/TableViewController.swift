//
//  TableViewController.swift
//  HallMorganCE05
//
//  Created by Morgan Hall on 11/7/21.
//  Modified by Morgan Hall on 12/5/21.

import UIKit

class TableViewController: UITableViewController {
    
    //Create empty array of members
    var members = [Member]()
    
    //Container to hold members filtered by party
    var filteredMembers = [[Member](), [Member](), [Member]()]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set navigation title
        navigationItem.title = "Members of Congress"
        
        //Set header background color
        tableView.tableHeaderView?.backgroundColor = UIColor.darkGray
        
        //download the JSON
        downloadAndParse(atUrl: "https://api.propublica.org/congress/v1/116/senate/members.json")
        downloadAndParse(atUrl: "https://api.propublica.org/congress/v1/116/house/members.json")
        

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredMembers[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? MemberCell
        else {
            return tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        }
        
        //Configure cell
        //create constant for current member
        let currentMember = filteredMembers[indexPath.section][indexPath.row]
        cell.name.text = "\(currentMember.lastName), \(currentMember.firstName)"
        cell.title.text = currentMember.title
        cell.partyState.text = currentMember.partyAndState
        //Update background text according to party
        cell.backgroundColor = currentMember.backgroundColor
        if currentMember.party == "I"{
            cell.name.textColor = UIColor.darkGray
            cell.title.textColor = UIColor.darkGray
            cell.partyState.textColor = UIColor.darkGray
        }
        
        return cell
    }
    
    
    //Header Methods
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Republicans"
        case 1:
            return "Democrats"
        case 2:
            return "Independents"
        default:
            return "Oops should not happen here"
        }
        
    }
    
    //Set header height
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Get access to the destination controller
        if let indexPath = tableView.indexPathForSelectedRow {
            
            let memberToSend = filteredMembers[indexPath.section][indexPath.row]
            
            if let destination = segue.destination as? DetailsViewController {
                destination.member = memberToSend
            }
        }
        
    }
    

}
