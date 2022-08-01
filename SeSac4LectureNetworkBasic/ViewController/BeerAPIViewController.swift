//
//  BeerAPIViewController.swift
//  SeSac4LectureNetworkBasic
//
//  Created by 신동희 on 2022/08/01.
//

import UIKit

import Alamofire
import SwiftyJSON


class BeerAPIViewController: UIViewController {
    
    enum BeerResultKey: String {
        case name, description, image_url
    }
    
    
    
    // MARK: - Outlet
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestBeerfInfo()
    }
    
    
    
    // MARK: - Methods
    func requestBeerfInfo() {
        let url = "https://api.punkapi.com/v2/beers/random"
        
        AF.request(url, method: .get).validate().responseJSON { [unowned self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                guard let beerInfo = json.first?.1 else { return }
                
                let name = beerInfo[BeerResultKey.name.rawValue].stringValue
                let description = beerInfo[BeerResultKey.description.rawValue].stringValue
                let imageURL = URL(string: beerInfo[BeerResultKey.image_url.rawValue].stringValue)
                
                beerNameLabel.text = name
                beerDescriptionLabel.text = description
                if let url = imageURL { loadImage(url: url) }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func loadImage(url: URL) {
        DispatchQueue.global().async { [unowned self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.beerImage.image = image
                    }
                }
            }
        }
    }
}
