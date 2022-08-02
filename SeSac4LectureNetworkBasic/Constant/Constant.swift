//
//  Constant.swift
//  SeSac4LectureNetworkBasic
//
//  Created by 신동희 on 2022/08/01.
//

import Foundation


//enum StoryboardName: String {
//    case Main
//    case Search
//    case Setting
//    case Select
//}


//struct StoryboardName {
//    static let main = "Main"
//    static let search = "Search"
//    static let setting = "Setting"
//    static let select = "Select"
//}



enum StoryboardName {
    static let main = "Main"
    static let search = "Search"
}


struct APIKey {
    static let BOXOFFICE = "83b8a92cbbbe9e9850f1a7f21e4c664a"
    static let NAVER_ID = "S2CRE1FBnuy66QjrglFR"
    static let NAVER_SECRET = "8f80i9RFr2"
}

struct EndPoint {
    static let boxOfficeURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
    static let translateURL = "https://openapi.naver.com/v1/papago/n2mt"
    static let lottoURL = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&"
    
}
