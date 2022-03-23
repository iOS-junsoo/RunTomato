//
//  SceneDelegate.swift
//  Raising_tomatoes
//
//  Created by 준수김 on 2022/02/12.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var checkFlag = true
    var dateFlag = 0 //하루에 한번씩 체크할 샘플 데이트 저장
    var currentDate = ""
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        print("sceneDidDisconnect") //-> 앱이 완전히 종료
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        print("sceneDidBecomeActive") //-> 앱이 다시 활성화 상태로
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print("sceneWillResignActive") //-> 앱이 비활성화 상태로
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
        
        
        print("sceneWillEnterForeground") //-> 앱이 Foreground에
        
        let form = DateFormatter()
        form.dateFormat = "yyyyMMdd" //"yyyyMMdd" "HHmm"
        currentDate = form.string(from: Date())
        
        if UserDefaults.standard.string(forKey: "Date") ?? "0" != currentDate {
            Reset.flag = 1
            dateFlag = 0
        }
        print(">>DEBUG - 유저디폴트 \(UserDefaults.standard.string(forKey: "Date"))")
        print(">>DEBUG - 현재 시간 \(currentDate)")
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        print("sceneDidEnterBackground") //-> 앱이 Background에
        
        
       
        if dateFlag == 0 { //falg가 0이면 비교날짜를 저장하고 flag를 1로 만든다.
            UserDefaults.standard.set(currentDate, forKey: "Date") //비교 날짜를 저장
            dateFlag = 1 //저장 비허용으로 만들기
            
        }
        print(">>DEBUG - 유저디폴트 \(UserDefaults.standard.string(forKey: "Date"))")
        print(">>DEBUG - 현재 시간 \(currentDate)")
        
        
    }
    
    
    
    // 로직: 백그라운드 모드에 들어가게 되면 해당 시점에서의 날짜를 유저디폴트에 저장하고 다시 들어왔을 때 실시간으로 체크하는 날짜와 비교하게 되는데 이때 같은 날짜면 초기화가 되지 않고 서로 다른 날짜면 초기화가 된다.

    
    


}

