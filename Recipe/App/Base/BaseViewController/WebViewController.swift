//
//  ZKBaseWebViewController.swift
//  DrivingTour
//
//  Created by 陈雄 on 2020/1/3.
//  Copyright © 2020 Zack. All rights reserved.
//

import UIKit
import WebKit

/// 基类浏览器
class WebViewController: ViewController {

    var url: String? {
        didSet {
            QL1(url)
            guard let url = url else { return }
            guard let urlTmp = URL(string: url) else { return }
            webView.load(URLRequest(url: urlTmp))
        }
    }
    
    private var progressKVOhandle: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.top.equalTo(navView.snp.bottom)
            make.left.bottom.right.equalTo(self.view)
        }
        
        view.addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(2)
            make.top.equalTo(navView.snp.bottom)
        }
        
        self.progressKVOhandle = webView.observe(\.estimatedProgress, options: NSKeyValueObservingOptions.new, changeHandler: { [weak self] (webView, change) in
            self?.progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            if webView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                    self?.progressView.isHidden = true
                }, completion: { (finish) in
                    self?.progressView.setProgress(0.0, animated: false)
                })
            }
        })
    }
    
    deinit {
        progressKVOhandle = nil
    }
    
    lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        config.preferences.javaScriptEnabled = true // //设置js跳转
        //不自动打开窗口
        config.preferences.javaScriptCanOpenWindowsAutomatically = true
        let webView = WKWebView(frame: CGRect.zero, configuration: config)
        webView.allowsBackForwardNavigationGestures = true
        webView.uiDelegate = self
        webView.navigationDelegate = self
        return webView
    }()
    
    lazy private var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.tintColor = UIColor.kColor49B // 进度条颜色
        progressView.trackTintColor = UIColor.white // 进度条背景色
        return progressView
    }()

}

// MARK: - WKUIDelegate, WKNavigationDelegate
extension WebViewController: WKUIDelegate, WKNavigationDelegate {
    /// 页面开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.navView.title = "加载中..."
    }
    
    func webViewDidClose(_ webView: WKWebView) {
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.progressView.isHidden = true
        self.navView.title = webView.title ?? ""
        
    }
    
    // 加载失败隐藏进度条+++
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.progressView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        decisionHandler(.allow)
    }
    
}
