//
//  ToDoItemTableViewCell.swift
//  STUDYA
//
//  Created by ì ëí on 2022/10/21.
//

import UIKit

//ðto be fixed: ì´ë¯¸ íëª¨ë¬ë¡ ì¬ë¼ììì ëë ì¬ë¼ì¤ì§ ìê² í  ì ìë¤ë©´ setPosition ê³¼ ê´ë ¨í´ì ê¸°ë¥ì¶ê°í´ë³´ê¸°. ìì¤í ìì ì ì½ ìí´.
class ToDoItemTableViewCell: UITableViewCell {
    
    static let identifier = "ToDoItemTableViewCell"
    
    weak var cellDelegate: GrowingCellProtocol? //ðweak ì??
    weak var heightCoordinator: UBottomSheetCoordinator?
    
    internal var todo: String? {
        didSet {
            todoTextView.text = todo == nil ? placeholder : todo
            todoTextView.textColor = todo == nil ? UIColor.appColor(.ppsGray1) : .appColor(.ppsBlack)
        }
    }
    internal var isDone = false {
        didSet {
            checkButton.isSelected = isDone ? true : false
        }
    }
    internal var textViewDidEndEditingWithNoLetter: (ToDoItemTableViewCell) -> () = { sender in }
    internal var textViewDidEndEditingWithLetter: (ToDoItemTableViewCell) -> () = { sender in }
    private let placeholder = "ì´ê³³ì ëë¬ í  ì¼ì ì¶ê°í´ë³´ì¸ì."
    
    lazy var checkButton: UIButton = {
        
        let b = UIButton(frame: .zero)
        
        b.setImage(UIImage(named: "off"), for: .normal)
        b.setImage(UIImage(named: "on"), for: .selected)
        b.isSelected = isDone ? true : false
        b.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        
        return b
    }()
    lazy var todoTextView: UITextView = {
       
        let v = UITextView()
        
        v.font = .systemFont(ofSize: 15)
        v.text = placeholder
        v.textColor = .appColor(.ppsGray1)
        v.isScrollEnabled = false
        v.textContainer.maximumNumberOfLines = 3
        v.textContainer.lineBreakMode = .byTruncatingTail
        v.backgroundColor = .appColor(.background)
        v.showsHorizontalScrollIndicator = false
        v.showsVerticalScrollIndicator = false
        v.isScrollEnabled = false
        v.bounces = false
        
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .appColor(.background)
        todoTextView.font = .systemFont(ofSize: 14) //ë§ì½ ë í° í¬ê¸°ë¡ ë°ê¾¸ê² ëë©´ ê¸ìì ì íì´ë ì¤ ì ë±ë ë°ê¿ì¼.
        todoTextView.delegate = self
        
        contentView.addSubview(checkButton)
        contentView.addSubview(todoTextView)

        checkButton.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView)
            make.bottom.greaterThanOrEqualTo(contentView.snp.bottom).inset(65)
        }
        todoTextView.anchor(top: contentView.topAnchor, topConstant: -5.5, bottom: contentView.bottomAnchor, bottomConstant: 20, leading: checkButton.trailingAnchor, leadingConstant: 20, trailing: contentView.trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func checkButtonTapped() {
        checkButton.isSelected.toggle()
        endEditing(true)
    }
}

extension ToDoItemTableViewCell: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        } else {
            guard let inputedText = textView.text else { return true }
            let newLength = inputedText.count + text.count - range.length
            return newLength <= 70
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        heightCoordinator?.setPosition(UIScreen.main.bounds.height * 0.12, animated: true)
        
        if textView.text == placeholder {
            textView.text = nil
            textView.textColor = .appColor(.ppsBlack)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = placeholder
            textView.textColor = .appColor(.ppsGray1)
            textViewDidEndEditingWithNoLetter(self)
        } else {
            textViewDidEndEditingWithLetter(self)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if let delegate = cellDelegate {
            print(#function)
            delegate.updateHeightOfRow(self, textView)
        }
    }
}

protocol GrowingCellProtocol: AnyObject {
    func updateHeightOfRow(_ cell: ToDoItemTableViewCell, _ textView: UITextView)
}
