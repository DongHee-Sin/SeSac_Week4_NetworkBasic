//
//  ImageSearchCollectionViewCell.swift
//  SeSac4LectureNetworkBasic
//
//  Created by 신동희 on 2022/08/03.
//

import UIKit

class ImageSearchCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    func loadImage(url: URL) {
        DispatchQueue.global().async { [unowned self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async { [unowned self] in
                        imageView.image = image
                    }
                }
            }
        }
    }
}
