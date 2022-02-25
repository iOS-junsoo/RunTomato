//
//  recordViewController.swift
//  Raising_tomatoes
//
//  Created by 준수김 on 2022/02/15.
//

import UIKit

class recordViewController: UIViewController {

    @IBOutlet weak var yearMonthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Date DATA
    
    let now = Date() //현재 날짜
    var cal = Calendar.current
    let dateFormatter = DateFormatter()
    var components = DateComponents()
    var weeks: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    var days: [String] = []
    var daysCountInMonth = 0 // 해당 월이 며칠까지 있는지
    var weekdayAdding = 0 // 시작일
    
    var countSuccess = 0
    var countFailure = 0
    
    @IBOutlet weak var currentStatusSofar: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //MARK: - 오늘 몇일 인가?
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        let current_date_string = formatter.string(from: Date())
        Today.day = Int(current_date_string) ?? 0
        
        setCollection()
       
    }
    
    func setCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "recordCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "recordCollectionViewCell")
        
        //날짜 설정
        dateFormatter.dateFormat = "yyyy년 M월" // 월 표시 포맷 설정
        components.year = cal.component(.year, from: now)
        components.month = cal.component(.month, from: now)
        components.day = 1
        calDate()
    }
    
    func calDate() {
        let firstDayOfMonth = cal.date(from: components) //해당 달의 첫 날
        let firstWeekDay = cal.component(.weekday, from: firstDayOfMonth!)// 해당 수로 반환이 됩니다. 1은 일요일 ~ 7은 토요일
        daysCountInMonth = cal.range(of: .day, in: .month, for: firstDayOfMonth!)!.count //해당 달의 날짜세기
        weekdayAdding = 2 - firstWeekDay //아래의 for문과 같이 설명을 보자 .
        //만약 해당 달의 1일의 시작이 수요일이라면 달력의 시자은 수요일 즉, 4번째 인덱스부터 1이 들어가야한다. 따라서 2 - 4 = -2 인데 아래의 if 문을 보면 weekdayAdding가 1 보자 작을 때는 빈칸을 입력하므로 -2, -1, 0 총 3개의 빈칸이 들어가게 된다.
        
        self.yearMonthLabel.text = dateFormatter.string(from: firstDayOfMonth!)
        
        self.days.removeAll()
        
        for day in weekdayAdding...daysCountInMonth {
            if day < 1 {
                self.days.append("")
                Success.state.append("")
                Success.clear.append("")
            } else {
                self.days.append(String(day))
                Success.state.append("")
                Success.clear.append("")
            }
        }
        print(Success.state)
        print(Success.state.count)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        if Today.time == "2300" { // 오후 11시가 되면 성공, 실패의 개수가 몇개인지
            countSuccess = 0
            countFailure = 0
            //위의 변수를 초기화 한 이유는 초기화 하지 않으면 이전에 더했던 것들과 같이 더해서 계산 오류가 생긴다.
            
            countSuccessAndFailure()
        }
        
        //MARK: - 앱 들어가면 성장화면 바로 띄우기
        if CheckFlag.checkTabbarIndex == 0 {
            tabBarController?.selectedIndex = 1
        }
        collectionView.reloadData()
        
        currentStatusSofar.text = "지금(\(Today.yyyymmdd))까지 토마토 재배 성공 횟수는 \(countSuccess)번, 실패 횟수는 \(countFailure)번 입니다. "
    }
    
    
    
    
    func countSuccessAndFailure() { //성공 실패 여부 조회
        for i in 0...Today.day - 1 {
            if Success.state[i] == "성공" {
                countSuccess += 1
                
            } else if Success.state[i] == "실패" {
                countFailure += 1
            }
            
        }
        print("\(Today.day)부터 \(Success.state.count)까지")
    }



}

extension recordViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 7
            
        default:
            return self.days.count
           
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recordCollectionViewCell", for: indexPath) as! recordCollectionViewCell


        
        switch indexPath.section {
        case 0:
            cell.dateLabel.text = weeks[indexPath.row] // 요일
            cell.successLabel.text = ""
        
        default:
            cell.dateLabel.text = days[indexPath.row] // 일
            cell.successLabel.text = Success.state[indexPath.row] // 성공여부

            
            if Success.state[indexPath.row] == "성공" {
                cell.successLabel.textColor = UIColor(red: 107, green: 137, blue: 132)
            } else if Success.state[indexPath.row] == "실패" {
                cell.successLabel.textColor = UIColor(red: 192 , green: 86, blue: 74)
            }
        }
        
        //성공여부는 당일 토마토를 재배하기 못하면 successState 배열에 append로 실패 할당
        


        if indexPath.row % 7 == 0 { // 일요일
            cell.dateLabel.textColor = .red
        } else if indexPath.row % 7 == 6 { // 토요일
            cell.dateLabel.textColor = .blue
        } else { // 월요일 좋아(평일)
            cell.dateLabel.textColor = .black
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.section), \(indexPath.row)")
        
    }
    
        
}
