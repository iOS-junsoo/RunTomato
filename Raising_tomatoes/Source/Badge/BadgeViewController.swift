//
//  BadgeViewController.swift
//  Raising_tomatoes
//
//  Created by 준수김 on 2022/03/13.
//

import UIKit

class BadgeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
    }
    
    func setUpTableView() {
            tableView.delegate = self
            tableView.dataSource = self
        tableView.register(UINib(nibName: "BadgeTableViewCell", bundle: nil), forCellReuseIdentifier: "BadgeTableViewCell") //nib 파일 등록
        tableView.register(UINib(nibName: "Badge2TableViewCell", bundle: nil), forCellReuseIdentifier: "Badge2TableViewCell") //nib 파일 등록
    }


}

extension BadgeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BadgeTableViewCell") as! BadgeTableViewCell
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Badge2TableViewCell") as! Badge2TableViewCell
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { //cell의 높이 설정

            switch indexPath.row {
            case 0:
                return 206
            case 1:
                return 356
            
            default:
                return 0
            }
        
      
        
        }
    
}
