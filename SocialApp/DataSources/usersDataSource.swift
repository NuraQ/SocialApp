

import UIKit

class UsersDataSource: NSObject {
  // MARK: - Properties
  var users: [User]

  static func generateUsersData() -> [User] {
    return [
        User(userName: "Nura", email: "nura.qasrawi@gmail.com", phoneNumber: "4", webSite: "bla bla bla"),
        User(userName: "minion", email: "minion.m@gmail.com", phoneNumber: "555", webSite: "bla bla bla"),
        User(userName: "minion3", email: "minion.m@gmail.com", phoneNumber: "777", webSite: "bla bla bla")
    ]
  }

  // MARK: - Initializers
  override init() {
    users = UsersDataSource.generateUsersData()
  }

  // MARK: - Datasource Methods
  func numberOfUsers() -> Int {
    users.count
  }

  func append(user: User, to tableView: UITableView) {
    users.append(user)
    tableView.insertRows(at: [IndexPath(row: users.count-1, section: 0)], with: .automatic)
  }

  func userGet(at indexPath: IndexPath) -> User {
    users[indexPath.row]
  }
}
