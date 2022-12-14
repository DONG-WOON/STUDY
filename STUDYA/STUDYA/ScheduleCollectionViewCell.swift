//
//  MyScheduleCollectionViewCell.swift
//  STUDYA
//
//  Created by 서동운 on 2022/10/19.
//

import UIKit

class ScheduleCollectionViewCell: UICollectionViewCell {
    
    let studySchedules: [StudySchedule] = [
        StudySchedule(openDate: Date(), deadlineDate: Date(), startTime: Date(), endTime: Date(), repeatOption: RepeatOption.everyDay, topic: "HIG 높아보기", place: "강남구"),
        StudySchedule(openDate: Date(), deadlineDate: Date(), startTime: Date(), endTime: Date(), repeatOption: RepeatOption.everyDay, topic: "HIG 높아보기", place: "강남구"),
        StudySchedule(openDate: Date(), deadlineDate: Date(), startTime: Date(), endTime: Date(), repeatOption: RepeatOption.everyDay, topic: "HIG 높아보기", place: "강남구"),
        StudySchedule(openDate: Date(), deadlineDate: Date(), startTime: Date(), endTime: Date(), repeatOption: RepeatOption.everyDay, topic: "HIG 높아보기", place: "강남구"),
        StudySchedule(openDate: Date(), deadlineDate: Date(), startTime: Date(), endTime: Date(), repeatOption: RepeatOption.everyDay, topic: "HIG 높아보기", place: "강남구"),
        StudySchedule(openDate: Date(), deadlineDate: Date(), startTime: Date(), endTime: Date(), repeatOption: RepeatOption.everyDay, topic: "HIG 높아보기", place: "강남구")
    ]
    lazy var studyScheduleEmptyLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "일정이 없어요 😴"
        return lbl
    }()
    
    private let scheduleTableView = ScheduleTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scheduleTableView.dataSource = self
        scheduleTableView.delegate = self
        
        self.contentView.addSubview(scheduleTableView)
        scheduleTableView.backgroundColor = .appColor(.background)
        
        scheduleTableView.snp.makeConstraints { make in
            make.edges.equalTo(self.contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func reloadTableView() {
       
        scheduleTableView.reloadData()
    }
    
    func checkScheduleIsEmpty() {

        if studySchedules.isEmpty {
            scheduleTableView.addSubview(studyScheduleEmptyLabel)
            studyScheduleEmptyLabel.snp.makeConstraints { make in
                make.centerX.equalTo(scheduleTableView)
                make.top.equalTo(scheduleTableView).inset(100)
            }
        } else {
            studyScheduleEmptyLabel.removeFromSuperview()
        }
    }
}

extension ScheduleCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        studySchedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTableViewCell", for: indexPath) as! ScheduleTableViewCell
        
        let schedule = studySchedules[indexPath.row]
        
        cell.configure(schedule: schedule, kind: .personal)
        
        return cell
    }
}

extension ScheduleCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
