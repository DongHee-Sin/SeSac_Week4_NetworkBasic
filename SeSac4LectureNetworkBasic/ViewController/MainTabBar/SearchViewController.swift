//
//  SearchViewController.swift
//  SeSac4LectureNetworkBasic
//
//  Created by 신동희 on 2022/07/27.
//

import UIKit

import Alamofire
import SwiftyJSON
import JGProgressHUD
import RealmSwift

/*
 Swift Protocol
 - Delegate
 - Datasource
 
 1. 왼팔과 오른팔 가져오기
 2. TableView Outlet 연결
 3. 1+2 : 팔 연결
*/
 
class SearchViewController: UIViewController {

    // MARK: - Propertys
    let hud = JGProgressHUD()
    
    // BoxOffice 배열
    var boxOffice: Results<BoxOffice>!
    var movieList: List<Movie>?
    
    let localRealm = try! Realm()
    
    
    
    // MARK: - Outlet
    @IBOutlet weak var searchTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegate
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchBar.delegate = self
        
        searchTableView.register(UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        
        configureView()
        
        getBoxOfficeInfo(date: calcYesterday())
    }

    
    
    // MARK: - Methods
    func getBoxOfficeInfo(date: String) {
        
        hud.show(in: view, animated: true)
        
        // 검색한 Date에 대한 BoxOffice 정보 가져오기
        boxOffice = localRealm.objects(BoxOffice.self).where({
            $0.targetDate == date
        })
        
        if let boxoffice = boxOffice.first {
            // Realm에 검색한 Date에 대한 BoxOffice 정보가 있는 경우
            movieList = boxoffice.movieList
            searchTableView.reloadData()
            hud.dismiss(animated: true)
            
        }else {
            // Realm에 검색한 Date에 대한 BoxOffice 정보가 없는 경우
            requestBoxOffice(date: date)
        }
    }
    
    
    
    func requestBoxOffice(date: String) {
        
        let url = "\(EndPoint.boxOfficeURL)key=\(APIKey.BOXOFFICE)&targetDt=\(date)"
        
        AF.request(url, method: .get).validate(statusCode: 200..<300).responseData { [unowned self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                var result: [Movie] = []
                
                for movie in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    let movieNm = movie["movieNm"].stringValue
                    let openDt = movie["openDt"].stringValue
                    let audiAcc = movie["audiAcc"].stringValue
                    let rank = movie["rank"].stringValue
                    
                    let data = Movie(movieTitle: movieNm, releaseDate: openDt, totalCount: Int(audiAcc) ?? 0, rank: rank)
                    
                    result.append(data)
                }
                
                // Realm에 데이터 추가 (API Response 데이터를 통해)
                let task = BoxOffice(targetDate: date)
                task.movieList.append(objectsIn: result)
                try! localRealm.write {
                    localRealm.add(task)
                }
                
                movieList = task.movieList
                
                searchTableView.reloadData()
                hud.dismiss(animated: true)
                
            case .failure(let error):
                hud.dismiss(animated: true)
                print(error)
            }
        }
    }
    
    
    func calcYesterday() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        // 1)
//        let yesterday = Date(timeIntervalSinceNow: -86400)
//        return dateFormatter.string(from: yesterday)
        
        
        // 2)
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let dateResult = dateFormatter.string(from: yesterday ?? Date())
        return dateResult
    }
}




// MARK: - View Presentable Protocol
extension SearchViewController: ViewPresentableProtocol {
    func configureView() {
        searchTableView.backgroundColor = .clear
        searchTableView.rowHeight = 60
    }
}




// MARK: - TableView Protocol
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }

        if let movieList = movieList {
            cell.updateCell(data: movieList[indexPath.row])
        }
        
        return cell
    }


}




// MARK: - SearchBar Protocol
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // 옵셔널처리, 글자수, 유효한 형식인지 확인하는 코드 추가 필요
        getBoxOfficeInfo(date: searchBar.text!)
    }
    
}
