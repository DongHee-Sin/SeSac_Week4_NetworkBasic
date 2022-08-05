//
//  UserDefaultsManager.swift
//  SeSac4LectureNetworkBasic
//
//  Created by 신동희 on 2022/08/05.
//

import Foundation

class UserDefaultManager {
    static let shared = UserDefaultManager()
    
    private init() {}
    
    func saveLottoData(round: Int, lottoInfo: [Int]) {
        let key = String(round)
        
        UserDefaults.standard.set(lottoInfo, forKey: key)
    }
    
    func getLottoData(round: Int) -> [Int]? {
        let key = String(round)
        
        guard let result = UserDefaults.standard.array(forKey: key) as? [Int]? else { return nil }
        
        return result
    }
}
