//
//  ImageSearchViewController.swift
//  SeSac4LectureNetworkBasic
//
//  Created by 신동희 on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON

class ImageSearchViewController: UIViewController {

    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestImage()
    }
    
    
    
    // MARK: - Methods
    
    // fetch___, request___, call___, get___ > response에 따라 네이밍을 설정하기도 함
    func requestImage() {
        let text = "과자".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=1"
        
        // HTTP Header => Key: Value 형식
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { [unowned self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
