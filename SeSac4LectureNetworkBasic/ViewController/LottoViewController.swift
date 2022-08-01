//
//  LottoViewController.swift
//  SeSac4LectureNetworkBasic
//
//  Created by 신동희 on 2022/07/28.
//

import UIKit

import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController {

    // MARK: - Propertys
    let numberList: [Int] = Array(1...1025).reversed()
    
    
    
    // MARK: - Outlet
    @IBOutlet weak var numberTextField: UITextField!
    
    // 코드로 뷰를 만드는 기능이 훨씬 더 많이 남아있슴
    var lottoPickerView = UIPickerView()
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberTextField.tintColor = .clear
        numberTextField.inputView = lottoPickerView
        
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
        
        requestLotto(number: 1025)
    }
    
    
    func requestLotto(number: Int) {
        
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        
        // AF : 200~299 status code == success (기본값)
        // statusCode 매개변수를 활용하여 성공 코드의 범위를 변경할 수 있음
        AF.request(url, method: .get).validate(statusCode: 200..<300).responseJSON { [unowned self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let bonus = json["bnusNo"].intValue
                print(bonus)
                
                let date = json["drwNoDate"].stringValue
                print(date)
                
                //numberTextField.text = date
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
}



extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        requestLotto(number: numberList[row])
        
        numberTextField.text = "\(numberList[row])회차"
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회차"
    }
}
