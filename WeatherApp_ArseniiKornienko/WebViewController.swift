//
//  WebViewController.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/11/24.
//

import UIKit
import SnapKit
import WebKit

final class WebViewController: UIViewController {
    
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }
    
    private func setupWebView() {
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func openUrl(_ url: URL) {
        webView.load(URLRequest(url: url))
    }
}

