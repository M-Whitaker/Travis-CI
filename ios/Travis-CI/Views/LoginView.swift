//
//  LoginView.swift
//  Travis-CI
//
//  Created by Matt Whitaker on 18/02/2020.
//  Copyright © 2020 Matt Whitaker. All rights reserved.
//

import SwiftUI
import AuthenticationServices
import WebKit

final internal class LoginView: NSObject, UIViewRepresentable {
    var _loginWebView: WKWebView!

    func makeUIView(context: Context) -> WKWebView  {
        _loginWebView = WKWebView(frame: .zero)
        _loginWebView.navigationDelegate = self
        return _loginWebView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
//        let request = URLRequest(url: URL(string: "https://github.com/login/oauth/authorize?client_id=\(clientId)")!)
//        uiView.load(request)
    }

}

extension LoginView: WKNavigationDelegate
{
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
//        print(webView.url!)
        let oauthToken = NSURLComponents(string: (webView.url!.absoluteString))?.queryItems?.filter({$0.name == "code"}).first
        guard (oauthToken != nil) else {
            return
        }
        
         decisionHandler(.allow)
    }
}
