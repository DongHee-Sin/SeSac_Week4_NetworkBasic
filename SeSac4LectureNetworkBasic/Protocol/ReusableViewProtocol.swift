//
//  ReusableViewProtocol.swift
//  SeSac4LectureNetworkBasic
//
//  Created by 신동희 on 2022/08/01.
//

import UIKit

protocol ReusableViewProtocol {
    static var reuseIdentifier: String { get }
}



extension UIViewController: ReusableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
