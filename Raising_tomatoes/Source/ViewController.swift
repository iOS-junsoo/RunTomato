//
//  ViewController.swift
//  Raising_tomatoes
//
//  Created by 준수김 on 2022/02/12.
//

import UIKit
import CoreMotion
import UserNotifications

class ViewController: UIViewController {
    @IBOutlet weak var levelName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var walkCount: UILabel!
    @IBOutlet weak var growthPercent: UILabel!
    @IBOutlet weak var tomatoImage: UIImageView!
    @IBOutlet weak var stepState: UILabel!
    let pedoMeter = CMPedometer()
    let activityManager = CMMotionActivityManager()
    var stepCount = 0
    
    let userNotificationCenter = UNUserNotificationCenter.current() //앱 또는 앱 확장에 대한 공유 사용자 알림 센터 개체를 반환
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //MARK: - 푸쉬알림 함수
        requestNotificationAuthorization()
        
        
        
        //tabbar selected index 무력화
        CheckFlag.checkTabbarIndex = 1
        
       //성장 화면 초기값 설정 - UserDefault 적용시 변경 예정
        self.tomatoImage.image = UIImage(named: "1")
        self.levelName.text = "LV1. 빈 화분"
        
        
        
        //MARK: - 현재 날짜
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let current_date_string = formatter.string(from: Date())
        date.text = current_date_string
        
        
        
        
        
        
    }
    
    func requestNotificationAuthorization() { // 알림 권한 요청 함수
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
                if let error = error {
                    print("Error: \(error)")
                }
            }
    }

    func sendNotification(seconds: Double) { // 알림 전송 함수
        let notificationContent = UNMutableNotificationContent()

            notificationContent.title = "토마토의 성장"
            notificationContent.body = "현재 LV2. 씨앗으로 성장했습니다."

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
            let request = UNNotificationRequest(identifier: "testNotification",
                                                content: notificationContent,
                                                trigger: trigger)

            userNotificationCenter.add(request) { error in
                if let error = error {
                    print("Notification Error: ", error)
                }
            }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        //MARK: - 걷는지, 뛰는지
        if CMMotionActivityManager.isActivityAvailable() {
            self.activityManager.startActivityUpdates(to: OperationQueue.main) { (data) in
                DispatchQueue.main.async {
                    if let activity = data {
                        if activity.walking == true {
//                            print("걷는 중")
                            self.stepState.text = "-운동 중-"
                        } else if activity.running == true {
//                            print("뛰는 중")
                            self.stepState.text = "-운동 중-"
                        } else if activity.stationary == true {
//                            print("쉬는 중")
                            self.stepState.text = "-휴식 중-"
                        } else if activity.cycling == true {
//                            print("자전거 타는 중")
                        }
                    }
                }
            }
        }
        
       //MARK: - 걸음수
        if CMPedometer.isStepCountingAvailable() {
            self.pedoMeter.startUpdates(from: Date()) { (data, error) in
                if error == nil {
                    if let response = data {
                        DispatchQueue.main.async {
                            self.walkCount.text = "\(response.numberOfSteps) 걸음"
                            print(response.numberOfSteps)
                            self.stepCount = Int(response.numberOfSteps)
                            if self.stepCount < 10 && self.stepCount > 0 {
                                self.tomatoImage.image = UIImage(named: "2")
                                self.levelName.text = "LV2. 씨앗"
                                self.sendNotification(seconds: 1)
                            } else if self.stepCount < 20 && self.stepCount > 9  {
                                self.tomatoImage.image = UIImage(named: "3")
                                self.levelName.text = "LV3. 뿌리"
                            } else if self.stepCount < 30 && self.stepCount > 19  {
                                self.tomatoImage.image = UIImage(named: "4")
                                self.levelName.text = "LV4. 뿌리뿌리"
                            } else if self.stepCount < 40 && self.stepCount > 29  {
                                self.tomatoImage.image = UIImage(named: "5")
                                self.levelName.text = "LV5. 아기새싹"
                            } else if self.stepCount < 50 && self.stepCount > 39  {
                                self.tomatoImage.image = UIImage(named: "6")
                                self.levelName.text = "LV6. 자란 새싹"
                            } else if self.stepCount < 60 && self.stepCount > 49  {
                                self.tomatoImage.image = UIImage(named: "7")
                                self.levelName.text = "LV7. 많이 자란 새싹"
                            } else if self.stepCount < 70 && self.stepCount > 59  {
                                self.tomatoImage.image = UIImage(named: "8")
                                self.levelName.text = "LV8. 큰 새싹"
                            } else if self.stepCount < 80 && self.stepCount > 69  {
                                self.tomatoImage.image = UIImage(named: "9")
                                self.levelName.text = "LV9. 봉오리"
                            } else if self.stepCount < 90 && self.stepCount > 79  {
                                self.tomatoImage.image = UIImage(named: "10")
                                self.levelName.text = "LV10. 꽃"
                            }
                        }
                    }
                }
                
            }
        }
    }
    
    
}

