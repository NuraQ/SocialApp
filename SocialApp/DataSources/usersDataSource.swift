

import UIKit


class UsersDataSource: NSObject {
    // MARK: - Properties
    static  var users: [User] = []
    static  var savedArray: [User] = []
    let defaults = UserDefaults.standard
    
    //  private var results:[Result<Any, <#Failure: Error#>>]
    
    static func generateUsersData(tableView: UITableView)  {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
                    for item in decodedResponse {
                        UsersDataSource.users += [item]
                    }
                    DispatchQueue.main.async{
                        tableView.reloadData()
                    }
                }                                // everything is good, so we can exit
            }
        }.resume()
        
    }
    
    // MARK: - Initializers
    init(tableView: UITableView) {
        super.init()
        UsersDataSource.generateUsersData(tableView: tableView)
        retrieveStoredData()
        appendStoredValuesToUsers()
        
        
    }
    
    // MARK: - Datasource Methods
    func numberOfUsers() -> Int {
        UsersDataSource.users.count
    }
    
    func retrieveStoredData () {
        if let objects = UserDefaults.standard.value(forKey: "user_objects") as? Data {
            let decoder = JSONDecoder()
            if let obj = try? decoder.decode(Array.self, from: objects) as [User]{
                UsersDataSource.savedArray = obj
            }
        }
        
    }
    
    func appendStoredValuesToUsers () {
        for user in UsersDataSource.savedArray {
            UsersDataSource.users.append(user)
        }
    }
    
    func append(user: User, to tableView: UITableView) {
        let encoder = JSONEncoder()
        UsersDataSource.savedArray.append(user)
        if let encoded = try? encoder.encode(UsersDataSource.savedArray){
            UserDefaults.standard.set(encoded, forKey: "user_objects")
            UsersDataSource.users.append(user)
            tableView.insertRows(at: [IndexPath(row: UsersDataSource.users.count-1, section: 0)], with: .automatic)
        }
    }
    
    func userGet(at indexPath: IndexPath) -> User {
        UsersDataSource.users[indexPath.row]
    }
}
