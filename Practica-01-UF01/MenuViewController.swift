//
//  MenuViewController.swift
//  Practica-01-UF01
//
//  Created by Alumne on 04/04/2019.
//  Copyright © 2019 Alumne. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    let dataBaseResourceFileName:String = "nbaPractica"
    var databasePath:String=String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpExternalDataBase()

        // Do any additional setup after loading the view.
    }
    
    func setUpExternalDataBase() {
        let fileManager = FileManager()
        
        if let docsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let dataBaseURL = docsDir.appendingPathComponent(dataBaseResourceFileName)
            databasePath = dataBaseURL.absoluteString
            
            if !fileManager.fileExists(atPath: databasePath) {
                
                if let sourceDataBaseURL = Bundle.main.url(forResource: dataBaseResourceFileName, withExtension: "db") {
                    do {
                        try fileManager.copyItem(at: sourceDataBaseURL, to: dataBaseURL)
                        print("Database copied")
                    }catch {
                        print("Error copying database")
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
    
    @IBAction func goBack(segue : UIStoryboardSegue) {
        print("1")
    }

}
