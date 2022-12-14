//
//  ToDoCollectionViewCell.swift
//  STUDYA
//
//  Created by ์๋์ด on 2022/10/19.
//

import UIKit
import SnapKit

class ToDoCollectionViewCell: UICollectionViewCell {
//    ๐to be fixed: ๋ฐํ์ํธ๊ฐ ์ ํ ์ํ์์ ํ์ด๋ธ๋ทฐ๋ฅผ ๋งจ์๋๊น์ง ์คํฌ๋กคํ  ์ ์์. ํ ์ผ์ ๋ง์ด ์์ฑํด์ ๋ทฐ๋ฅผ ๊ฝ์ฑ์ธ ๋๊น์ง ๋ด๋ ค๊ฐ๋ฉด ์๋์ ์ถ๊ฐ์๋ ฅ ์์ด ์๋์ผ๋ก ๋ณด์ด์ง ์์์ ์คํฌ๋กค์ ํด์ ์๋๋ก ์กฐ๊ธ ๋ด๋ ค์ค์ผ ๋ณด์
    var todo = ["ํ ์ผ","ํ ์ผ2","ํ ์ผ3","ํ ์ผ4","ํ ์ผ5","ํ ์ผ6","ํ ์ผ7","ํ ์ผ8"]
    var isdone = [false,true,false,true,false,true,false,true]
    
    weak var heightCoordinator: UBottomSheetCoordinator?
    
    let tableView: UITableView = {
       
        let t = UITableView()
        
        t.register(ToDoItemTableViewCell.self, forCellReuseIdentifier: ToDoItemTableViewCell.identifier)
        t.allowsSelection = false
        t.separatorStyle = .none
        t.backgroundColor = .appColor(.background)
        t.showsVerticalScrollIndicator = false
//        t.estimatedRowHeight = 33
//        t.rowHeight = UITableView.automaticDimension
        
        return t
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardAppear(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardDisappear(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.backgroundColor = .appColor(.background)
        
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func onKeyboardAppear(_ notification: NSNotification) {
        
        guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardSize = keyboardFrame.cgRectValue
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    @objc func onKeyboardDisappear(_ notification: NSNotification) {
        tableView.contentInset = UIEdgeInsets.zero
        tableView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
}

extension ToDoCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todo.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoItemTableViewCell.identifier) as! ToDoItemTableViewCell
        
        cell.heightCoordinator = heightCoordinator
        
        cell.cellDelegate = self
//        ๊ตฌ์/์ ์์ ์ต์ด ์ค์  ๋ถ๊ธฐ์ฒ๋ฆฌ
        if indexPath.row <= todo.count - 1 {
            cell.todo = todo[indexPath.row]
            cell.isDone = isdone[indexPath.row]
        } else {
            cell.todo = nil
            cell.isDone = false
        }
        
//        ์์ ํ์คํธํ๋์ ๋ฌธ์๊ฐ ์์ ๋ ์คํํ  ์ก์ ์ ์
        cell.textViewDidEndEditingWithLetter = { cell in
            guard let actualIndexPath = tableView.indexPath(for: cell) else { return }
            
            if actualIndexPath.row == self.todo.count {
                self.isdone.append(cell.checkButton.isSelected)
                self.todo.append(cell.todoTextView.text!)
                self.tableView.insertRows(at: [IndexPath(row: actualIndexPath.row + 1, section: 0)], with: .automatic)
            } else {
                print("๋ฐ์ดํฐ ์์  ํ ์๋ก๋")
            }
        }
//        ์์ ํ์คํธํ๋์ ๋ฌธ์๊ฐ ์์ ๋ ์คํํ  ์ก์ ์ ์
        cell.textViewDidEndEditingWithNoLetter = { cell in
            let actualIndexPath = tableView.indexPath(for: cell)!
            
            if actualIndexPath.row == self.todo.count {
                print("์๋ฌด๊ฒ๋ ์ํจ")
            } else {
                self.todo.remove(at: actualIndexPath.row)
                tableView.deleteRows(at: [actualIndexPath], with: .automatic)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 33   //๐ํฐํธ ํฌ๊ธฐ ๋ฐ๋๋ฉด ์ฌ๊ธฐ๋ ๋ฐ๊ฟ์ผ
    }
}

extension ToDoCollectionViewCell: GrowingCellProtocol {

    func updateHeightOfRow(_ cell: ToDoItemTableViewCell, _ textView: UITextView) {
        let size = textView.bounds.size
        let newSize = tableView.sizeThatFits(CGSize(width: size.width,
                                                        height: CGFloat.greatestFiniteMagnitude))
        if size.height != newSize.height {
            UIView.setAnimationsEnabled(false)
            tableView.beginUpdates()
            tableView.endUpdates()
            UIView.setAnimationsEnabled(true)
            if let thisIndexPath = tableView.indexPath(for: cell) {
                tableView.scrollToRow(at: thisIndexPath, at: .bottom, animated: false)
            }
        }
    }
}
