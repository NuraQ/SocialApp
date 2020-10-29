

import UIKit

struct Response: Codable {
    public let name: String
    public let id: Int
    public let username: String
    public let email: String
    public let website: String
    public let phone: String
    //public let addres: address
    //  public let company: company
    //public let geo: geo
    
    
    
}
struct address: Codable {
    public let street: String
    public let zipcode: String
    public let suite: String
    public let city: String
    
    
}
struct geo: Codable {
    public let lat: String
    public let lng: String
}

struct company: Codable {
    public let name: String
    public let catchPhrase: String
    public let bs: String
    
}


class UsersDataSource: NSObject {
    // MARK: - Properties
    static  var users: [User] = []
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
                    // we have good data – go back to the main thread
                    //                    // update our UI
                    //                    self.users = decodedResponse.result
                    for item in decodedResponse {
                        UsersDataSource.users += [item]
                    }
                    DispatchQueue.main.async{
                        tableView.reloadData()
                    }
                }
                
                // everything is good, so we can exit
            }
            
            
        }.resume()
        
    }
    
    // MARK: - Initializers
    init(tableView: UITableView) {
        UsersDataSource.generateUsersData(tableView: tableView)
    }
    
    // MARK: - Datasource Methods
    func numberOfUsers() -> Int {
        UsersDataSource.users.count
    }
    
    func append(user: User, to tableView: UITableView) {
        UsersDataSource.users.append(user)
        tableView.insertRows(at: [IndexPath(row: UsersDataSource.users.count-1, section: 0)], with: .automatic)
    }
    
    func userGet(at indexPath: IndexPath) -> User {
        UsersDataSource.users[indexPath.row]
    }
}
