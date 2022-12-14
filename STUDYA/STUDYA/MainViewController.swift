//
//  MainViewController.swift
//  STUDYA
//
//  Created by μλμ΄ on 2022/08/30.
//

import UIKit
//πto be updated: λ€νΈμν¬λ‘ λ°©μ₯ μ¬λΆ νμΈλ°μ ν switchableVC μμ isAdmin κ° didsetμμ μμ νλλ‘
final class MainViewController: SwitchableViewController {
    // MARK: - Properties

    private var myStudyList = [Study]()
    private var currentStudy: Study?
    private var notification: String? {
        didSet {
            if notification != nil {
                notificationBtn.setImage(UIImage(named: "noti-new"), for: .normal)
            }
        }
    }
    
    private lazy var notificationBtn: UIButton = {
        
        let n = UIButton(frame: .zero)
        
        n.setImage(UIImage(named: "noti"), for: .normal)
        n.setTitleColor(.black, for: .normal)
        n.addTarget(self, action: #selector(notificationButtonDidTapped), for: .touchUpInside)
        n.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 35)
        
        return n
    }()
    
    private lazy var mainTableView: UITableView = {
        
        let t = UITableView()
        
        t.delegate = self
        t.dataSource = self
        
        t.register(MainFirstStudyToggleTableViewCell.self, forCellReuseIdentifier: MainFirstStudyToggleTableViewCell.identifier)
        t.register(MainSecondScheduleTableViewCell.self, forCellReuseIdentifier: MainSecondScheduleTableViewCell.identifier)
        t.register(MainThirdButtonTableViewCell.self, forCellReuseIdentifier: MainThirdButtonTableViewCell.identifier)
        t.register(MainFourthAnnouncementTableViewCell.self, forCellReuseIdentifier: MainFourthAnnouncementTableViewCell.identifier)
        t.register(MainFifthAttendanceTableViewCell.self, forCellReuseIdentifier: MainFifthAttendanceTableViewCell.identifier)
        t.register(MainSixthETCTableViewCell.self, forCellReuseIdentifier: MainSixthETCTableViewCell.identifier)
        
        t.showsVerticalScrollIndicator = false
        t.separatorStyle = .none
        t.backgroundColor = .systemBackground
        
        return t
    }()
    
    private lazy var floatingButton: UIButton = {
        let btn = UIButton(frame: .zero)
        let normalImage = UIImage(named: "mainFloatingPlus")
        let selectedImage = UIImage(named: "mainFloatingDismiss")

        btn.setImage(normalImage, for: .normal)
        btn.setImage(selectedImage, for: .selected)
        btn.addTarget(self, action: #selector(floatingButtonDidTapped), for: .touchUpInside)

        return btn
    }()
    private lazy var floatingButtonContainerView: UIView = {

        let v = UIView()
        v.isHidden = true

        return v
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        π£λ€νΈμνΉμΌλ‘ myStudyList λ£μ΄μ£ΌκΈ°
        
        myStudyList = [
            Study(id: 1, title: "ννΌνμ¦", onoff: .on, category: .getJob, studyDescription: "μ°λ¦¬μ μ€ν°λ", freeRule: "κ°λ¨μ­μμ μ’μ’ λͺ¨μ¬μ μ±μ κ°λ°νλ μ€ν°λλΌκ³  ν  μ μλ λΆλΆμ΄ μμ§ μμ μλ€κ³  μκ°νλ λΆλΆμ΄λΌκ³  λ΄λλ€.", po: nil, isBlocked: false, isPaused: false, generalRule: nil, startDate: nil, endDate: nil),
            Study(id: nil, title: "μ°μΌλΈμ°λ¦¬μ€ν°λ", onoff: nil, category: nil, studyDescription: "λκ·Έ μλΆμ§", freeRule: "λͺ¨νμλΈ? κ·Όλ¬μλλ. λ μ€λ μ« λ§μ. μ°λ¦¬ λμ λ§μ΄ μ»·λ€", po: nil, isBlocked: false, isPaused: false, generalRule: nil, startDate: nil, endDate: nil),
            Study(id: nil, title: "λ¬΄νλμ ", onoff: nil, category: nil, studyDescription: "λ³΄κ³  μΆλ€", freeRule: "λλ¦¬μ΄μ  λΆλ¬μ΄μ΄μ΄μ΄ λ¨κ±°μ΄μ΄μ΄μ΄μ΄μ΄μ΄μ΄", po: nil, isBlocked: false, isPaused: false, generalRule: nil, startDate: nil, endDate: nil),
            Study(id: 12, title: "ννΌνμ¦", onoff: .on, category: .getJob, studyDescription: "μ°λ¦¬μ μ€ν°λ", freeRule: "κ°λ¨μ­μμ μ’μ’ λͺ¨μ¬μ μ±μ κ°λ°νλ μ€ν°λλΌκ³  ν  μ μλ λΆλΆμ΄ μμ§ μμ μλ€κ³  μκ°νλ λΆλΆμ΄λΌκ³  λ΄λλ€.", po: nil, isBlocked: false, isPaused: false, generalRule: nil, startDate: nil, endDate: nil),
            Study(id: nil, title: "μ°μΌλΈμ°λ¦¬μ€ν°λ", onoff: nil, category: nil, studyDescription: "λκ·Έ μλΆμ§", freeRule: "λͺ¨νμλΈ? κ·Όλ¬μλλ. λ μ€λ μ« λ§μ. μ°λ¦¬ λμ λ§μ΄ μ»·λ€", po: nil, isBlocked: false, isPaused: false, generalRule: nil, startDate: nil, endDate: nil),
            Study(id: nil, title: "λ¬΄νλμ ", onoff: nil, category: nil, studyDescription: "λ³΄κ³  μΆλ€", freeRule: "λλ¦¬μ΄μ  λΆλ¬μ΄μ΄μ΄μ΄ λ¨κ±°μ΄μ΄μ΄μ΄μ΄μ΄μ΄μ΄", po: nil, isBlocked: false, isPaused: false, generalRule: nil, startDate: nil, endDate: nil),
            Study(id: 13, title: "ννΌνμ¦", onoff: .on, category: .getJob, studyDescription: "μ°λ¦¬μ μ€ν°λ", freeRule: "κ°λ¨μ­μμ μ’μ’ λͺ¨μ¬μ μ±μ κ°λ°νλ μ€ν°λλΌκ³  ν  μ μλ λΆλΆμ΄ μμ§ μμ μλ€κ³  μκ°νλ λΆλΆμ΄λΌκ³  λ΄λλ€.", po: nil, isBlocked: false, isPaused: false, generalRule: nil, startDate: nil, endDate: nil),
            Study(id: nil, title: "μ°μΌλΈμ°λ¦¬μ€ν°λ", onoff: nil, category: nil, studyDescription: "λκ·Έ μλΆμ§", freeRule: "λͺ¨νμλΈ? κ·Όλ¬μλλ. λ μ€λ μ« λ§μ. μ°λ¦¬ λμ λ§μ΄ μ»·λ€", po: nil, isBlocked: false, isPaused: false, generalRule: nil, startDate: nil, endDate: nil),
            Study(id: nil, title: "λ¬΄νλμ ", onoff: nil, category: nil, studyDescription: "λ³΄κ³  μΆλ€", freeRule: "λλ¦¬μ΄μ  λΆλ¬μ΄μ΄μ΄μ΄ λ¨κ±°μ΄μ΄μ΄μ΄μ΄μ΄μ΄μ΄", po: nil, isBlocked: false, isPaused: false, generalRule: nil, startDate: nil, endDate: nil)
        ]
        
        view.backgroundColor = .systemBackground
        myStudyList.isEmpty ? configureViewWhenNoStudy() : configureViewWhenYesStudy()
        
        configureTabBarSeparator()
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithTransparentBackground()
//        appearance.backgroundColor = .systemBackground
//        self.navigationItem.standardAppearance = appearance
//        self.navigationItem.scrollEdgeAppearance = appearance
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

//        self.navigationItem.standardAppearance = nil
//        self.navigationItem.scrollEdgeAppearance = nil
        
//        floatingButtonContainerView.isHidden = true
    }
    
    // MARK: - Actions
    @objc private func notificationButtonDidTapped() {
        
        let nextVC = NotificationViewController()
        push(vc: nextVC)
    }
    
    @objc private func createStudyButtonDidTapped() {
        dropdownButtonDidTapped()
        let creatingStudyFormVC = CreatingStudyFormViewController()
        
        creatingStudyFormVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        let presentVC = UINavigationController(rootViewController: creatingStudyFormVC)
        
        presentVC.navigationBar.backIndicatorImage = UIImage(named: "back")
        presentVC.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")
        presentVC.modalPresentationStyle = .fullScreen
        
        present(presentVC, animated: true)
    }
    
    @objc private func dropdownButtonDidTapped() {
        let dimmingVC = MainDropDownDimmingViewController()
        
        dimmingVC.modalTransitionStyle = .crossDissolve
        dimmingVC.modalPresentationStyle = .overFullScreen
        dimmingVC.currentStudy = currentStudy
        dimmingVC.myStudyList = myStudyList
        dimmingVC.presentCreateNewStudyVC = { sender in self.present(sender, animated: true) }
        
        present(dimmingVC, animated: true)
    }
    
    @objc private func floatingButtonDidTapped() {
        floatingButton.isSelected = true
        
        let dimmingVC = MainSpreadUpDimmingViewController()
        
        dimmingVC.modalTransitionStyle = .crossDissolve
        dimmingVC.modalPresentationStyle = .overFullScreen
        dimmingVC.tabBarHeight = tabBarController?.tabBar.frame.height ?? 83
        dimmingVC.dimmingViewTappedAction = { self.floatingButton.isSelected = false }
        dimmingVC.presentNextVC = { sender in
            self.present(sender, animated: true) { self.floatingButton.isSelected = false }
        }
        
        present(dimmingVC, animated: true)
    }
    
    override func extraWorkWhenSwitchToggled() {

//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = .appColor(.keyColor1)
//        self.navigationItem.standardAppearance = appearance
//        self.navigationItem.scrollEdgeAppearance = appearance
        
        notificationBtn.isHidden = isSwitchOn ? true : false
        floatingButtonContainerView.isHidden = isSwitchOn ? false : true
        
        guard !isSwitchOn else { return }
        floatingButton.isSelected = false
    }
    
    override func configureNavigationBar() {
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: notificationBtn)]
        guard !myStudyList.isEmpty else { return }
        
        super.configureNavigationBar()
    }
    
    private func configureNavigationBarNotiBtn() {
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: notificationBtn)]
    }
    
    private func configureViewWhenNoStudy() {
        let studyEmptyImageView = UIImageView(image: UIImage(named: "noStudy"))
        let studyEmptyLabel = CustomLabel(title: "μ°Έμ¬μ€μΈ μ€ν°λκ° μμ΄μπ΄", tintColor: .ppsBlack, size: 20, isBold: true)
        let createStudyButton = BrandButton(title: "μ€ν°λ λ§λ€κΈ°", isBold: true, isFill: true, fontSize: 20, height: 50)
        
        studyEmptyImageView.backgroundColor = .lightGray
        createStudyButton.addTarget(self, action: #selector(createStudyButtonDidTapped), for: .touchUpInside)
        
        view.addSubview(studyEmptyImageView)
        view.addSubview(studyEmptyLabel)
        view.addSubview(createStudyButton)
        
        studyEmptyImageView.centerXY(inView: view, yConstant: -Const.screenHeight * 0.06)
        
        studyEmptyLabel.snp.makeConstraints { make in
            make.centerX.equalTo(studyEmptyImageView)
            make.top.equalTo(studyEmptyImageView.snp.bottom).offset(20)
        }
        
        createStudyButton.snp.makeConstraints { make in
            make.centerX.equalTo(studyEmptyImageView)
            make.width.equalTo(200)
            make.top.equalTo(studyEmptyLabel.snp.bottom).offset(10)
        }
    }
    
    private func configureViewWhenYesStudy() {
        view.addSubview(mainTableView)
        mainTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        guard isAdmin else { return }
        
        configureFloatingButton()
    }
    
    private func configureFloatingButton() {
        floatingButtonContainerView.isHidden = true
        view.addSubview(floatingButtonContainerView)
        floatingButtonContainerView.addSubview(floatingButton)
        floatingButtonContainerView.snp.makeConstraints { make in
            make.trailing.equalTo(view).inset(15)
            make.bottom.equalTo(view).inset(100)
            make.width.height.equalTo(50)
        }
        floatingButton.snp.makeConstraints { make in
            make.leading.top.equalTo(floatingButtonContainerView)
        }
    }
    
    
    private func configureTabBarSeparator() {
        if let tabBar = tabBarController?.tabBar {
            
            let separator = UIView(frame: .zero)
            
            separator.backgroundColor = .appColor(.ppsGray2)
            
            tabBar.addSubview(separator)
            
            separator.snp.makeConstraints { make in
                make.leading.trailing.equalTo(tabBar)
                make.height.equalTo(1)
                make.top.equalTo(tabBar.snp.top)
            }
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: MainFirstStudyToggleTableViewCell.identifier) as! MainFirstStudyToggleTableViewCell
            
            cell.studyTitle = myStudyList.first?.title
            cell.buttonTapped = { self.dropdownButtonDidTapped() }
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: MainSecondScheduleTableViewCell.identifier) as! MainSecondScheduleTableViewCell
            cell.navigatableSwitchSyncableDelegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: MainThirdButtonTableViewCell.identifier) as! MainThirdButtonTableViewCell
            cell.navigatable = self
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: MainFourthAnnouncementTableViewCell.identifier) as! MainFourthAnnouncementTableViewCell
            cell.navigatable = self
            cell.announcement = Announcement(id: 1, studyID: 1, title: "μ€λμ κ³΅μ§", content: "κ³΅μ§ μ‘μμ§ μμμΉμ§κ³΅μ§ μ‘μμ§ μμμΉμ§κ³΅μ§ μ‘μμ§ μμμΉμ§κ³΅μ§ μ‘μμ§ μμμΉμ§κ³΅μ§ μ‘μμ§ μμμΉμ§κ³΅μ§ μ‘μμ§ μμμΉμ§κ³΅μ§ μ‘μμ§ μμμΉμ§", createdDate: nil, isPinned: true)
            //                cell.hideTabBar = { [weak self] in
            //                    self?.tabBarController?.tabBar.isHidden = true
            //                }
            //
            //                    cell.informationButtonAction = {
            //                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //                        let vc  = storyboard.instantiateViewController(withIdentifier: "StudyInfoViewController") as! StudyInfoViewController
            //                        vc.study = self.myStudyList.first!
            //                        self.navigationController?.pushViewController(vc, animated: true)
            //                    }
            
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: MainFifthAttendanceTableViewCell.identifier, for: indexPath) as! MainFifthAttendanceTableViewCell
            
            cell.studyAttendance = ["μΆμ": 30, "μ§κ°": 15, "κ²°μ": 10, "μ¬μ ": 5]
            cell.penalty = 9900
            cell.navigatableSwitchSyncableDelegate = self
            
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: MainSixthETCTableViewCell.identifier, for: indexPath) as! MainSixthETCTableViewCell
            
            cell.currentStudy = currentStudy
            cell.navigatableSwitchSyncableDelegate = self
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case mainTableView:
            if indexPath.row == 3 {
                let announcementBoardVC = AnnouncementBoardViewController()
                self.syncSwitchWith(nextVC: announcementBoardVC)
                self.push(vc: announcementBoardVC)
            }
        default: break
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 50
        case 1:
            return 165
        case 2:
            return 90
        case 3:
            return 60
        case 4:
            return 175
        default:
            return 70
        }
    }
}
//
//extension MainViewController: UIPopoverControllerDelegate {
//    class PresentAsPopover : NSObject, UIPopoverPresentationControllerDelegate {
//
//        // μ±κΈν΄ μ¬μ©, delegate propertyλ weak λκΉ instanceλ₯Ό λ―Έλ¦¬ λ°μλμΌνλ€.
//        private static let sharedInstance = AlwaysPresentAsPopover()
//
//        private override init() {
//            super.init()
//        }
//
//        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
//            return .none
//        }
//
//        static func configurePresentation(forController controller : UIViewController) -> UIPopoverPresentationController {
//            let presentationController = controller.presentationController as! UIPopoverPresentationController
//            presentationController.delegate = AlwaysPresentAsPopover.sharedInstance
//            return presentationController
//        }
//}

extension MainViewController {
    func present(vc: UIViewController) {
        present(vc, animated: true)
    }
}
