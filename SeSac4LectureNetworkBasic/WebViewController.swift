//
//  WebViewController.swift
//  SeSac4LectureNetworkBasic
//
//  Created by 신동희 on 2022/07/28.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    // MARK: - Propertys
    
    // App Transport Scurity Settings
    // http 사이트는 대부분 오픈되지 않음 (보편적인 사이트는 애플이 내부적으로 ..)
    var destinationURL: String = "https://www.apple.com"
    
    
    
    
    // MARK: - Outlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var webView: WKWebView!
    
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        openWebView (url: destinationURL)
    }

    
    
    
    // MARK: - Methods
    func openWebView(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
}



extension WebViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        openWebView(url: searchBar.text!)
    }
}