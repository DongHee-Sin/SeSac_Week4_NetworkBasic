//
//  BeerListViewController.swift
//  SeSac4LectureNetworkBasic
//
//  Created by 신동희 on 2022/08/02.
//

import UIKit

import Alamofire
import SwiftyJSON


class BeerListViewController: UIViewController {

    var beerList: [Beer] = []
    
    
    // MARK: - Outlet
    @IBOutlet weak var beerCollectionView: UICollectionView!
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beerCollectionView.delegate = self
        beerCollectionView.dataSource = self
        beerCollectionView.register(UINib(nibName: "BeerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BeerCollectionViewCell")
        
        beerCollectionView.collectionViewLayout = configureCollectionViewLayout(rowCount: 2)
        
        requestBeerfInfo()
    }
    
    
    
    // MARK: - Methods
    func requestBeerfInfo() {
        let url = "https://api.punkapi.com/v2/beers"
        
        beerList.removeAll()
        
        AF.request(url, method: .get).validate().responseJSON { [unowned self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for beerInfo in json.arrayValue {
                    let title = beerInfo["name"].stringValue
                    let description = beerInfo["description"].stringValue
                    let imageURL = beerInfo["image_url"].stringValue
                    
                    beerList.append(Beer(title: title, description: description, imageURL: imageURL))
                }
    
                beerCollectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}


// MARK: - CollectionView
extension BeerListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BeerCollectionViewCell", for: indexPath) as? BeerCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureBeerCell(data: beerList[indexPath.row])
        
        return cell
    }
    
    
    // Layout
    func configureCollectionViewLayout(rowCount: CGFloat) -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
            
            // 섹션별, 아이템별로 여백을 상수로 저장하고 사용
        let sectionSpacing: CGFloat = 12
        let itemSpacing: CGFloat = 12
            
        let width: CGFloat = UIScreen.main.bounds.width - (itemSpacing * (rowCount-1)) - (sectionSpacing * 2)
        let itemWidth: CGFloat = width / rowCount
            
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        layout.minimumLineSpacing = itemSpacing
        layout.minimumInteritemSpacing = itemSpacing
            
        return layout
    }
}
