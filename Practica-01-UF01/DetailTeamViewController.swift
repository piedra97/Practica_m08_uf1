//
//  DetailTeamViewController.swift
//  Practica-01-UF01
//
//  Created by Alumne on 25/03/2019.
//  Copyright © 2019 Alumne. All rights reserved.
//

import UIKit

class DetailTeamViewController: UIViewController {

    @IBOutlet weak var logoToDisplay: UIImageView!
    @IBOutlet weak var nameToDisplay: UILabel!
    @IBOutlet weak var cityToDisplay: UILabel!
    @IBOutlet weak var conferenceToDisplay: UILabel!
    var teamToWork: Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentTeam = teamToWork {
            logoToDisplay.image = UIImage(named: currentTeam.logo)
            nameToDisplay.text = currentTeam.teamName
            cityToDisplay.text = currentTeam.city
            conferenceToDisplay.text = currentTeam.conference
        }

        // Do any additional setup after loading the view.
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
