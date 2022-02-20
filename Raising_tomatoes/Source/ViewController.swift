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
    var extraStepCount = 0
    
    let userNotificationCenter = UNUserNotificationCenter.current() //앱 또는 앱 확장에 대한 공유 사용자 알림 센터 개체를 반환
    
    override func viewDidLoad() {
        super.viewDidLoad()
        extraStepCount = Int(UserDefaults.standard.string(forKey: "stepCount") ?? "") ?? 0 //앱 종료후 다시 실행 시킬 때 기존의 있던값을 변수에 저장
        
        //MARK: - 걸음수 초기화 - 조건문은 이후에 자정이 되면 실행되는 걸로 수정
        if Int(UserDefaults.standard.string(forKey: "stepCount") ?? "0 걸음") ?? 0 > 100 {
            UserDefaults.standard.set(0, forKey: "stepCount")
            tomatoImage.image = UIImage(named: "1")
            levelName.text = "LV1. 빈 화분"
            print(UserDefaults.standard.string(forKey: "stepCount") ?? "0 걸음")
        }
        
        
        
        //MARK: - UserDefaults에 저장된 데이터 할당
        walkCount.text = "\(UserDefaults.standard.string(forKey: "stepCount") ?? "0 걸음") 걸음"
    
        //MARK: - 이미지 변경
        stepToImage(stepCount: extraStepCount)
       
        
        
        //MARK: - 푸쉬알림 함수
        requestNotificationAuthorization()
        
        
        
        //tabbar selected index 무력화
        CheckFlag.checkTabbarIndex = 1
        
//       //성장 화면 초기값 설정 - UserDefault 적용시 변경 예정
//        self.tomatoImage.image = UIImage(named: "1")
//        self.levelName.text = "LV1. 빈 화분"
        
        
        
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
    
    //MARK: - 걸음수에 따른 이미지 변화
    func stepToImage(stepCount: Int) {
        
        print("함수:\(stepCount)")
       if stepCount < 10 && stepCount > 0 {
           tomatoImage.image = UIImage(named: "2")
           levelName.text = "LV2. 씨앗"
           sendNotification(seconds: 1)
       } else if stepCount < 20 && stepCount > 9  {
           tomatoImage.image = UIImage(named: "3")
           levelName.text = "LV3. 뿌리"
       } else if stepCount < 30 && stepCount > 19  {
           tomatoImage.image = UIImage(named: "4")
           levelName.text = "LV4. 뿌리뿌리"
       } else if stepCount < 40 && stepCount > 29  {
           tomatoImage.image = UIImage(named: "5")
           levelName.text = "LV5. 아기새싹"
       } else if stepCount < 50 && stepCount > 39  {
            tomatoImage.image = UIImage(named: "6")
            levelName.text = "LV6. 자란 새싹"
       } else if stepCount < 60 && stepCount > 49  {
            tomatoImage.image = UIImage(named: "7")
            levelName.text = "LV7. 많이 자란 새싹"
       } else if stepCount < 70 && stepCount > 59  {
            tomatoImage.image = UIImage(named: "8")
            levelName.text = "LV8. 큰 새싹"
       } else if stepCount < 80 && stepCount > 69  {
           tomatoImage.image = UIImage(named: "9")
           levelName.text = "LV9. 봉오리"
       } else if stepCount < 90 && stepCount > 79  {
           tomatoImage.image = UIImage(named: "10")
           levelName.text = "LV10. 꽃"
       } else if stepCount < 100 && stepCount > 89  {
           tomatoImage.image = UIImage(named: "11")
           levelName.text = "LV11. 아기 토마토"
       } else if stepCount < 110 && stepCount > 99  {
           tomatoImage.image = UIImage(named: "12")
           levelName.text = "LV12. 어린이 토마토"
       } else if stepCount < 120   {
           tomatoImage.image = UIImage(named: "13")
           levelName.text = "LV13. 토마토"
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
                            //extraStepCount는 앱을 실행했을 때 걸음 수가 이미 있는경우 stepCount에 더해주기 위해서 만듦
                            self.stepCount = Int(response.numberOfSteps) + self.extraStepCount

                            //MARK: - UserDefaults에 걸음수 저장
                            UserDefaults.standard.set(self.stepCount, forKey: "stepCount")
                            self.walkCount.text = "\(UserDefaults.standard.string(forKey: "stepCount") ?? "0 걸음") 걸음"
//                            print(UserDefaults.standard.string(forKey: "stepCount"))
                            print(self.stepCount)
                        
                            self.stepToImage(stepCount: self.stepCount)
                            
                        }
                    }
                }
                
            }
        }
    }
    
    
}

//if stepCount < 10 && self.stepCount > 0 {
//    self.tomatoImage.image = UIImage(named: "2")
//    self.levelName.text = "LV2. 씨앗"
//    self.sendNotification(seconds: 1)
//} else if self.stepCount < 20 && self.stepCount > 9  {
//    self.tomatoImage.image = UIImage(named: "3")
//    self.levelName.text = "LV3. 뿌리"
//} else if self.stepCount < 30 && self.stepCount > 19  {
//    self.tomatoImage.image = UIImage(named: "4")
//    self.levelName.text = "LV4. 뿌리뿌리"
//} else if self.stepCount < 40 && self.stepCount > 29  {
//    self.tomatoImage.image = UIImage(named: "5")
//    self.levelName.text = "LV5. 아기새싹"
//} else if self.stepCount < 50 && self.stepCount > 39  {
//    self.tomatoImage.image = UIImage(named: "6")
//    self.levelName.text = "LV6. 자란 새싹"
//} else if self.stepCount < 60 && self.stepCount > 49  {
//    self.tomatoImage.image = UIImage(named: "7")
//    self.levelName.text = "LV7. 많이 자란 새싹"
//} else if self.stepCount < 70 && self.stepCount > 59  {
//    self.tomatoImage.image = UIImage(named: "8")
//    self.levelName.text = "LV8. 큰 새싹"
//} else if self.stepCount < 80 && self.stepCount > 69  {
//    self.tomatoImage.image = UIImage(named: "9")
//    self.levelName.text = "LV9. 봉오리"
//} else if self.stepCount < 90 && self.stepCount > 79  {
//    self.tomatoImage.image = UIImage(named: "10")
//    self.levelName.text = "LV10. 꽃"
//}
