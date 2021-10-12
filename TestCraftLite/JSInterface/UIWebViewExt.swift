//
//  KWebView.swift
//  JSInterface
//
//  Created by Kem on 9/12/15.
//  Copyright © 2015 Kem. All rights reserved.
//

import Foundation
import UIKit
import JavaScriptCore
import WebKit


extension WKWebView {
    func addJavascriptInterface<T : JSExport>(_ object: T, forKey key: String){
        __globalWebViews.append(self)
        __globalKeyBinding = key
        __globalExportObject = object
    }
}


extension NSObject
{
    func webView(_ webView: WKWebView!, didCreateJavaScriptContext context: JSContext!, forFrame frame: AnyObject!)
    {
        let notifyDidCreateJavaScriptContext = {() -> Void in
            for webView in __globalWebViews
            {
                let checksum = "__KKKWebView\(webView.hash)"
                webView.evaluateJavaScript("var \(checksum) = '\(checksum)'")
                if context.objectForKeyedSubscript(checksum).toString() == checksum
                {
                    context.setObject(__globalExportObject, forKeyedSubscript: __globalKeyBinding as (NSCopying & NSObjectProtocol)?)
                }
            }
        }

        if (Thread.isMainThread)
        {
            notifyDidCreateJavaScriptContext()
        }
        else
        {
            DispatchQueue.main.async(execute: notifyDidCreateJavaScriptContext)
        }
    }
}

var __globalWebViews : [WKWebView] = []
var __globalExportObject : AnyObject? = nil
var __globalKeyBinding : String = "Android" //placeholder
