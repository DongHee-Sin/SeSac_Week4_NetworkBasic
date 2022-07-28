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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
