//
//  ListOfTeamsTableViewController.swift
//  Practica-01-UF01
//
//  Created by Alumne on 25/03/2019.
//  Copyright © 2019 Alumne. All rights reserved.
//

import UIKit

class ListOfTeamsViewController: UIViewController, UISplitViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var database : FMDatabase = SQLiteSingleton.getInstance()
    let teamManager : TeamManager = (SQLFactory.createFactory(1) as! TeamManager)
    var teamsToWork : [Team] = [Team]()
    var teamsName: [String] = [String]()
    var teamsLogo: [UIImage] = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        if database.open() {
            teamsToWork = teamManager.readRecords(database) as! [Team]
            if teamsToWork.isEmpty{
                print("No records in EQUIPOS TABLE")
            }else {
                for item in teamsToWork {
                    if let team = item as? Team {
                       teamsName.append(team.teamName)
                        teamsLogo.append(UIImage(named: team.logo)!)
                    }
                }
            }
            database.close()
            
        }else {
            print("Error: \(database.lastErrorMessage())")
        }
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.splitViewController?.delegate = self
    }
    
    func splitViewController (
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController) -> Bool{
        if let navigationController = primaryViewController as? UINavigationController{
            if navigationController.visibleViewController != nil {
                return true
            }
        }
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teamsName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.teamName.text = teamsName[indexPath.item]
        cell.teamLogo.image = teamsLogo[indexPath.item]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Team Detail Segue" {
            if let cell = sender as? UICollectionViewCell,
                let indexPath = collectionView.indexPath(for: cell)
            {
                if let tvmc = segue.destination as? DetailTeamViewController {
                    tvmc.teamToWork = teamsToWork[indexPath.item]
                    
                }
                
            }
            
        }
    }


}
