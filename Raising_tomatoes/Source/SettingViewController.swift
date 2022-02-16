//
//  SettingViewController.swift
//  Raising_tomatoes
//
//  Created by 준수김 on 2022/02/14.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var pushNotificationSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onAndOff(_ sender: Any) {
//        if pushNotificationSwitch.isOn == true {
//            UIApplication.shared.registerForRemoteNotifications() //푸쉬알람 허용
//            print("허용")
//        } else {
//            UIApplication.shared.unregisterForRemoteNotifications() //푸쉬알람 비허용
//            print("비허용")
//        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
