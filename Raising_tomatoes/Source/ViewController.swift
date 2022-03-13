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
    @IBOutlet weak var endOfTheDayLabel: UILabel!
    let pedoMeter = CMPedometer()
    let activityManager = CMMotionActivityManager()
    var stepCount = 0
    var extraStepCount = 0
    var levelState = "LV2"
    var dateFlag = 0 //하루에 한번씩 체크할 샘플 데이트 저장
    
    let userNotificationCenter = UNUserNotificationCenter.current() //앱 또는 앱 확장에 대한 공유 사용자 알림 센터 개체를 반환
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "ACCchildrenheartOTF-Regular", size: 12.0)!]
                UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        
        //MARK: - 성공현황 UserDefault에 저장
        UserDefaults.standard.set(Success.state, forKey: "SuccessState")
        
        Success.state = UserDefaults.standard.stringArray(forKey: "SuccessState") ?? [String]()
        
        extraStepCount = Int(UserDefaults.standard.string(forKey: "stepCount") ?? "") ?? 0 //앱 종료후 다시 실행 시킬 때 기존의 있던값을 변수에 저장

        //MARK: - UserDefaults에 저장된 데이터 할당
        walkCount.text = "\(UserDefaults.standard.string(forKey: "stepCount") ?? "0") 걸음"
    
        //MARK: - 이미지 변경
        stepToImage(stepCount: extraStepCount)
        
        //MARK: - 푸쉬알림 함수
        requestNotificationAuthorization()
        
        //tabbar selected index 무력화
        CheckFlag.checkTabbarIndex = 1

        
        //MARK: - 현재 날짜
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let current_date_string = formatter.string(from: Date())
        Today.yyyymmdd = current_date_string
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

    func sendLevel(seconds: Double) { // 알림 전송 함수
        let notificationContent = UNMutableNotificationContent()

            notificationContent.title = "토마토의 성장"
            notificationContent.body = "\(levelState). 씨앗으로 성장했습니다."

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
       if stepCount < 100 && stepCount > 0 {
           tomatoImage.image = UIImage(named: "2")
           levelName.text = "LV2. 씨앗"
           growthPercent.text = "다음 성장까지 \(round((Double(stepCount) / 100.0) * 100))%"
           print(stepCount / 100)
           
           //MARK: - 푸시 알람
           if UserDefaults.standard.bool(forKey: "SwitchState") == true {
               levelState = "LV2"
               sendLevel(seconds: 1)
           }

//           sendNotification(seconds: 1)
       } else if stepCount < 300 && stepCount > 99  {
           tomatoImage.image = UIImage(named: "3")
           levelName.text = "LV3. 뿌리"
           growthPercent.text = "다음 성장까지 \(round((Double(stepCount) / 300.0) * 100))%"
           
           //MARK: - 푸시 알람
           if UserDefaults.standard.bool(forKey: "SwitchState") == true {
               levelState = "LV3"
               sendLevel(seconds: 1)
           }
           
       } else if stepCount < 600 && stepCount > 299  {
           tomatoImage.image = UIImage(named: "4")
           levelName.text = "LV4. 뿌리뿌리"
           growthPercent.text = "다음 성장까지 \(round((Double(stepCount) / 600.0) * 100))%"
           
           //MARK: - 푸시 알람
           if UserDefaults.standard.bool(forKey: "SwitchState") == true {
               levelState = "LV4"
               sendLevel(seconds: 1)
           }
           
       } else if stepCount < 1000 && stepCount > 599  {
           tomatoImage.image = UIImage(named: "5")
           levelName.text = "LV5. 아기새싹"
           growthPercent.text = "다음 성장까지 \(round((Double(stepCount) / 1000.0) * 100))%"
           
           //MARK: - 푸시 알람
           if UserDefaults.standard.bool(forKey: "SwitchState") == true {
               levelState = "LV5"
               sendLevel(seconds: 1)
           }
           
       } else if stepCount < 1500 && stepCount > 999  {
            tomatoImage.image = UIImage(named: "6")
            levelName.text = "LV6. 자란 새싹"
           growthPercent.text = "다음 성장까지 \(round((Double(stepCount) / 1500.0) * 100))%"
           
           //MARK: - 푸시 알람
           if UserDefaults.standard.bool(forKey: "SwitchState") == true {
               levelState = "LV6"
               sendLevel(seconds: 1)
           }
           
       } else if stepCount < 2500 && stepCount > 1499  {
            tomatoImage.image = UIImage(named: "7")
            levelName.text = "LV7. 많이 자란 새싹"
           growthPercent.text = "다음 성장까지 \(round((Double(stepCount) / 2500.0) * 100))%"
           
           //MARK: - 푸시 알람
           if UserDefaults.standard.bool(forKey: "SwitchState") == true {
               levelState = "LV7"
               sendLevel(seconds: 1)
           }
           
       } else if stepCount < 3500 && stepCount > 2499  {
            tomatoImage.image = UIImage(named: "8")
            levelName.text = "LV8. 큰 새싹"
           growthPercent.text = "다음 성장까지 \(round((Double(stepCount) / 3500.0) * 100))%"
           
           //MARK: - 푸시 알람
           if UserDefaults.standard.bool(forKey: "SwitchState") == true {
               levelState = "LV8"
               sendLevel(seconds: 1)
           }
           
       } else if stepCount < 4500 && stepCount > 3499  {
           tomatoImage.image = UIImage(named: "9")
           levelName.text = "LV9. 봉오리"
           growthPercent.text = "다음 성장까지 \(round((Double(stepCount) / 4500.0) * 100))%"
           
           //MARK: - 푸시 알람
           if UserDefaults.standard.bool(forKey: "SwitchState") == true {
               levelState = "LV9"
               sendLevel(seconds: 1)
           }
           
       } else if stepCount < 6500 && stepCount > 4499  {
           tomatoImage.image = UIImage(named: "10")
           levelName.text = "LV10. 꽃"
           growthPercent.text = "다음 성장까지 \(round((Double(stepCount) / 6500.0) * 100))%"
           
           //MARK: - 푸시 알람
           if UserDefaults.standard.bool(forKey: "SwitchState") == true {
               levelState = "LV10"
               sendLevel(seconds: 1)
           }
           
       } else if stepCount < 7500 && stepCount > 6499  {
           tomatoImage.image = UIImage(named: "11")
           levelName.text = "LV11. 아기 토마토"
           growthPercent.text = "다음 성장까지 \(round((Double(stepCount) / 7500.0) * 100))%"
           
           //MARK: - 푸시 알람
           if UserDefaults.standard.bool(forKey: "SwitchState") == true {
               levelState = "LV11"
               sendLevel(seconds: 1)
           }
           
       } else if stepCount < 10000 && stepCount > 7499  {
           tomatoImage.image = UIImage(named: "12")
           levelName.text = "LV12. 어린이 토마토"
           growthPercent.text = "다음 성장까지 \(round((Double(stepCount) / 10000.0) * 100))%"
           
           //MARK: - 푸시 알람
           if UserDefaults.standard.bool(forKey: "SwitchState") == true {
               levelState = "LV12"
               sendLevel(seconds: 1)
           }
           
       } else if stepCount > 9999   {
           tomatoImage.image = UIImage(named: "13")
           levelName.text = "LV13. 토마토"
           growthPercent.text = "목표달성 완료"
           
           //MARK: - 푸시 알람
           if UserDefaults.standard.bool(forKey: "SwitchState") == true {
               levelState = "LV13"
               sendLevel(seconds: 1)
           }
           
           
       }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //MARK: - 특정 날짜 저장
        
        let form = DateFormatter()
        form.dateFormat = "yyyyMMdd"
        let currentDate = form.string(from: Date())
        print(currentDate)
        
        if dateFlag == 0 {
            UserDefaults.standard.set(currentDate, forKey: "Date") //비교 날짜를 저장
            
            dateFlag = 1 //저장 비허용으로 만들기
        }
        
        //MARK: - 날짜가 변경되면 초기화
        if UserDefaults.standard.string(forKey: "Date") ?? "0" != currentDate {
            print("초기화")
            endOfTheDayLabel.text = ""
            UserDefaults.standard.set(0, forKey: "stepCount")
            tomatoImage.image = UIImage(named: "1")
            levelName.text = "LV1. 빈 화분"
            self.walkCount.text = "0 걸음"
            growthPercent.text = "다음 성장까지 0.0%"
        }
        
        
        //MARK: - 특정 시간이 되면 하루 마무리 멘트
        let formm = DateFormatter()
        formm.dateFormat = "HHmm"
        let currentTime = formm.string(from: Date())

        Today.time = currentTime
        if currentTime == "2300" {
            endOfTheDayLabel.text = "총 \(UserDefaults.standard.string(forKey: "stepCount") ?? "0") 걸음으로 하루를 마무리 하셨습니다."

            print(UserDefaults.standard.string(forKey: "stepCount") ?? "0")

            if self.stepCount > 9999 {
                Success.state[Today.day + 1] = "성공"
                UserDefaults.standard.set(Success.state, forKey: "SuccessState")
            } else {
                Success.state[Today.day + 1] = "실패"
                UserDefaults.standard.set(Success.state, forKey: "SuccessState")
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
                            self.walkCount.text = "\(UserDefaults.standard.string(forKey: "stepCount") ?? "0") 걸음"
//                            print(UserDefaults.standard.string(forKey: "stepCount"))
                            print(self.stepCount)
                        
                            self.stepToImage(stepCount: self.stepCount)
                            
                            
                            
                            
                        }
                    }
                }
                
            }
        }
    }
    
//    @IBAction func clear(_ sender: Any) {
//        UserDefaults.standard.set(Success.clear, forKey: "SuccessState")
//        Success.state = UserDefaults.standard.stringArray(forKey: "SuccessState") ?? [String]()
//        print(Success.state)
//    }
//    
//    @IBAction func add(_ sender: Any) {
//        Success.state[Today.day + 1] = "성공"
//        UserDefaults.standard.set(Success.state, forKey: "SuccessState")
//        print(Success.state)
//    }
    

    
}
