//
//  ImageSearchAPIManager.swift
//  SeSac4LectureNetworkBasic
//
//  Created by 신동희 on 2022/08/05.
//

import Foundation

import Alamofire
import SwiftyJSON


// 과제 : 클래스 싱글톤 vs 구조체 싱글톤
class ImageSearchAPIManager {
    
    typealias completionHandler = (Int, [String]) -> Void
    
    
    // MARK: - Propertys
    static let shared = ImageSearchAPIManager()
    private init() {}
    
    
    // MARK: - Methods
    func fetchImageData(query: String, startPage: Int, completionHandler: @escaping completionHandler) {
        // 인코딩
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=\(startPage)"
        
        // HTTP Header => Key: Value 형식
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                let statusCode = response.response?.statusCode ?? 500
                
                if 200..<300 ~= statusCode {
                    
                    let result = json["items"].arrayValue.map {
                        $0["link"].stringValue
                    }
                    let totalCount = json["total"].intValue
                    
                    completionHandler(totalCount, result)
                    
                }else {
                    print("STATUSCODE : \(statusCode)")
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}
