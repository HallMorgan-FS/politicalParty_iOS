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
        // Set the back button color to black
        navigationController?.navigationBar.tintColor = .black
        
        if member != nil {
            fullName.text = member.fullName
            titleLabel.text = member.title
            partyLabel.text = member.fullParty
            stateLabel.text = member.state
            
            //Downnload the image for the correct cell when user taps cell
            //Get the correct image using the URL
            let stringURL = "https://theunitedstates.io/images/congress/225x275/" + "\(member.id).jpg"
            
            if let url = URL(string: stringURL){
                
                //Create a URL session
                let session = URLSession.shared
                
                //Create a data task
                let task = session.dataTask(with: url) { data, response, error in
                    //Check for errors
                    if let error = error {
                        print("Error loading image: \(error.localizedDescription)")
                        //Handle the error or set a default image
                        self.handleImageLoadingError()
                        return
                    }
                    
                    //Check if data is not null
                    if let data = data {
                        //Create an image from the data
                        DispatchQueue.main.async {
                            self.memberImage.image = UIImage(data: data)
                        }
                    }
                }
                
                //Start the data task
                task.resume()
                
            
            }
            else {
                
                //Handle the case when the URL is nil
                handleImageLoadingError()
              
            }
            
            
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
    
    func handleImageLoadingError() {
        // Handle the error or set a default image based on the party
        var photo = UIImage.init(named: "noPhoto")
        switch member.party {
        case "R":
            photo = UIImage(named: "republican")
        case "D":
            photo = UIImage(named: "democrat")
        case "I":
            photo = UIImage(named: "independent")
        default:
            photo = UIImage(named: "noPhoto")
        }
        //Set image property
        memberImage.image = photo
    }


}
