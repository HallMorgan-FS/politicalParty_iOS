//
//  DetailsViewController.swift
//  HallMorganCE05
//
//  Created by Morgan Hall on 11/7/21.
//  Modified by Morgan Hall on 12/5/21.

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var partyLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    
    //Adding these labels only to change their color
    @IBOutlet weak var label: UILabel!
    
    
    var member: Member!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Set navigation bar title
        navigationItem.title = "\(member.fullName)"
        
        if member != nil {
            fullName.text = member.fullName
            titleLabel.text = member.title
            partyLabel.text = member.fullParty
            stateLabel.text = member.state
            
            //Downnload the image for the correct cell when user taps cell
            //Get the correct image using the URL
            let stringURL = "https://theunitedstates.io/images/congress/225x275/" + "\(member.id).jpg"
            
            var photo = UIImage.init(named: "noPhoto")
            
            if let url = URL(string: stringURL){
                
                do {
                    //create a data object from the contents of that url and then create an image from that data
                    let data = try Data.init(contentsOf: url)
                    photo = UIImage(data: data)
                }
                catch {
                    //print localized error
                    print(error.localizedDescription)
                }
            
            }
            else {
                switch member.party {
                case "R":
                    photo = UIImage.init(named: "republican")
                case "D":
                    photo = UIImage.init(named: "democrat")
                case "I":
                    photo = UIImage.init(named: "independent")
                default:
                    photo = UIImage.init(named: "noPhoto")
                }
            }
            //Set image property
            memberImage.image = photo
            
            switch member.party {
            case "R":
                view.backgroundColor = UIColor.systemRed
            case "D":
                view.backgroundColor = UIColor.systemBlue
            case "I":
                view.backgroundColor = UIColor.systemYellow
            default:
                print("This should never happen")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
