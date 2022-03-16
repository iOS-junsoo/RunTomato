//
//  SettingViewController.swift
//  Raising_tomatoes
//
//  Created by 준수김 on 2022/02/14.
//

import UIKit
import UserNotifications


class SettingViewController: UIViewController {

    @IBOutlet weak var pushNotificationSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        pushNotificationSwitch.isOn = UserDefaults.standard.bool(forKey: "SwitchState")
    }

    @IBAction func onAndOff(_ sender: Any) {
//        if pushNotificationSwitch.isOn == true {
//            UserDefaults.standard.set(pushNotificationSwitch.isOn, forKey: "SwitchState")
//        } else {
//            UIApplication.shared.unregisterForRemoteNotifications() //푸쉬알람 비허용
//            print("비허용")
//            UserDefaults.standard.set(pushNotificationSwitch.isOn, forKey: "SwitchState")
//        }
        
        UserDefaults.standard.set(pushNotificationSwitch.isOn, forKey: "SwitchState")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func Exit(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
