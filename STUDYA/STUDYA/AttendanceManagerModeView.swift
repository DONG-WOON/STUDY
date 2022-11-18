//
//  AttendanceManagerModeView.swift
//  STUDYA
//
//  Created by 신동훈 on 2022/11/18.
//

import UIKit

final class AttendanceManagerModeView: UIView {
    
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    @IBOutlet weak var leftCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightCenterXConstraint: NSLayoutConstraint!
    
    @IBAction private func leftButtonTapped(_ sender: UIButton) {
        leftCenterXConstraint.priority = .required
        rightCenterXConstraint.priority = .defaultHigh

        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: [.centeredHorizontally], animated: true)
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        } completion: { _ in
            self.leftLabel.textColor = UIColor.appColor(.ppsBlack)
            self.rightLabel.textColor = UIColor.appColor(.ppsGray2)
        }
    }
    @IBAction private func rightButtonTapped(_ sender: UIButton) {
        leftCenterXConstraint.priority = .defaultHigh
        rightCenterXConstraint.priority = .required
        
        collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: [.centeredHorizontally], animated: true)
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        } completion: { _ in
            self.leftLabel.textColor = UIColor.appColor(.ppsGray2)
            self.rightLabel.textColor = UIColor.appColor(.ppsBlack)
        }
    }
}

extension AttendanceManagerModeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AttendanceRuleCollectionViewCell.identifier, for: indexPath) as! AttendanceRuleCollectionViewCell
            
        case 1: break
            
        default: break
        }
        
        return UICollectionViewCell()
    }
}

extension AttendanceManagerModeView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}