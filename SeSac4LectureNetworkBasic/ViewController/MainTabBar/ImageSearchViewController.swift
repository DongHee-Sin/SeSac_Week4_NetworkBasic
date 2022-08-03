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
    
    
    
    // MARK: - Outlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        
        imageCollectionView.register(UINib(nibName: "ImageSearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageSearchCollectionViewCell")
        
        imageCollectionView.collectionViewLayout = configureCollectionViewLayout(rowCount: 2)
    }
    
    
    
    // MARK: - Methods
    
    // fetch___, request___, call___, get___ > response에 따라 네이밍을 설정하기도 함
    func requestImage(text: String) {        
        // 인코딩
        let text = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=\(searchResult.count + 1)"
        
        // HTTP Header => Key: Value 형식
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { [unowned self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                json["items"].arrayValue.forEach {
                    searchResult.append($0["link"].stringValue)
                }
                
                imageCollectionView.reloadData()
                
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



// MARK: - SearchBar Protocol
extension ImageSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchResult.removeAll()
        
        if let text = searchBar.text {
            requestImage(text: text)
        }
    }
}
