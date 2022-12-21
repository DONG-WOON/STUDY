//
//  Enum.swift
//  STUDYA
//
//  Created by 신동훈 on 2022/10/06.
//

import UIKit

enum Const {
    static let screenHeight = UIScreen.main.bounds.height
    static let screenWidth = UIScreen.main.bounds.width
    static let userId = "userId"
    static let isEmailCertificated = "isEmailCertificated"
    static let nickName = "nickName"
    static let profileImageURL = "profileImageURL"
    static let accessToken = "AccessToken"
    static let refreshToken = "RefreshToken"
    static let tempUserId = "tempUserId"
    static let tempPassword = "tempPassword"
    static let tempPasswordCheck = "tempPasswordCheck"
    static let tempNickname = "tempNickname"
    static let unknownErrorMessage = "알 수 없는 에러가 발생했습니다. 이용에 불편을 드려 죄송합니다. 빠르게 복구하겠습니다."
    static let serverErrorMessage = "서버에 에러가 발생했어요. 이용에 불편을 드려 죄송합니다. 빠르게 복구하겠습니다."
    static let statusCode = "statusCode"
    static let isLoggedin = "isLoggedin"
}

enum AttendanceStatus {
    case attended
    case late
    case absent
    case allowed
}

enum StudyExitBottomSheetTask {
    case exit
    case close
    case resignMaster
}

enum Task {
    case creating
    case editing
    case viewing
}

enum Viewer {
    case manager
    case user
}

enum AttendanceBottomViewType {
    case daySearchSetting
    case individualUpdate
    case membersPeriodSearchSetting
    case individualPeriodSearchSetting
    
    var view: FullDoneButtonButtomView {
        switch self {
            case .daySearchSetting: return AttendanceBottomDaySearchSettingView(doneButtonTitle: "조회")
            case .individualUpdate: return AttendanceBottomIndividualUpdateView(doneButtonTitle: "완료")
            case .membersPeriodSearchSetting: return AttendanceBottomMembersPeriodSearchSettingView(doneButtonTitle: "조회")
            case .individualPeriodSearchSetting: return AttendanceBottomIndividualPeriodSearchSettingView(doneButtonTitle: "조회")
        }
    }
    
    var detent: CGFloat {
        switch self {
            case .daySearchSetting: return 316
            case .individualUpdate: return 316
            case .membersPeriodSearchSetting: return 381
            case .individualPeriodSearchSetting: return 291
        }
    }
}

enum StudyCategory: String, CaseIterable {
    case language = "어학"
    case dev_prod_design = "개발/기획/디자인"
    case project = "프로젝트"
    case getJob = "취업"
    case certificate = "자격시험/자격증"
    case pastime = "자기계발/취미"
    case etc = "그 외"
    
    var indexPath: IndexPath {
        switch self {
            case .language:
                return IndexPath(item: 0, section: 0)
            case .dev_prod_design:
                return IndexPath(item: 1, section: 0)
            case .project:
                return IndexPath(item: 2, section: 0)
            case .getJob:
                return IndexPath(item: 3, section: 0)
            case .certificate:
                return IndexPath(item: 4, section: 0)
            case .pastime:
                return IndexPath(item: 5, section: 0)
            case .etc:
                return IndexPath(item: 6, section: 0)
        }
    }
}

enum CalendarKind {
    case study
    case personal
}

enum PopUpCalendarType {
    case open
    case deadline
}
