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
    
    enum LottoJsonKey: String {
        case drwtNo1
    }
    

    // MARK: - Propertys
    let numberList: [Int] = Array(1...1025).reversed()
    
    var lottoPickerView = UIPickerView()
    
    
    
    // MARK: - Outlet
    @IBOutlet weak var numberTextField: UITextField!
    
    @IBOutlet weak var drwt1Label: UILabel!
    @IBOutlet weak var drwt2Label: UILabel!
    @IBOutlet weak var drwt3Label: UILabel!
    @IBOutlet weak var drwt4Label: UILabel!
    @IBOutlet weak var drwt5Label: UILabel!
    @IBOutlet weak var drwt6Label: UILabel!
    @IBOutlet weak var bonusLabel: UILabel!
    
    @IBOutlet weak var plusLabel: UILabel!
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureInitialUI()
        
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
        
        requestLotto(number: 1025)
    }
    
    
    
    // MARK: - Methods
    func configureInitialUI() {
        numberTextField.tintColor = .clear
        numberTextField.inputView = lottoPickerView
        
        settingLabel()
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
    
    
    func settingLabel() {
        [drwt1Label, drwt2Label, drwt3Label, drwt4Label, drwt5Label, drwt6Label, bonusLabel].forEach {
            guard let label = $0 else { return }
            
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .white
            
            label.layer.cornerRadius = label.frame.height / 2
            label.clipsToBounds = true
        }
        
        drwt1Label.backgroundColor = .orange
        [drwt2Label, drwt3Label].forEach { $0?.backgroundColor = .blue }
        [drwt4Label, drwt5Label, bonusLabel].forEach { $0?.backgroundColor = .darkGray }
        drwt6Label.backgroundColor = .systemGreen
        
        plusLabel.textAlignment = .center
    }
}



// MARK: - PickerView
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
