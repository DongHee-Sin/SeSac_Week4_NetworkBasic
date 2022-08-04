//
//  ImageSearchViewController.swift
//  SeSac4LectureNetworkBasic
//
//  Created by 신동희 on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON

class ImageSearchViewController: UIViewController {

    // MARK: - Propertys
    var searchResult: [String] = []
    
    //var fetchingMore: Bool = false
    
    var currentSearchText = ""
    
    var startPage: Int { searchResult.count + 1 }
    
    var totalCount = 0
    
    
    
    // MARK: - Outlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.prefetchDataSource = self  // 페이지네이션 3.
        
        imageCollectionView.register(UINib(nibName: "ImageSearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageSearchCollectionViewCell")
        
        imageCollectionView.collectionViewLayout = configureCollectionViewLayout(rowCount: 2)
    }
    
    
    
    // MARK: - Methods
    
    // fetch___, request___, call___, get___ > response에 따라 네이밍을 설정하기도 함
    func requestImage(text: String) {
        // 인코딩
        let text = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=\(startPage)"
        
        // HTTP Header => Key: Value 형식
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { [unowned self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                let statusCode = response.response?.statusCode ?? 500
                
                if 200..<300 ~= statusCode {
                    json["items"].arrayValue.forEach {
                        searchResult.append($0["link"].stringValue)
                    }
                    
                    totalCount = json["total"].intValue
                    
                    imageCollectionView.reloadData()
                    //fetchingMore = false
                }else {
                    print("STATUSCODE : \(statusCode)")
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}



// MARK: - CollectionView Protocol
extension ImageSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageSearchCollectionViewCell", for: indexPath) as? ImageSearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let url = URL(string: searchResult[indexPath.row]) {
            cell.loadImage(url: url)
        }
        
        return cell
    }
    
    
    
    // Layout
    func configureCollectionViewLayout(rowCount: CGFloat) -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
            
            // 섹션별, 아이템별로 여백을 상수로 저장하고 사용
        let sectionSpacing: CGFloat = 12
        let itemSpacing: CGFloat = 8
            
        let width: CGFloat = UIScreen.main.bounds.width - (itemSpacing * (rowCount-1)) - (sectionSpacing * 2)
        let itemWidth: CGFloat = width / rowCount
            
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        layout.minimumLineSpacing = itemSpacing
        layout.minimumInteritemSpacing = itemSpacing
            
        return layout
    }
}



// MARK: - Pagenation
extension ImageSearchViewController {
    // 페이지네이션 1. 컬렉션뷰가 특정 셀을 그리려는 시점에 호출
    // 마지막 셀에 사용자가 위치해있는 지 명확하게 확인하기가 어려움
    // 권장되지 않는 방식
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    
    // 페이지네이션 2. UIScrollViewDelegateProtocol
    // TableView, CollectionView는 ScrollView를 상속받고 있어서 ScrollView Protocol을 사용할 수 있음
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset)  // contentOffSet.y : 사용자에게 보여지는 화면의 하단(?) 위치
//    }
    
}

// 페이지네이션 3. CollectionView - DataSourcePrefetching (iOS 10 ~, 스크롤 성능이 향상된다고 함)
// 용량이 큰 이미지를 다운받아서 셀에 보여주려고 하는 경우 효과적
// 셀이 화면에 보이기 전에 미리 필요한 리소스를 다운받을 수도 있고, 필요하지 않다면 다운로드를 취소할 수도 있다.
// 자료가 많지 않음
extension ImageSearchViewController: UICollectionViewDataSourcePrefetching {
    // 앞으로 보여질 셀을 받아옴
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if searchResult.count - 1 == indexPath.item && searchResult.count < totalCount {
                requestImage(text: currentSearchText)
            }
        }
        
        print("=== \(indexPaths)")
    }
    
    // (준비한 Cell을)취소 => 직접 취소하는 기능을 구현해야 함
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("===취소 \(indexPaths)")
    }
}





// MARK: - SearchBar Protocol
extension ImageSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchResult.removeAll()
        
        if let text = searchBar.text {
            currentSearchText = text
            
            // 스크롤 맨위로 올리는 방법 찾아보기
            //imageCollectionView.scrollToItem(at: <#T##IndexPath#>, at: <#T##UICollectionView.ScrollPosition#>, animated: <#T##Bool#>)
            
            requestImage(text: currentSearchText)
        }
    }
    
    
    // 취소 버튼 눌렀을 때 호출
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResult.removeAll()
        imageCollectionView.reloadData()
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    
    // 서치바에 커서가 깜빡이기 시작할 때 호출
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
}



// MARK: - 페이징
//extension ImageSearchViewController {
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if self.imageCollectionView.contentOffset.y > (imageCollectionView.contentSize.height - imageCollectionView.bounds.size.height) {
//
//            if !fetchingMore {
//                fetchingMore = true
//                requestImage(text: currentSearchText)
//            }
//        }
//    }
//}
