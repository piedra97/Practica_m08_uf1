//
//  EditMatchViewController.swift
//  Practica-01-UF01
//
//  Created by Alumne on 04/04/2019.
//  Copyright © 2019 Alumne. All rights reserved.
//

import UIKit

class EditMatchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var database : FMDatabase = SQLiteSingleton.getInstance()
    let teamManager : TeamManager = (SQLFactory.createFactory(2) as! TeamManager)
    var pickerData: [String] = [String]()
    
    @IBOutlet weak var pickerLocal: UIPickerView!
    @IBOutlet weak var pickerAway: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerLocal.delegate = self
        self.pickerLocal.dataSource = self
        self.pickerAway.delegate = self
        self.pickerAway.dataSource = self
        
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
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
