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
    private enum Constants {
        case title
        var text: String {
            switch self {
            case .title: return "Info"
            }
        }
    }
    
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupWebView()
    }
    
    func openUrl(_ url: URL) {
        webView.load(URLRequest(url: url))
    }
    
    private func setupWebView() {
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupNavigationBar() {
        let navigationBar = navigationController?.navigationBar
        let imageConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: .systemGray2)
        navigationBar?.backgroundColor = .darkGray
        navigationBar?.tintColor = .white
        title = Constants.title.text
        navigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(icon: .xmarkCircle)?.withConfiguration(imageConfiguration),
            style: .plain,
            target: self,
            action: #selector(onRightBarButtonTap)
        )
    }
    
    @objc func onRightBarButtonTap() {
        self.navigationController?.dismiss(animated: true)
    }
}

