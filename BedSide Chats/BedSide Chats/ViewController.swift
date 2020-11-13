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
    
    func toast(_ title: String = "Error", msg : String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in alert.dismiss(animated: true)}))
        self.present(alert, animated: true, completion: nil)
    }
}

