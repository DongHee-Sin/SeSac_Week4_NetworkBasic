//
//  SearchViewController.swift
//  SeSac4LectureNetworkBasic
//
//  Created by 신동희 on 2022/07/27.
//

import UIKit

/*
 Swift Protocol
 - Delegate
 - Datasource
 
 1. 왼팔과 오른팔 가져오기
 2. TableView Outlet 연결
 3. 1+2 : 팔 연결
*/
 
class SearchViewController: UIViewController {

    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 연결고리 작업 : 테이블뷰가 해야 할 역할 > 뷰컨트롤러에게 요청
        //searchTableView.delegate = self
        //searchTableView.dataSource = self
        
        // 테이블뷰가 사용할 테이블뷰 셀(XIB) 등록
        // XIB : xml interface builder <= Nib
        searchTableView.register(UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
    }

    
}




//extension SearchViewController: ViewPresentableProtocol {
//    func configureView() {
//        searchTableView.backgroundColor = .clear
//        searchTableView.separatorColor = .clear
//        searchTableView.rowHeight = 60
//    }
//
//    func configureLabel() {
//        <#code#>
//    }
//
//}




// MARK: - TableView Protocol
//extension SearchViewController: UITableViewDe@objc legate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 100
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else {
//            return UITableViewCell()
//        }
//
//        cell.titleLabel.font = .boldSystemFont(ofSize: 22)
//        cell.titleLabel.text = "Hello"
//
//        return cell
//    }
//
//
//}
