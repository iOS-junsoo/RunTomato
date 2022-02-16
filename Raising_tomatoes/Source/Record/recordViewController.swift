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
    
    var successState: [String] = []
    
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
                self.successState.append("")
            } else {
                self.days.append(String(day))
                if day == 1 || day == 5 {
                    self.successState.append("실패")
                }else if Today.day < day { //오늘 날짜 이후에는 성공여부가 표시되지 않도록 하는 조건문
                    self.successState.append("")
                } else {
                    self.successState.append("성공")
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //MARK: - 앱 들어가면 성장화면 바로 띄우기
        if CheckFlag.checkTabbarIndex == 0 {
            tabBarController?.selectedIndex = 1
        }
        collectionView.reloadData()
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
            cell.successLabel.text = successState[indexPath.row] // 성공여부
            if successState[indexPath.row] == "성공" {
                cell.successLabel.textColor = UIColor(red: 107, green: 137, blue: 132)
            } else if successState[indexPath.row] == "실패" {
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
