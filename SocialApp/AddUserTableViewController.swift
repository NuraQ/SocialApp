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
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var street: UITextField!
    
    var newUser: User?
    
    // MARK: - Table view data source
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {

        var performSegue = false
        if identifier == "cancel"{
            return true
        }
        if userEnteredAllValues()
        {
            Email.text!.isValidEmail() ?  performSegue = true :Email.displayWarning(warning: "please enter a valid email");
              performSegue = false

            phone.text!.isValidPhone() ? performSegue = true : phone.displayWarning(warning: "Enter a valid number"); performSegue = false
            
            
        } else{
            showAlert()
            performSegue = false
        }
        
        return performSegue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        newUser = User(name: userName.text ?? "" , id: 5, username: userName.text ?? "", email: Email.text ?? "", website: website.text ?? "", phone: phone.text ?? "", company: company(name: "sd", catchPhrase: "d", bs: "d") , address: address(street: street.text ?? "", zipcode: zipCode.text ?? "", suite: "", city: city.text ?? "", geo: geo(lat: "", lng: "")))
    
 
        
    }
    
    func showAlert() {

        let Alert = UIAlertController(title: "Add user page", message: "duuude please enter all data!!", preferredStyle:  .alert)
        
        let Action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
        })
        Alert.addAction(Action)
        present(Alert, animated: true, completion: nil)
    }
    func userEnteredAllValues() -> Bool {
        if !(website.text!.isEmpty) && !(Email.text!.isEmpty) && !(phone.text!.isEmpty) && !(userName.text!.isEmpty) && !(zipCode.text!.isEmpty) && !(street.text!.isEmpty) && !(city.text!.isEmpty)
        {return true}
        return false
    }
    
    
}
extension String {
    
    public func isValidPhone()->Bool {
        if self.isAllDigits() == true {
            let phoneRegex = "[235689][0-9]{6}([0-9]{3})?"
            let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return  predicate.evaluate(with: self)
        }else {
            return false
        }
    }
    
    private func isAllDigits()->Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = self.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  self == filtered
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}

extension UITextField {
    func displayWarning(warning: String) {
        self.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 0.2006902825)
        self.text = ""
        self.placeholder = warning
    }
}
