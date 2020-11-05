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
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var llongitude: UITextField!
    @IBOutlet weak var companyName: UITextField!
    @IBOutlet weak var bs: UITextField!
    @IBOutlet weak var catchPhrase: UITextField!
    @IBOutlet weak var suite: UITextField!
    var newUser: User?
    
    // MARK: - Table view data source
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        var performSegue = true
        if identifier == "cancel"{
            return true
        }
        if userEnteredAllValues()
        {
            if Email.text!.isValidEmail(){ }
            else{
                Email.displayWarning(warning: "please enter a valid email");
                performSegue = false
            }
            
            if phone.text!.isValidPhone(){ }
            else{
                phone.displayWarning(warning: "Enter a valid number");
                performSegue = false
            }
            
            if latitude.text!.isValidLatitude(){ }
            else{
                latitude.displayWarning(warning: "Enter a valid latitude between  -90 , 90");
                performSegue = false
            }
            
            if llongitude.text!.isValidLongitude(){ }
            else{
                llongitude.displayWarning(warning: "Enter a valid latitude between  -180 , 180");
                performSegue = false
            }
            
        } else{
            showAlert()
            performSegue = false
        }
        
        return performSegue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let companyy = company(name: companyName.text ?? "", catchPhrase: catchPhrase.text ?? "", bs: bs.text ?? "")
        let location = address(street: street.text ?? "", zipcode: zipCode.text ?? "", suite: suite.text ?? "", city: city.text ?? "", geo: geo(lat: latitude.text ?? "", lng: llongitude.text ?? ""))
        newUser = User(name: userName.text ?? "" , id: 5, username: userName.text ?? "", email: Email.text ?? "", website: website.text ?? "", phone: phone.text ?? "", company: companyy , address:location )
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
        if !(website.text!.isEmpty) && !(Email.text!.isEmpty) && !(phone.text!.isEmpty) && !(userName.text!.isEmpty) && !(zipCode.text!.isEmpty) && !(street.text!.isEmpty) && !(city.text!.isEmpty) && !(latitude.text!.isEmpty) && !(llongitude.text!.isEmpty) && !(companyName.text!.isEmpty) && !(catchPhrase.text!.isEmpty) && !(bs.text!.isEmpty) && !(suite.text!.isEmpty)
        {return true}
        return false
    }
    
    
}
extension String {
    
    public func isValidPhone()->Bool {
        let phoneRegex = "([+]?1+[-]?)?+([(]?+([0-9]{3})?+[)]?)?+[-]?+[0-9]{3}+[-]?+[0-9]{4}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return  predicate.evaluate(with: self)
        
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidLatitude()->Bool {
        if self.isAllDigits(){
        let lat  =  (self as NSString).doubleValue
        let valid = (lat > -90 && lat < 90) ?  true : false
        return(valid)
        }
        return false
    }
    
    private func isAllDigits()->Bool {
           let charcterSet  = NSCharacterSet(charactersIn: "+.0123456789").inverted
           let inputString = self.components(separatedBy: charcterSet)
           let filtered = inputString.joined(separator: "")
           return  self == filtered
       }
    func isValidLongitude()->Bool {
        if self.isAllDigits(){
        let long  =  (self as NSString).doubleValue
        let valid = (long > -180 && long < 180) ?  true : false
        return(valid)
        }
        return false
    }
}

extension UITextField {
    func displayWarning(warning: String) {
        self.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 0.2006902825)
        self.text = ""
        self.placeholder = warning
    }
}
