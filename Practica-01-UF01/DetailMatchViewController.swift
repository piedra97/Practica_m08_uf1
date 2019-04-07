//
//  DetailMatchViewController.swift
//  Practica-01-UF01
//
//  Created by Alumne on 28/03/2019.
//  Copyright © 2019 Alumne. All rights reserved.
//

import UIKit

class DetailMatchViewController: UIViewController {
    
    var database : FMDatabase = SQLiteSingleton.getInstance()
    let teamManager : TeamManager = (SQLFactory.createFactory(1) as! TeamManager)
    var matchToWork: Match?

    @IBOutlet weak var localTeamLogo: UIImageView!
    
    @IBOutlet weak var localTeamScore: UILabel!
    
    @IBOutlet weak var awayTeamScore: UILabel!
    
    
    @IBOutlet weak var awayTeamLogo: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var localLogo = " "
        var awayLogo = " "
        
        if let currentMatch = matchToWork {
            if database.open() {
                localLogo = teamManager.selecTeamLogoInMatch(database, currentMatch.fkLocalTeam as AnyObject)
                awayLogo = teamManager.selecTeamLogoInMatch(database, currentMatch.fkAwayTeam as AnyObject)
                database.close()
            }else {
                print("Error: \(database.lastErrorMessage())")
            }
            
            localTeamLogo.image = UIImage(named: localLogo)
            localTeamScore.text = String(currentMatch.localScore)
            awayTeamScore.text = String(currentMatch.awayScore)
            awayTeamLogo.image = UIImage(named: awayLogo)
            
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
