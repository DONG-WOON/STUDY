//  AttendanceViewController.swift
//  STUDYA
//
//  Created by 신동훈 on 2022/11/19.
//

import UIKit
import MultiProgressView

final class AttendanceViewController: UIViewController, BottomSheetAddable {

    var dailyStudyAttendance: [String: Int] = ["출석": 60, "지각": 15, "결석": 3, "사유": 5] {
        didSet {

        }
    }
    
    let managerView: AttendanceManagerModeView = {
       
        let nib = UINib(nibName: "AttendanceManagerModeView", bundle: nil)
        let v = nib.instantiate(withOwner: AttendanceViewController.self).first as! AttendanceManagerModeView
        
        return v
    }()
    let userView = AttendanceUserView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let managerView = managerView
        
        managerView.BottomSheetAddableDelegate = self
        view = managerView
    }
}

// MARK: UITableViewDataSource

extension AttendanceViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {

        switch section {
        case 0:
            return 0
        default:
            return 30
        }
    }


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        switch section {
        case 0:
            let headerView = UIView()
            headerView.backgroundColor = .appColor(.background)
            return headerView
        default:
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ReusableView.reusableMonthlyHeaderView.identifier) as! MonthlyHeaderView
            return headerView
        }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {

        switch section {
        case 0:
            return nil
        default:
            let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ReusableView.reusableMonthlyFooterView.identifier) as! MonthlyFooterView
            return footerView
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
        case 0:
            return 1
        default:
            return 10
        }

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let attendanceTableViewDetailsCell = tableView.dequeueReusableCell(withIdentifier: ReusableView.reusableDetailsCell.identifier, for: indexPath)
            as! AttendanceDetailsCell

            return attendanceTableViewDetailsCell
        default:
            let dayCell = tableView.dequeueReusableCell(withIdentifier: ReusableView.reusableDayCell.identifier, for: indexPath)
            as! AttendanceTableViewDayCell

            dayCell.attendance = "출석"

            return dayCell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch indexPath.section {
        case 0:
            return 150
        default:
            return 40
        }
    }
}