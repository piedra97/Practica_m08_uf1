//
//  EditMatchViewController.swift
//  Practica-01-UF01
//
//  Created by Alumne on 04/04/2019.
//  Copyright © 2019 Alumne. All rights reserved.
//

import UIKit

class EditMatchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var database : FMDatabase = SQLiteSingleton.getInstance()
    let teamManager : TeamManager = (SQLFactory.createFactory(1) as! TeamManager)
    let matchManager : MatchManager = (SQLFactory.createFactory(0) as! MatchManager)
    var pickerLocalData: [String] = [String]()
    var pickerAwayData: [String] = [String]()
    var nameLocalSelected:String = " "
    var nameAwaySelected:String = " "
    
    @IBOutlet weak var saveButtonBar: UIBarButtonItem!
    
    @IBOutlet weak var pickerLocal: UIPickerView!
    @IBOutlet weak var pickerAway: UIPickerView!
    
    @IBOutlet weak var scoreLocalTextField: UITextField!
    
    @IBOutlet weak var scoreAwayLocalTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.saveButtonBar.isEnabled = false
        self.pickerLocal.delegate = self
        self.pickerLocal.dataSource = self
        self.pickerLocal.tag = 1
        
        self.pickerAway.delegate = self
        self.pickerAway.dataSource = self
        self.pickerAway.tag = 2
        
        scoreLocalTextField.delegate = self
        scoreAwayLocalTextField.delegate = self
        
        if database.open() {
        let teams = teamManager.readRecords(database)
            if teams.isEmpty{
                print("No records in EQUIPOS TABLE")
            }else {
                for item in teams {
                    if let team = item as? Team {
                        pickerLocalData.append(team.teamName)
                        pickerAwayData.append(team.teamName)
                }
            }
        }
            database.close()
            
        }else {
            print("Error: \(database.lastErrorMessage())")
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !scoreLocalTextField.text!.isEmpty && !scoreLocalTextField.text!.isEmpty && !nameLocalSelected.isEmpty && !nameAwaySelected.isEmpty{
            self.saveButtonBar.isEnabled = true
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerLocal.tag == 1 {
            return pickerLocalData.count
        } else if pickerAway.tag == 2 {
            return pickerAwayData.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerLocal.tag == 1 {
            return pickerLocalData[row]
        } else if pickerAway.tag == 2 {
            return pickerAwayData[row]
        }
        
        return "default"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerLocal.tag == 1 {
            nameLocalSelected = pickerLocalData[row] as String
            pickerLocal.tag = 2
            
        }else if pickerAway.tag == 2 {
            nameAwaySelected = pickerAwayData[row] as String
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // var id_toInsert = 0
        if segue.identifier == "Save To TableView" {
        var fk_nameLocal:Int = 0
        var fk_nameAway:Int = 0
        if database.open() {
            //id_toInsert = mat
            fk_nameLocal = teamManager.selecTeamIDWhitName(database, nameLocalSelected as AnyObject)
            fk_nameAway = teamManager.selecTeamIDWhitName(database, nameAwaySelected as AnyObject)
            database.close()
            
        }else {
            print("Error: \(database.lastErrorMessage())")
            
        }
        if let localScoreToInsert = scoreLocalTextField.text {
            if let awayScoreToInsert = scoreAwayLocalTextField.text {
                if !localScoreToInsert.isEmpty && !awayScoreToInsert.isEmpty {
                    let newMatch:Match = Match(fkLocalTeam: fk_nameLocal, fkAwayTeam: fk_nameAway, localScore: Int(localScoreToInsert)!, awayScore: Int(awayScoreToInsert)!)
                    if database.open() {
                        let result = matchManager.insert(database, newRecord: newMatch)
                        
                        if result {
                            print("Added Match")
                            
                        } else {
                            print("Failed to add match")
                            print("Error: \(database.lastErrorMessage())")
                            
                        }
                        database.close()
                        
                    }else {
                        print("Error: \(database.lastErrorMessage())")
                        
                    }
                    
                }
                
            }
            
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
