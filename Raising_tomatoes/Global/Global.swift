//
//  Global.swift
//  Raising_tomatoes
//
//  Created by 준수김 on 2022/02/15.
//

import Foundation

struct CheckFlag {
    static var checkTabbarIndex = 0 //앱 실행시 첫화면으로 성장화면이 뜨는데 실행했을 때 한번만 작동하도록 제어하는 것
}

struct Today {
    static var day = 0 //오늘 날짜를 저장
    static var yyyymmdd = "" //오늘의 년도 월 일 저장
    static var time = ""
}

struct Success {
    static var state: [String] = []
    static var clear: [String] = []
    static var stamp: [String] = []
}

struct Reset {
    static var flag = 0
}
