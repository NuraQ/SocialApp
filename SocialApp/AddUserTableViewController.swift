//
//  AddUserTableViewController.swift
//  
//
//  Created by Asal 3 on 29/10/2020.
//

import UIKit

class AddUserTableViewController: UITableViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var website: UITextField!
    
    var newUser: User?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if !(website.text!.isEmpty) && !(Email.text!.isEmpty) && !(phone.text!.isEmpty) && !(userName.text!.isEmpty) {
             newUser = User(name: userName.text ?? "" , id: 5, username: userName.text ?? "", email: Email.text ?? "", website: website.text ?? "", phone: phone.text ?? "", company: company(name: "sd", catchPhrase: "d", bs: "d") )
           // UsersDataSource.append(user: newUser, to: tableVieww )
        }
            //else {
//            let Alert = UIAlertController(title: title, message: "message", preferredStyle:  .alert)
//
//                 let Action = UIAlertAction(title: "Awsome", style: .default, handler: {
//                     action in
//                   //  self.startNewRound()
//                 })
//                 Alert.addAction(Action)
//                 present(Alert, animated: true, completion: nil)
//            return
//        }
    }
    

}
