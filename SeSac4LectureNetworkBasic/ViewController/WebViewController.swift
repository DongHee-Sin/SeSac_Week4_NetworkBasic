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
            present404Alert()
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    
    @IBAction func dismissButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    
    @IBAction func reloadButtonTapped(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    
    @IBAction func forwardButtonTapped(_ sender: UIBarButtonItem) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    
    func present404Alert() {
        let alertController = UIAlertController(title: "404", message: "NOT FOUND", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
}



extension WebViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchURL = searchBar.text?.lowercased() else { return }
        
        if searchURL.hasPrefix("http://") || searchURL.hasPrefix("https://") {
            openWebView(url: searchURL)
        }else {
            openWebView(url: "https://" + searchURL)
        }
    }
}
