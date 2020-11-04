//
//  UsersListViewController.swift
//  SocialApp
//
//  Created by Asal 3 on 25/10/2020.
//  Copyright © 2020 Asal 3. All rights reserved.
//

import UIKit

class UsersListViewController: UITableViewController, UISearchControllerDelegate {
  lazy  var usersDataSource = UsersDataSource(tableView: tableVieww)
    
    var rowSelected = 0
    var filteredUsers: [User] = []
    let searchController = UISearchController(searchResultsController: nil)

    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    @IBAction func add(_ sender: Any) {
            performSegue(withIdentifier: "addUser", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSearchBar()
       
    }

  
        func initializeSearchBar() {

            searchController.delegate = self
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.placeholder = "Search Users"
            searchController.searchResultsUpdater = self
            searchController.showsSearchResultsController = true
            navigationItem.searchController = searchController
            searchController.searchBar.isHidden = true
        }
    

    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
                    searchController.searchBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
           self.tableView.estimatedRowHeight = 700
         self.tableView.rowHeight = UITableView.automaticDimension
        if let indexPath = tableView.indexPathForSelectedRow {
               tableView.deselectRow(at: indexPath, animated: true)
             }
         self.tableView.reloadData()
       // navigationItem.hidesSearchBarWhenScrolling = true

        
    }
    @IBOutlet var tableVieww: UITableView!
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isFiltering {
           return filteredUsers.count
         }
        return usersDataSource.numberOfUsers()
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var userForRow:User
      let cell = tableView.dequeueReusableCell(
        withIdentifier: "UserTableViewCell"
        ) as? UserTableViewCell ?? Bundle.main.loadNibNamed("UserTableViewCell", owner: self,options: nil)?.first as! UserTableViewCell
         if isFiltering {
             userForRow = filteredUsers[indexPath.row]
           } else {
             userForRow = usersDataSource.userGet(at: indexPath)
           }
       cell.user = userForRow
        cell.userImage?.image = #imageLiteral(resourceName: "scott")

        return cell
    }
    


 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            usersDataSource.removeUserFromUserDefaults(at: indexPath)
            usersDataSource.updateUserDefaults()
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
            let selectedUser: User
            selectedUser = isFiltering ? filteredUsers[rowSelected] : UsersDataSource.users[rowSelected]
            detailsScene.user = selectedUser
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
        usersDataSource.append(user: user, to: tableVieww)
    }
   
    func filterContentForSearchText(_ searchText: String) {
        filteredUsers = UsersDataSource.users.filter { (usr: User) -> Bool in
            return usr.username.lowercased().contains(searchText.lowercased())
            
      }
        print(filteredUsers)
      tableVieww.reloadData()
    }}

extension UsersListViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text!)
  }
}

