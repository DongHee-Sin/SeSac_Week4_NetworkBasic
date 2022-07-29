//
//  TranslateViewController.swift
//  SeSac4LectureNetworkBasic
//
//  Created by 신동희 on 2022/07/28.
//

import UIKit

/*
 UIButton, UITextFiedl > Action
 UITextView, UISearchBar > Action (X)
 왜?
 상속구조가 다름 → UIControl을 상속
 
 responder chain
 */


class TranslateViewController: UIViewController {

    // MARK: - Outlet
    @IBOutlet weak var userInputTextView: UITextView!
    
    let textViewPlaceholderText = "번역하고싶은 문장을 작성해보세요."
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userInputTextView.delegate = self
        
        userInputTextView.text = textViewPlaceholderText
        userInputTextView.textColor = .lightGray
        
        userInputTextView.font = UIFont(name: "HBIOS-SYS", size: 20)
        
//        userInputTextView.resignFirstResponder()
//        userInputTextView.becomeFirstResponder()
    }
}


extension TranslateViewController: UITextViewDelegate {
    
    // 텍스트뷰의 텍스트가 변할 때마다 호출
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text.count)
    }
    
    // 편집이 시작될 때. 커서가 깜빡거릴 때 (시작될 때)
    // 텍스트뷰 글자가 플레이스홀더랑 같으면 clear처리 & color 처리
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("Begin")
        
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    // 편집이 끝났을 때. 커서가 없어지는 순간
    // 텍스트뷰 글자가 하나도 없을 때, 플레이스홀더를 입력해주기
    func textViewDidEndEditing(_ textView: UITextView) {
        print("End")
        
        if textView.text.isEmpty {
            textView.text = textViewPlaceholderText
            textView.textColor = .lightGray
        }
    }
}
