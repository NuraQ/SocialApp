//
//  UsersListViewController.swift
//  SocialApp
//
//  Created by Asal 3 on 25/10/2020.
//  Copyright © 2020 Asal 3. All rights reserved.
//

import UIKit

class UsersListViewController: UITableViewController {
    var usersDataSource = UsersDataSource()

var rowSelected = 0

    @IBAction func add(_ sender: Any) {
        tableVieww.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        tableVieww.reloadData()

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @IBOutlet  var tableVieww: UITableView! {
          didSet {
            //self.delegate = kSecAttrAccessibleWhenUnlockedThisDeviceOnly
          }
      }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usersDataSource.numberOfUsers()
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: "UserTableViewCell"
        ) as? UserTableViewCell ?? Bundle.main.loadNibNamed("UserTableViewCell", owner: self,options: nil)?.first as! UserTableViewCell
        
       cell.user = usersDataSource.userGet(at: indexPath)

       // cell.userName?.text = "sthhh"
        cell.userImage?.image = #imageLiteral(resourceName: "Unknown")
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            usersDataSource.users.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath as IndexPath)
                      tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        rowSelected = indexPath.row
                       performSegue(withIdentifier: "detailsSegue", sender: self)
    }

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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsSegue" ,
            let detailsScene = segue.destination as? DetailsViewController {
           let indexPathh = rowSelected
            let selectedUser = usersDataSource.users[indexPathh]
            detailsScene.user = selectedUser
        }
    }
    
}
