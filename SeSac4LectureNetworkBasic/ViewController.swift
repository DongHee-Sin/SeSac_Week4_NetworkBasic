//
//  ViewController.swift
//  SeSac4LectureNetworkBasic
//
//  Created by 신동희 on 2022/07/28.
//

import UIKit

class ViewController: UIViewController, ViewPresentableProtocol {

    var navigationTitleString: String = "대장님의 다마고칭"

    var backgroundColor: UIColor = .blue
    
    
    // UserDefaultsHelper 테스트
    //let helper = UserDefaultsHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaultsHelper.shared.nickname = "고래밥"
        navigationItem.title = UserDefaultsHelper.shared.nickname
    }
    
    
    func configureView() {
        
        navigationTitleString = "고래밥님의 다마고치"
        backgroundColor = .red
        
        title = navigationTitleString
        view.backgroundColor = backgroundColor
    }
}


//extension ViewController : DongTableViewProtocol {
//    func numberOfRowsInSection() -> Int {
//        <#code#>
//    }
//
//    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//}
//
//
//
//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//
//}
