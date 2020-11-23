//
//  TopicsController.swift
//  BedSide Chats
//
//  Created by Owen on 11/13/20.
//

import UIKit

class TopicsController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @objc func fabTapped(_ button: UIButton) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "CREAT TOPIC", message: nil, preferredStyle: .alert)
        
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "Enter topic name, No duplicate!"
        }
//
//        alert.addTextField { (textFieldPass) in
//            textFieldPass.placeholder = "Password"
//            textFieldPass.isSecureTextEntry = true
//        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak alert] (_) in
            alert?.dismiss(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            var topicText = alert?.textFields![0].text ?? ""
            topicText = topicText.trimmingCharacters(in: .whitespacesAndNewlines)
            if (topicText.isEmpty) {
                print("Empty")
                self.toast(msg: "Empty topic not allowed.")
                return
            }
            
            // check if already in data
            for i in self.allTopics {
                if (i.topic! == topicText) {
                    self.toast(msg: "Duplicate topic not allowed.")
                    return
                }
            }
            
            // todo: add topic
            guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                    return
            }
            
            let managedContext =
                appDelegate.persistentContainer.viewContext
            let entity =
                NSEntityDescription.entity(forEntityName: "Topic",
                                           in: managedContext)!
            let person = NSManagedObject(entity: entity,
                                         insertInto: managedContext)
            person.setValue(topicText, forKeyPath: "topic")
            do {
                try managedContext.save()
                print("saved")
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            self.fetchData()
        }))
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func toast(msg : String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in alert.dismiss(animated: true)}))
        self.present(alert, animated: true, completion: nil)
    }
    
}
