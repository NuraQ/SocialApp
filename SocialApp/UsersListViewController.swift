//
//  UsersListViewController.swift
//  SocialApp
//
//  Created by Asal 3 on 25/10/2020.
//  Copyright © 2020 Asal 3. All rights reserved.
//

import UIKit

class UsersListViewController: UITableViewController {
  lazy  var usersDataSource = UsersDataSource(tableView: tableVieww)
    
    var rowSelected = 0
    var savedArray:[User] = []
    
    @IBAction func add(_ sender: Any) {
            performSegue(withIdentifier: "addUser", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
//        if let objects = UserDefaults.standard.value(forKey: "user_objects") as? Data {
//        let decoder = JSONDecoder()
//         if let obj = try? decoder.decode(Array.self, from: objects) as [User]{
//                savedArray = obj
//          }
//         appendStoredValuesToUsers()
       //  savedArray = defaults.object(forKey: "sth") as? [User] ?? [User]()
      //  print("saved data \(savedArray)")
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
      //  }
    }
    func appendStoredValuesToUsers () {
        for user in savedArray {
            usersDataSource.append(user: user, to: tableVieww)
        }
    }
    @IBOutlet var tableVieww: UITableView! {
          didSet {
            //self.delegate = kSecAttrAccessibleWhenUnlockedThisDeviceOnly
            
            
          }
      }
    // MARK: - Table view data source
  //  let savedArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()

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
        cell.userImage?.image = #imageLiteral(resourceName: "scott")
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
            UsersDataSource.users.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        rowSelected = indexPath.row
        performSegue(withIdentifier: "detailsSegue", sender: self)
    }

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsSegue" ,
            let detailsScene = segue.destination as? DetailsViewController {
           let indexPathh = rowSelected
            let selectedUser = UsersDataSource.users[indexPathh]
            detailsScene.user = selectedUser
        }
        
        if segue.identifier == "addUser" ,
               let addScene = segue.destination as? AddUserTableViewController {
              // detailsScene.user = selectedUser
           }

    }
    @IBAction func cancelToUsersTableViewController(_ segue: UIStoryboardSegue) {
     }
    
    @IBAction func saveUserDetails(_ segue: UIStoryboardSegue) {
       guard let AddUserTableViewController  = segue.source as? AddUserTableViewController,
        let user = AddUserTableViewController.newUser
             else {
               return
           }
       // savedArray.append(user)
//        let encoder = JSONEncoder()
//            if let encoded = try? encoder.encode(savedArray){
//               UserDefaults.standard.set(encoded, forKey: "user_objects")
        //defaults.set(savedArray, forKey: "bla")
        usersDataSource.append(user: user, to: tableVieww)
    // }
    }
   
}
