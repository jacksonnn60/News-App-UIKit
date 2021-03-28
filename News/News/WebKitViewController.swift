//
//  WebKitViewController.swift
//  News
//
//  Created by Jacksons MacBook on 28.03.2021.
//

import UIKit
import WebKit

class WebKitViewController: UIViewController {
    
    var url: URL?
    
    private var webView: WKWebView = {
        let webView = WKWebView()
        return webView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Read more"
        view.addSubview(webView)
        webView.load(URLRequest(url: url!))
        
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        webView.frame = view.bounds
    }
    
}
