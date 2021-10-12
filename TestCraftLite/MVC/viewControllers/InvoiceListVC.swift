//
//  InvoiceListVC.swift
//  TestCraft
//
//  Created by ADMS on 05/09/19.
//  Copyright © 2019 ADMS. All rights reserved.
//

import UIKit
import WebKit;

class InvoiceListVC: UIViewController, ActivityIndicatorPresenter, SuccessFailedDelegate, WKNavigationDelegate
{

    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var imgView = UIImageView()

    @IBOutlet var webview: WKWebView!
    @IBOutlet var lblTitle : UILabel!
    var strTitle   = ""
    var strLoadUrl   = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = strTitle
        // Do any additional setup after loading the view.
        let request = NSMutableURLRequest(url: NSURL(string: strLoadUrl)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
//        request.httpBody = postdata.data(using: .utf8)
//        request.httpMethod = "POST"
//        request.allHTTPHeaderFields = headers
        //Bhargav Hide
print("Load URL:",strLoadUrl)
//        webview.uiDelegate = self as? WKUIDelegate
//        webview.navigationDelegate = self
//        self.webview.navigationDelegate = self
//        webview.is
        webview.load(request as URLRequest)
//        self.showActivityIndicator()

//        webview.delegate = self
//        webview.loadRequest(request as URLRequest)
//        webview.scalesPageToFit = yes
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Don't forget to reset when view is being removed
//        if UIDevice.current.orientation.isLandscape {
//            print("landscape")
//            AppUtility.lockOrientation(.portrait)
//            let value = UIInterfaceOrientation.portrait.rawValue
//            UIDevice.current.setValue(value, forKey: "orientation")
//        } else {
//            print("portrait")
//        }
        AppUtility.lockOrientation(.portrait)

    }
    @IBAction func Back_Clicked(_ sender: UIButton) {
//        if UIDevice.current.orientation.isLandscape {
//            print("landscape")
            AppUtility.lockOrientation(.portrait)
//            let value = UIInterfaceOrientation.portrait.rawValue
//            UIDevice.current.setValue(value, forKey: "orientation")
//        } else {
//            print("portrait")
//        }
        navigationController?.popViewController(animated: true)
    }

    //MARK: WEBVIEW DELEGATE
    

      func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
    }

      func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
        self.hideActivityIndicator()
    }

      private func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
            print(error.localizedDescription)
        self.hideActivityIndicator()

        }
//     func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//          print("Strat to load")
//            //        self.rowHeights[self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans.count - 1] = nil
//            print("Load start...\n",webView)
//            //        webView.frame.size.height = 1
//            //        self.rowHeights[webView.tag] = 0.0
//        }
//        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//          print("finish to load")
//    //        print("Load did Finish...\n",webView)
//
//    }
//
//        private func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
//              print(error.localizedDescription)
//        }
}
