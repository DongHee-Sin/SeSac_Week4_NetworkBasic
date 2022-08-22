//
//  ListTableViewCell.swift
//  SeSac4LectureNetworkBasic
//
//  Created by 신동희 on 2022/07/27.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var openDateLabel: UILabel!
    @IBOutlet weak var totalCountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureInitialUI()
    }
    
    
    func configureInitialUI() {
        rankLabel.textAlignment = .center
        rankLabel.layer.cornerRadius = rankLabel.frame.width / 4
        rankLabel.clipsToBounds = true
        self.selectionStyle = .none
    }
    
    
    func updateCell(data: Movie) {
        rankLabel.text = data.rank
        titleLabel.text = data.movieTitle
        openDateLabel.text = data.releaseDate
        totalCountLabel.text = insertComma(value: data.totalCount)
    }
    
    
    func insertComma(value: Int) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: value))! + "명"
        
        return result
    }
}
