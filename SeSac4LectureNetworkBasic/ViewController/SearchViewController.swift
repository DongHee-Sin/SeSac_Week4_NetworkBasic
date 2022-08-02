//
//  SearchViewController.swift
//  SeSac4LectureNetworkBasic
//
//  Created by 신동희 on 2022/07/27.
//

import UIKit

import Alamofire
import SwiftyJSON

/*
 Swift Protocol
 - Delegate
 - Datasource
 
 1. 왼팔과 오른팔 가져오기
 2. TableView Outlet 연결
 3. 1+2 : 팔 연결
*/
 
class SearchViewController: UIViewController {

    // MARK: - Outlet
    @IBOutlet weak var searchTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    // BoxOffice 배열
    var list: [BoxOfficeModel] = []
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegate
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchBar.delegate = self
        
        // 테이블뷰가 사용할 테이블뷰 셀(XIB) 등록
        // XIB : xml interface builder <= Nib
        searchTableView.register(UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        
        configureView()
        
        requestBoxOffice(date: "20220801")
    }

    
    func requestBoxOffice(date: String) {
        list.removeAll()
        
        let url = "\(EndPoint.boxOfficeURL)key=\(APIKey.BOXOFFICE)&targetDt=\(date)"
        
        AF.request(url, method: .get).validate(statusCode: 200..<300).responseJSON { [unowned self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(value)
                
                for movie in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    let movieNm = movie["movieNm"].stringValue
                    let openDt = movie["openDt"].stringValue
                    let audiAcc = movie["audiAcc"].stringValue
                    
                    let data = BoxOfficeModel(movieTitle: movieNm, releaseDate: openDt, totalCount: audiAcc)
                    
                    list.append(data)
                }
                
                searchTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}




extension SearchViewController: ViewPresentableProtocol {
    func configureView() {
        searchTableView.backgroundColor = .clear
        searchTableView.rowHeight = 60
    }
}




// MARK: - TableView Protocol
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }

        cell.titleLabel.font = .boldSystemFont(ofSize: 22)
        cell.titleLabel.text = "\(list[indexPath.row].movieTitle): \(list[indexPath.row].releaseDate)"
        cell.selectionStyle = .none

        return cell
    }


}


// MARK: - SearchBar Protocol
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // 옵셔널처리, 글자수, 유효한 형식인지 확인하는 코드 추가 필요
        requestBoxOffice(date: searchBar.text!)
    }
    
}
