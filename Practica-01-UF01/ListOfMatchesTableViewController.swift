//
//  ListOfMatchesTableViewController.swift
//  Practica-01-UF01
//
//  Created by Alumne on 28/03/2019.
//  Copyright © 2019 Alumne. All rights reserved.
//

import UIKit

class ListOfMatchesTableViewController: UITableViewController, UISplitViewControllerDelegate {
    
    var database : FMDatabase = SQLiteSingleton.getInstance()
    let teamManager : TeamManager = (SQLFactory.createFactory(1) as! TeamManager)
    let matchManager : MatchManager = (SQLFactory.createFactory(0) as! MatchManager)
    var matchItem = MatchItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        if database.open() {
            matchItem.items = matchManager.readRecords(database) as! [Match]
            if matchItem.items.isEmpty {
                print("No records in EQUIPO TABLE")
            }
            database.close()
        }else {
            print("Error: \(database.lastErrorMessage())")
        }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return matchItem.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        
        let item:Match = matchItem.items[indexPath.row]
        
        let nameLocalToSelect = item.fkLocalTeam
        let nameAwayToSelect = item.fkAwayTeam
        
        
        //get the name of the team within the match table. Thanks to his FK.
        cell.textLabel?.text = teamManager.selecTeamNameInMatch(database, nameLocalToSelect as AnyObject)
        cell.detailTextLabel?.text = teamManager.selecTeamNameInMatch(database, nameAwayToSelect as AnyObject)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let recordToDelete = matchItem.items[indexPath.row].idPartido
        if editingStyle == .delete {
            matchItem.deleteItem(index: indexPath.row)
            if database.open() {
                
               let result = matchManager.delete(database, recordToDelete: recordToDelete as AnyObject)
                if result {
                    print ("Match Deleted")
                    
                } else {
                    print("Failed to delete match")
                    print("Error: \(database.lastErrorMessage())")
                }
                
                database.close()
            } else {
                print("Error: \(database.lastErrorMessage())")
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    
    
    @IBAction func goBack(segue : UIStoryboardSegue) {
        
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
