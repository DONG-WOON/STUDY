//
//  CreatingStudyViewController.swift
//  STUDYA
//
//  Created by 서동운 on 2022/08/10.
//

import UIKit
import SnapKit

enum StudyCategory: String, CaseIterable {
    case language = "어학"
    case dev_prod_design = "개발/기획/디자인"
    case project = "프로젝트"
    case getJob = "취업"
    case certificate = "자격시험/자격증"
    case pastime = "자기계발/취미"
    case etc = "그 외"
}
// to be fixed: 키보드의 자동완성 기능이 next button을 가림.
// to be fixed: 텍스트 뷰에서 엔터를 누르면 텍스트 뷰의 바깥으로 나가버림.
// to be fixed: category의 noti가 잘 전달되지않음.

final class CreatingStudyViewController: UIViewController {
    // MARK: - Properties
    
    var categoryChoice: (String, IndexPath)? {
        willSet(value) {
            if categoryChoice != nil {
                let cell = studyCategoryCollectionView.cellForItem(at: categoryChoice!.1) as? CategoryCell
                cell?.buttonDidTapped()
            }
            print(value!.0)
        }
    }
    
    /// Scrollalbe Container View
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    
    /// Scene Title
    private let titleLabel = CustomLabel(title: "어떤 스터디를\n만들까요", tintColor: .titleGeneral, size: 24, isBold: true)
    
    /// Study category
    private let studyCategoryLabel = CustomLabel(title: "주제", tintColor: .titleGeneral, size: 16, isNecessaryTitle: true)
    private lazy var studyCategoryCollectionView: UICollectionView = getCollectionView()
    
    /// Study Name
    private let studyNameLabel = CustomLabel(title: "스터디명", tintColor: .titleGeneral, size: 16, isNecessaryTitle: true)
    private let studyNameTextView = GrayBorderTextView(placeholder: "스터디명을 입력해주세요.", maxCharactersNumber: 10, height: 42)
    
    /// Study Type
    private let studyTypeLabel = CustomLabel(title: "형태", tintColor: .titleGeneral, size: 16, isNecessaryTitle: true)
    private let studyTypeGuideLabel = CustomLabel(title: "중복 선택 가능", tintColor: .subTitleGeneral, size: 12, isBold: false)
    private lazy var studyTypeStackView: UIStackView = getCheckBoxStackView()
    
    /// Study Introduction
    private let studyIntroductionLabel = CustomLabel(title: "한 줄 소개", tintColor: .titleGeneral, size: 16, isNecessaryTitle: true)
    private let studyIntroductionTextView = GrayBorderTextView(placeholder: "시작 계기, 목적, 목표 등을 적어주세요.", maxCharactersNumber: 30, height: 105)
    
    /// Bottom Button
    private let nextButton = CustomButton(title: "다음", isBold: true, isFill: false)

    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        setDelegate()
        enableTapGesture()
        addNotification()

        setConstraints()
    }
    
    // MARK: - Configure
    
    func configureViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(studyCategoryLabel)
        containerView.addSubview(studyCategoryCollectionView)
        containerView.addSubview(studyNameLabel)
        containerView.addSubview(studyNameTextView)
        containerView.addSubview(studyTypeLabel)
        containerView.addSubview(studyTypeGuideLabel)
        containerView.addSubview(studyTypeStackView)
        containerView.addSubview(studyIntroductionLabel)
        containerView.addSubview(studyIntroductionTextView)
        containerView.addSubview(nextButton)
    }
    
    // MARK: - Actions
    
    @objc func buttonDidTapped(sender: CheckBoxButton) {
        sender.toggleState()
    }
    
    @objc func onKeyboardAppear(_ notification: NSNotification) {
        
        guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardSize = keyboardFrame.cgRectValue
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        
        scrollView.contentInset = insets

//        var viewFrame = self.view.frame
//
//        viewFrame.size.height -= keyboardSize.height
//
//        let activeTextView: UITextView? = [studyNameTextView, studyIntroductionTextView].first { $0.isFirstResponder }
//
//        if let activeTextView = activeTextView {
//
//            if !viewFrame.contains(activeTextView.frame.origin) {
//
//                let scrollPoint = CGPoint(x: 0, y: activeTextView.frame.origin.y - keyboardSize.height)
//
//                scrollView.setContentOffset(scrollPoint, animated: true)
//            }
//        }
    }
    
    @objc func onKeyboardDisappear(_ notification: NSNotification) {
        scrollView.contentInset = UIEdgeInsets.zero
        self.view.endEditing(true)
    }
    
    private func enableTapGesture() {
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onKeyboardDisappear))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    // MARK: - Setting Constraints
    
    func setConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(view)
        }
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.snp.width)
            make.height.greaterThanOrEqualTo(view.snp.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(41)
            make.leading.trailing.equalTo(containerView.safeAreaLayoutGuide).inset(17)
        }
        studyCategoryLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalTo(titleLabel)
        }
        studyCategoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(studyCategoryLabel.snp.bottom).offset(17)
            make.leading.trailing.equalTo(titleLabel)
            make.height.equalTo(110)
        }
        studyNameLabel.snp.makeConstraints { make in
            make.top.equalTo(studyCategoryCollectionView.snp.bottom).offset(40)
            make.leading.equalTo(studyCategoryCollectionView)
        }
        studyNameTextView.snp.makeConstraints { make in
            make.top.equalTo(studyNameLabel.snp.bottom).offset(17)
            make.leading.trailing.equalTo(studyCategoryCollectionView)
            make.height.equalTo(42).priority(.low)
        }
        studyTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(studyNameTextView.snp.bottom).offset(40)
            make.leading.equalTo(titleLabel)
        }
        studyTypeGuideLabel.snp.makeConstraints { make in
            make.leading.equalTo(studyTypeLabel.snp.trailing).offset(7)
            make.bottom.equalTo(studyTypeLabel.snp.bottom)
        }
        studyTypeStackView.snp.makeConstraints { make in
            make.top.equalTo(studyTypeLabel.snp.bottom).offset(17)
            make.leading.equalTo(studyCategoryCollectionView)
            make.height.equalTo(46)
        }
        studyIntroductionLabel.snp.makeConstraints { make in
            make.top.equalTo(studyTypeStackView.snp.bottom).offset(40)
            make.leading.trailing.equalTo(titleLabel)
        }
        studyIntroductionTextView.snp.makeConstraints { make in
            make.top.equalTo(studyIntroductionLabel.snp.bottom).offset(17)
            make.leading.trailing.equalTo(studyCategoryCollectionView)
            make.height.greaterThanOrEqualTo(105)
        }
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(320)
            make.centerX.equalTo(containerView)
            make.top.equalTo(studyIntroductionTextView.snp.bottom).offset(40)
            make.bottom.equalTo(containerView.snp.bottom).inset(40)
        }
    }
    // MARK: - Helpers
    
    private func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardAppear(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(forName: Notification.Name.categoryDidChange, object: nil, queue: .main) { [self] noti in
            guard let cellInfo = noti.object as? [String: Any] else { return }
            let title = cellInfo["title"] as! String
            let indexPath = cellInfo["indexPath"] as! IndexPath
            
            categoryChoice = (title, indexPath)
        }
    }
    
    private func getCheckBoxStackView() -> UIStackView {
        
        let onlineButton = CheckBoxButton(title: "온라인", selected: "on", unselected: "off")
        let offlineButton = CheckBoxButton(title: "오프라인", selected: "on", unselected: "off")
        
        onlineButton.addTarget(nil, action: #selector(buttonDidTapped(sender:)), for: .touchUpInside)
        offlineButton.addTarget(nil, action: #selector(buttonDidTapped(sender:)), for: .touchUpInside)
        
        let sv = UIStackView(arrangedSubviews: [onlineButton, offlineButton])
        
        sv.axis = .vertical
        sv.alignment = .leading
        sv.spacing = 6
        sv.distribution = .fillEqually
        
        return sv
    }

    private func getCollectionView() -> UICollectionView {
        let flowLayout = LeftAlignedCollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.showsHorizontalScrollIndicator = false
        cv.register(CategoryCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        
        return cv
    }
    
    private func setDelegate() {
        studyNameTextView.delegate = self
        studyIntroductionTextView.delegate = self
        studyCategoryCollectionView.dataSource = self
    }
}

// MARK: - UITextViewDelegate

extension CreatingStudyViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        switch textView {
            case studyNameTextView:
                studyNameTextView.hidePlaceholder(true)
            case studyIntroductionTextView:
                studyIntroductionTextView.hidePlaceholder(true)
            default:
                return
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text == "" {
            
            switch textView {
                case studyNameTextView:
                    studyNameTextView.hidePlaceholder(false)
                case studyIntroductionTextView:
                    studyIntroductionTextView.hidePlaceholder(false)
                default:
                    return
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        switch textView {
            case studyNameTextView:
                guard let inputedText = textView.text else { return true }
                let newLength = inputedText.count + text.count - range.length
                studyNameTextView.charactersNumberLabel.text = newLength > 10 ? "10/10" : "\(newLength)/10"
                return newLength <= 10
            case studyIntroductionTextView:
                guard let inputedText = textView.text else { return true }
                let newLength = inputedText.count + text.count - range.length
                studyIntroductionTextView.charactersNumberLabel.text = newLength > 100 ? "100/100" : "\(newLength)/100"
                return newLength <= 100
            default:
                return false
        }
    }
}

// MARK: - UICollectionViewDataSource

extension CreatingStudyViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return StudyCategory.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CategoryCell
        cell.title = StudyCategory.allCases[indexPath.row].rawValue
        cell.indexPath = indexPath
        return cell
    }
}

// MARK: - UICollectionViewFlowLayout

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }

            layoutAttribute.frame.origin.x = leftMargin

            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }

        return attributes
    }
}
