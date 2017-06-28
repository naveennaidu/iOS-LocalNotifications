//
//  ViewController.swift
//  iOS-LocalNotifications
//
//  Created by Naveen Naidu  on 28/06/17.
//  Copyright © 2017 Naveen Naidu . All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {(granted, error) in
            if granted {
                print("Notification access granted")
            } else{
                print(error?.localizedDescription as Any)
            }
        }
    
    )
    }
    
    @IBAction func notifyBtnTapped(sender: UIButton){
        scheduleNotification(inSeconds: 2, completion: {success in
            if success{
                print("Succesfully schedule")
            } else {
                print("Error")
            }
        })
    }
    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()){
        
        let myImage = "giphy-downsized"
        guard let imageUrl = Bundle.main.url(forResource: myImage, withExtension: "gif") else {
            completion(false)
            return
        }
        var attachment: UNNotificationAttachment
        
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageUrl, options: .none)
        
        let notif = UNMutableNotificationContent()
        
        // ONLY FOR EXTENSION
        notif.categoryIdentifier = "myNotificationCategory"
        
        
        notif.title = "New Notification"
        notif.subtitle = "These are great!"
        notif.body = "The new notification"

        notif.attachments = [attachment]
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
            if error != nil{
                print(error as Any)
                completion(false)
            } else{
                completion(true)
            }
        })
    }
}

