//
//  ViewController.swift
//  BedSide Chats
//
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var email: TextField!
    
    @IBOutlet weak var pswd: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onLogin(_ sender: Any) {
        let userRequest: NSFetchRequest<User> = User.fetchRequest()
        let predicate = NSPredicate(format: "username = %@ and password = %@", email.text!, pswd.text!)
        userRequest.predicate = predicate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let delegate = appDelegate.persistentContainer.viewContext
        do {
            var allUser = try (delegate.fetch(userRequest))
            if allUser.count > 0 {
                Global.USER_INFO = allUser[0]
                let guessView = self.storyboard?.instantiateViewController(withIdentifier: "guestController") as!   GuestController
                guessView.modalPresentationStyle = .fullScreen
                self.present(guessView, animated: true)
            } else {
                toast(msg: "Error username or password")
            }
        } catch {
            print("Fetch failed")
            return
        }
        
    }
    
    @IBAction func onNewAccount(_ sender: Any) {
        let alert = UIAlertController(title: "CREAT ACCONT", message: nil, preferredStyle: .alert)
        
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "Username"
        }
        //
        alert.addTextField { (textFieldPass) in
            textFieldPass.placeholder = "Password"
            textFieldPass.isSecureTextEntry = true
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak alert] (_) in
            alert?.dismiss(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            var username = alert?.textFields![0].text ?? ""
            username = username.trimmingCharacters(in: .whitespacesAndNewlines)
            var password = alert?.textFields![1].text ?? ""
            password = password.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if username.isEmpty || password.isEmpty {
                self.toast(msg: "Empty username or password not allowed.")
                return
            }
            
            let userRequest: NSFetchRequest<User> = User.fetchRequest()
            let predicate = NSPredicate(format: "username = %@", username)
            userRequest.predicate = predicate
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let delegate = appDelegate.persistentContainer.viewContext
            do {
                let allUser = try (delegate.fetch(userRequest))
                if allUser.count > 0 {
                    self.toast(msg: "Duplicate username !")
                } else {
                    let user = User(context: delegate)
                    user.username = username
                    user.password = password
                    delegate.insert(user)
                    try delegate.save()
                    self.toast("Sucess", msg: "Create Account Successfully.")
                }
            } catch {
                print("Fetch failed")
                return
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func toast(_ title: String = "Error", msg : String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in alert.dismiss(animated: true)}))
        self.present(alert, animated: true, completion: nil)
    }
}

