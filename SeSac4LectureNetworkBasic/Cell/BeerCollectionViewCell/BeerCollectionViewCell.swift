//
//  BeerCollectionViewCell.swift
//  SeSac4LectureNetworkBasic
//
//  Created by 신동희 on 2022/08/02.
//

import UIKit

class BeerCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlet
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerTitle: UILabel!
    @IBOutlet weak var beerDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configureBeerCell(data: Beer) {
        beerTitle.text = data.title
        beerDescription.text = data.description
        if let url = URL(string: data.imageURL) { loadImage(url: url) }
    }
    
    
    func loadImage(url: URL) {
        DispatchQueue.global().async { [unowned self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async { [unowned self] in
                        beerImageView.image = image
                    }
                }
            }
        }
    }
}
