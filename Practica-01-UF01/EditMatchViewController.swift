//
//  EditMatchViewController.swift
//  Practica-01-UF01
//
//  Created by Alumne on 04/04/2019.
//  Copyright © 2019 Alumne. All rights reserved.
//

import UIKit

class EditMatchViewController: UIViewController {

    var database : FMDatabase = SQLiteSingleton.getInstance()
    let teamManager : TeamManager = (SQLFactory.createFactory(2) as! TeamManager)
    var pickerData: [String] = [String]()
    
    @IBOutlet weak var pickerLocal: UIPickerView!
    @IBOutlet weak var pickerAway: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if database.open() {
        let teams = teamManager.readRecords(database)
            if teams.isEmpty{
                print("No records in EQUIPOS TABLE")
            }else {
                for item in teams {
                    if let team = item as? Team {
                        pickerData.append(team.teamName)
                }
            }
        }
            database.close()
            
        }else {
            print("Error: \(database.lastErrorMessage())")
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
    @IBAction func goBack(segue : UIStoryboardSegue) {
        
    }
}
