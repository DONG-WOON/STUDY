//
//  Model.swift
//  STUDYA
//
//  Created by 서동운 on 2022/09/08.
//

import Foundation

// MARK: - Model

//protocol Object: Encodable {
//    
//}
//
//struct Study: Object  {
//    
//}
//
//struct Schedule: Object {
//    
//}
//
//struct UserProfile: Codable {
//    let nickname: String
//    let img: Data
//}
//
//struct User: Codable {
//    let userId: String?
//    let password: String?
//    let password_check: String?
//    let nickname: String?
//}
//
//struct Credential: Encodable {
//    let userId: String
//    let password: String?
//}

//struct GeneralStudyRule {
//    let attendanceRule: AttendanceRule?
//    let excommunicationRule: ExcommunicationRule?
//}
//
//struct FreeStudyRule {
//    let content: String?
//}
//
//struct ExcommunicationRule {
//    var lateNumber: String?
//    var absenceNumber: String?
//}
//
//struct AttendanceRule {
//    var lateRuleTime: String?
//    var absenceRuleTime: String?
//    var perLateMinute: String?
//    var latePenalty: String?
//    var absentPenalty: String?
//    var deposit: String?
//}

struct Credential: Encodable {
    let userId: String
    let password: String?
}

enum SNS: String {
    case kakao = "kakao"
    case naver = "naver"
}

struct SNSInfo {
    let token: String
    let provider: String
}

struct Study: Codable {
    let id: Int?
    var title, onoff, category, studyDescription, freeRule, po: String?
    let isBlocked, isPaused: Bool?
    var generalRule: GeneralStudyRule?
    let startDate: Date?
    let endDate: Date?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "studyId"
        case title = "studyName"
        case category = "studyCategory"
        case studyDescription = "studyInfo"
        case freeRule = "studyFlow"
        case isBlocked = "studyBlock"
        case isPaused = "studyPause"
        case generalRule = "studyRule"
        case startDate = "start"
        case endDate = "end"
        case onoff, po
    }
}

struct GeneralStudyRule: Codable {
    var lateness: Lateness?
    var absence: Absence?
    var deposit: Int?
    var excommunication: Excommunication?
    
    enum CodingKeys: String, CodingKey {
        case lateness, deposit
        case absence = "absent"
        case excommunication = "out"
    }
}

struct Announcement: Codable {
    let id: Int?
    let studyID: Int?
    let title: String?
    let content: String?
    let createdDate: Date?
    var isPinned: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "notificationId"
        case studyID = "studyId"
        case title = "notificationSubject"
        case content = "notificationContents"
        case createdDate = "createdAt"
        case isPinned = "pin"
    }
}

struct Schedule: Codable {
    
    let id: Int?
    let name: String?
    let date: Date?
    let status: String? //상태가 머머 있는거지?
    
    enum CodingKeys: String, CodingKey {
        case status
        case id = "scheduleId"
        case name = "scheduleName"
        case date = "scheduleDate"
    }
}

struct Absence: Codable {
    var time, fine: Int?
}

struct Lateness: Codable {
    var time, count, fine: Int?
}

struct Excommunication: Codable {
    var lateness, absence: Int?
}

typealias UserID = String //사용자의 아이디
typealias ID = Int // 사용자 이외에 id가 있는 것들의 id
typealias Title = String
typealias Content = String
typealias Password = String
typealias SNSToken = String