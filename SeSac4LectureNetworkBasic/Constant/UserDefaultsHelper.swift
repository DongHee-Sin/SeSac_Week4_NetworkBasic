//
//  UserDefaultsHelper.swift
//  SeSac4LectureNetworkBasic
//
//  Created by 신동희 on 2022/08/01.
//

import Foundation


class UserDefaultsHelper {
    
    private init() {}
    
    static let shared = UserDefaultsHelper()
    
    let userDefaults = UserDefaults.standard    // standard > singleton pattern
    
    enum Key: String {
        case nickname, age
    }
    
    var nickname: String {
        get {
            return userDefaults.string(forKey: Key.nickname.rawValue) ?? "대장"
        }
        set {
            userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    
    var age: Int {
        get {
            return userDefaults.integer(forKey: Key.age.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
    
}
