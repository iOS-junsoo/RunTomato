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
    var onePsuh1 = 0 //푸쉬알람을 한번만 실행하도록
    var onePsuh2 = 0
    var onePsuh3 = 0
    var onePsuh4 = 0
    var onePsuh5 = 0
    var onePsuh6 = 0
    var onePsuh7 = 0
    var onePsuh8 = 0
    var onePsuh9 = 0
    var onePsuh10 = 0
    var onePsuh11 = 0
    var onePsuh12 = 0
    let userNotificationCenter = UNUserNotificationCenter.current() //앱 또는 앱 확장에 대한 공유 사용자 알림 센터 개체를 반환
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - 성공현황 UserDefault에 저장
        UserDefaults.standard.set(Success.state, forKey: "SuccessState")
        
        Success.state = UserDefaults.standard.stringArray(forKey: "SuccessState") ?? [String]()

        //MARK: - UserDefaults에 저장된 데이터 할당
        walkCount.text = "\(UserDefaults.standard.string(forKey: "stepCount") ?? "0") 걸음"
    
        //MARK: - 이미지 변경
//        stepToImage(stepCount: extraStepCount)
//        print("extraStepCount: \(extraStepCount)")
        
        //MARK: - 푸쉬알림 허용 함수 호출
        requestNotificationAuthorization()
        
        //tabbar selected index 무력화
        CheckFlag.checkTabbarIndex = 1
        
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
        
//       print("함수:\(stepCount)")
    if stepCount < 100 && stepCount > 0 {
        tomatoImage.image = UIImage(named: "2")
        levelName.text = "LV2. 씨앗"
        growthPercent.text = "다음 성장까지 \(String(format: "%.1f", (Double(stepCount) / 100.0) * 100))%"
//           print(stepCount / 100)
           
        if onePsuh1 == 0 {
        //MARK: - 푸시 알람
        if UserDefaults.standard.bool(forKey: "SwitchState") == true {
            levelState = "LV2"
            sendLevel(seconds: 1)
        }
            onePsuh1 = 1
        }

        } else if stepCount < 300 && stepCount > 99  {
           
           tomatoImage.image = UIImage(named: "3")
           levelName.text = "LV3. 뿌리"
           growthPercent.text = "다음 성장까지 \(String(format: "%.1f", (Double(stepCount - 100) / 200.0) * 100))%"
           
           if onePsuh2 == 0 {
               //MARK: - 푸시 알람
               if UserDefaults.standard.bool(forKey: "SwitchState") == true {
                   levelState = "LV3"
                   sendLevel(seconds: 1)
               }
               onePsuh2 = 1
           }
           
        } else if stepCount < 600 && stepCount > 299  {
           

           tomatoImage.image = UIImage(named: "4")
           levelName.text = "LV4. 뿌리뿌리"
           growthPercent.text = "다음 성장까지 \(String(format: "%.1f", (Double(stepCount - 300) / 300.0) * 100))%"
           
           if onePsuh3 == 0 {
               //MARK: - 푸시 알람
               if UserDefaults.standard.bool(forKey: "SwitchState") == true {
                   levelState = "LV4"
                   sendLevel(seconds: 1)
               }
               onePsuh3 = 1
           }
           
        } else if stepCount < 1000 && stepCount > 599  {
            

           tomatoImage.image = UIImage(named: "5")
           levelName.text = "LV5. 아기새싹"
           growthPercent.text = "다음 성장까지 \(String(format: "%.1f", (Double(stepCount) - 600 / 400.0) * 100))%"
           if onePsuh4 == 0 {
           //MARK: - 푸시 알람
               if UserDefaults.standard.bool(forKey: "SwitchState") == true {
                   levelState = "LV5"
                   sendLevel(seconds: 1)
               }
               onePsuh4 = 1
           }
           
        } else if stepCount < 1500 && stepCount > 999  {
            

            tomatoImage.image = UIImage(named: "6")
            levelName.text = "LV6. 자란 새싹"
        
           growthPercent.text = "다음 성장까지 \(String(format: "%.1f", (Double(stepCount) - 1000 / 500.0) * 100))%"
           if onePsuh5 == 0 {
               //MARK: - 푸시 알람
               if UserDefaults.standard.bool(forKey: "SwitchState") == true {
                   levelState = "LV6"
                   sendLevel(seconds: 1)
               }
               onePsuh5 = 1
           }
           
        } else if stepCount < 2500 && stepCount > 1499  {
           

            tomatoImage.image = UIImage(named: "7")
            levelName.text = "LV7. 많이 자란 새싹"

           growthPercent.text = "다음 성장까지 \(String(format: "%.1f", (Double(stepCount) - 1500 / 1000.0) * 100))%"
           if onePsuh6 == 0 {
           //MARK: - 푸시 알람
               if UserDefaults.standard.bool(forKey: "SwitchState") == true {
                   levelState = "LV7"
                   sendLevel(seconds: 1)
               }
               onePsuh6 = 1
           }
           
        } else if stepCount < 3500 && stepCount > 2499  {
            

            tomatoImage.image = UIImage(named: "8")
            levelName.text = "LV8. 큰 새싹"
           growthPercent.text = "다음 성장까지 \(String(format: "%.1f", (Double(stepCount) - 2500 / 1000.0) * 100))%"
           if onePsuh7 == 0 {
               //MARK: - 푸시 알람
               if UserDefaults.standard.bool(forKey: "SwitchState") == true {
                   levelState = "LV8"
                   sendLevel(seconds: 1)
               }
               onePsuh7 = 1
           }
           
        } else if stepCount < 4500 && stepCount > 3499  {
            

           tomatoImage.image = UIImage(named: "9")
           levelName.text = "LV9. 봉오리"
        
           growthPercent.text = "다음 성장까지 \(String(format: "%.1f", (Double(stepCount) - 3500 / 1000.0) * 100))%"
           if onePsuh8 == 0 {
           //MARK: - 푸시 알람
               if UserDefaults.standard.bool(forKey: "SwitchState") == true {
                   levelState = "LV9"
                   sendLevel(seconds: 1)
               }
               onePsuh8 = 1
           }
           
        } else if stepCount < 5500 && stepCount > 4499  {
            

           tomatoImage.image = UIImage(named: "10")
           levelName.text = "LV10. 꽃"
        
           growthPercent.text = "다음 성장까지 \(String(format: "%.1f", (Double(stepCount) - 4500 / 1000.0) * 100))%"
           if onePsuh9 == 0 {
               //MARK: - 푸시 알람
               if UserDefaults.standard.bool(forKey: "SwitchState") == true {
                   levelState = "LV10"
                   sendLevel(seconds: 1)
               }
               onePsuh9 = 1
           }
           
        } else if stepCount < 7500 && stepCount > 5499  {
            
           tomatoImage.image = UIImage(named: "11")
           levelName.text = "LV11. 아기 토마토"
           
           growthPercent.text = "다음 성장까지 \(String(format: "%.1f", (Double(stepCount) - 5500 / 2000.0) * 100))%"
           if onePsuh10 == 0 {
           //MARK: - 푸시 알람
               if UserDefaults.standard.bool(forKey: "SwitchState") == true {
                   levelState = "LV11"
                   sendLevel(seconds: 1)
               }
               onePsuh10 = 1
           }
           
        } else if stepCount < 10000 && stepCount > 7499  {
           

           tomatoImage.image = UIImage(named: "12")
           levelName.text = "LV12. 어린이 토마토"

           growthPercent.text = "다음 성장까지 \(String(format: "%.1f", (Double(stepCount) - 7500 / 2500.0) * 100))%"
           if onePsuh11 == 0 {
               //MARK: - 푸시 알람
               if UserDefaults.standard.bool(forKey: "SwitchState") == true {
                   levelState = "LV12"
                   sendLevel(seconds: 1)
               }
               onePsuh11 = 1
           }
        } else if stepCount > 9999   {
            

           tomatoImage.image = UIImage(named: "13")
           levelName.text = "LV13. 토마토"
           growthPercent.text = "목표달성 완료"
           
           if onePsuh12 == 0 {
               //MARK: - 푸시 알람
               if UserDefaults.standard.bool(forKey: "SwitchState") == true {
                   levelState = "LV13"
                   sendLevel(seconds: 1)
               }
               onePsuh12 = 1
           }

       }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        extraStepCount = Int(UserDefaults.standard.string(forKey: "stepCount") ?? "") ?? 0 //앱 종료후 다시 실행 시킬 때 기존의 있던값을 변수에 저장
        
        
        //MARK: - 현재 날짜 메모지 날짜에 입력
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let current_date_string = formatter.string(from: Date())
        Today.yyyymmdd = current_date_string
        date.text = current_date_string
        
        //MARK: - 앱을 종료했다가 다시 시작했을 때
        stepToImage(stepCount: Int(UserDefaults.standard.string(forKey: "stepCount") ?? "0") ?? 0)
        
        
        //MARK: - 특정 날짜 저장
        
        let form = DateFormatter()
        form.dateFormat = "yyyyMMdd"
        let currentDate = form.string(from: Date())
        
//        let form = DateFormatter()
//        form.dateFormat = "HHmm"
//        let currentDate = form.string(from: Date())

        

        if dateFlag == 0 { //falg가 0이면 비교날짜를 저장하고 flag를 1로 만든다.
            UserDefaults.standard.set(currentDate, forKey: "Date") //비교 날짜를 저장
            print("--change date--")
            dateFlag = 1 //저장 비허용으로 만들기
            
        }
        
//        UserDefaults.standard.set(Success.clear, forKey: "SuccessStamp")
        
        //MARK: - 날짜가 변경되면 '초기화'
        if UserDefaults.standard.string(forKey: "Date") ?? "0" != currentDate {
                
            print("--reset--")
            endOfTheDayLabel.text = ""
            UserDefaults.standard.set(0, forKey: "stepCount")
            tomatoImage.image = UIImage(named: "1")
            levelName.text = "LV1. 빈 화분"
            self.walkCount.text = "0 걸음"
            growthPercent.text = "다음 성장까지 0.0%"
            dateFlag = 0 //다시 허용으로
            
            if self.stepCount > 9999 { //9999
                Success.state[Today.day + 1] = "성공" //성공여부 입력
                UserDefaults.standard.set(Success.state, forKey: "SuccessState") //성공여부 배열 UserDefaults에 저장
                
                Success.stamp[Today.day + 1] = "토마토 스탬프"
                UserDefaults.standard.set(Success.stamp, forKey: "SuccessStamp")
                
            } else {
                Success.state[Today.day + 1] = "실패"
                UserDefaults.standard.set(Success.state, forKey: "SuccessState")
            }
            
            onePsuh1 = 0
            onePsuh2 = 0
            onePsuh3 = 0
            onePsuh4 = 0
            onePsuh5 = 0
            onePsuh6 = 0
            onePsuh7 = 0
            onePsuh8 = 0
            onePsuh9 = 0
            onePsuh10 = 0
            onePsuh11 = 0
            onePsuh12 = 0
            
            
            
        }
        
        print("유저디폴트 \(UserDefaults.standard.string(forKey: "Date"))")
        print("현재 시간 \(currentDate)")
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        //MARK: - 특정 시간이 되면 하루 마무리 멘트
        let formm = DateFormatter()
        formm.dateFormat = "HHmm"
        let currentTime = formm.string(from: Date())
        
        let currentTimeisdone = Int(currentTime)

        Today.time = currentTime
        if currentTimeisdone ?? 0 > 2300 && currentTimeisdone ?? 0 < 2400 {
            endOfTheDayLabel.text = "총 \(UserDefaults.standard.string(forKey: "stepCount") ?? "0") 걸음으로 하루를 마무리 하셨습니다."
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
//                            print(self.stepCount)
                        
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
   
//    @IBAction func add(_ sender: Any) {
//        Success.state[Today.day + 1] = "성공"
//        UserDefaults.standard.set(Success.state, forKey: "SuccessState")
//        print(Success.state)
//    }
    
  
    
    
}
