//
//  MyPackageTableViewCell.swift
//  TestCraftLite
//
//  Created by ADMS on 07/04/21.
//

import UIKit
import LoadingPlaceholderView
import WebKit


class MyPackageTableViewCell: UITableViewCell {

    @IBOutlet var imgIcon:UIImageView!
    @IBOutlet var imgBackGround:UIImageView!
    @IBOutlet var topbgView1:UIView!
    @IBOutlet var lblPackageName:UILabel!
    @IBOutlet var lblStartDate:UILabel!
    @IBOutlet var lblEndDate:UILabel!
    @IBOutlet var lblPrice:UILabel!
    @IBOutlet var btnViewPackage:UIButton!
    @IBOutlet var btnTest:UIButton!
    @IBOutlet var lblNumTest:UILabel!
    @IBOutlet var lblMarks:UILabel!
    @IBOutlet var lblGetMarks:UILabel!
    @IBOutlet var imgRightSelection:UIImageView!
    @IBOutlet var lblTestTime:UILabel!

    @IBOutlet var viewProgressTestReport : UIView!
    @IBOutlet var btnStart:UIButton!
    @IBOutlet var btnAnalyse:UIButton!
    @IBOutlet var btnReStart:UIButton!
    @IBOutlet var btnSeeAll:UIButton!
    @IBOutlet var btnCreateTest:UIButton!
    @IBOutlet var HeaderBottomHeight:NSLayoutConstraint!

    @IBOutlet var btnPopupView:UIButton!
    //var optionsMenu = DropDown()


    @IBOutlet var headerHeight:NSLayoutConstraint!

    //My PackageVC MyPackageTableViewHeaderCell
    var progressRing: CircularProgressBar!
    @IBOutlet var lblAvilableTests:UILabel!
    @IBOutlet var lblPendingTests:UILabel!
    @IBOutlet var lblPercentage:UILabel!
    @IBOutlet var btnTestReport:UIButton!
    @IBOutlet var btnSummaryReport:UIButton!
    @IBOutlet var btnKnowlageGapReport:UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}


class SubmitSummaryTableViewCell: UITableViewCell {

    //    @IBOutlet var imgIcon:UIImageView!
    @IBOutlet var topbgView1:UIView!
    @IBOutlet var lbl_Title:UILabel!
    @IBOutlet var lbl_Attempted:UILabel!
    @IBOutlet var lbl_NotAttempted:UILabel!

    @IBOutlet var headerHeight:NSLayoutConstraint!
    //    @IBOutlet var btnTryAgain:UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

class AnswerTableViewCell: UITableViewCell {
    private var loadingPlaceholderView = LoadingPlaceholderView()

    @IBOutlet var btnWord:UIButton!
    @IBOutlet var lblView:UILabel!
    @IBOutlet var lblDisplayNo:UILabel!
    @IBOutlet var headerHeight:NSLayoutConstraint!
    @IBOutlet var imgQueAns:UIImageView!
    @IBOutlet var imgSelected:UIImageView!
    @IBOutlet var bgView:UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//class TextFieldAnswerTableViewCell: UITableViewCell {
//    private var loadingPlaceholderView = LoadingPlaceholderView()
//
////    @IBOutlet var btnWord:UIButton!
////    @IBOutlet var lblView:UILabel!
//    @IBOutlet var headerHeight:NSLayoutConstraint!
////    @IBOutlet var imgQueAns:UIImageView!
//    @IBOutlet var txtWriteAns:UITextView!
//    @IBOutlet var imgSelected:UIImageView!
//    @IBOutlet var bgView:UIView!
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
////    public func configure(text: String?, placeholder: String) {
////        txtWriteAns.text = text
//////        txtWriteAns.placeholder = placeholder
////
////        txtWriteAns.accessibilityValue = text
////        txtWriteAns.accessibilityLabel = placeholder
////    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//
//}


class QuestionTableViewCell: UITableViewCell {
    public var loadingPlaceholderView = LoadingPlaceholderView()

    @IBOutlet var btnWord:UIButton!
    @IBOutlet var lblView:UILabel!
    @IBOutlet var headerHeight:NSLayoutConstraint!
    @IBOutlet var imgQueAns:UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class TextFieldAnswerTableViewCell: UITableViewCell {
    private var loadingPlaceholderView = LoadingPlaceholderView()

    //    @IBOutlet var btnWord:UIButton!
    //    @IBOutlet var lblView:UILabel!
    @IBOutlet var headerHeight:NSLayoutConstraint!
    //    @IBOutlet var imgQueAns:UIImageView!
    @IBOutlet var txtWriteAns:UITextView!
    @IBOutlet var imgSelected:UIImageView!
    @IBOutlet var bgView:UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //    public func configure(text: String?, placeholder: String) {
    //        txtWriteAns.text = text
    ////        txtWriteAns.placeholder = placeholder
    //
    //        txtWriteAns.accessibilityValue = text
    //        txtWriteAns.accessibilityLabel = placeholder
    //    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
class QueAnsCollectionViewCell: UICollectionViewCell {

    @IBOutlet var bgView:UIView!
    @IBOutlet var imgIcon:UIImageView!
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var lblLine:UILabel!
    @IBOutlet var lblAlertDot:UILabel!

    func displayData(_ folderName:String, _ strImageName:String) {

        lblTitle.text = strImageName

        //        if folderName == "Main" {
        //            lblTitle.font = FontHelper.lato_bold(size: DeviceType.isIphone5 ? 15 : DeviceType.isIpad ? 24 : 18)
        //        }else {
        //            lblTitle.font = FontHelper.lato_bold(size: DeviceType.isIphone5 ? 13 : DeviceType.isIpad ? 22 : 16)
        //        }
        //        imgIcon.getImagesfromLocal(folderName, strImageName)
    }

}
class SwAnalysisTableViewCell: UITableViewCell {

    @IBOutlet var imgIcon:UIImageView!
    //    @IBOutlet var imgBackGround:UIImageView!
    @IBOutlet var topbgView1:UIView!
    @IBOutlet var lblTitle:UILabel!
    //    @IBOutlet var lblSubTitle:UILabel!
    @IBOutlet var btnExpand:UIButton!
    @IBOutlet var imgDerctionIcon:UIImageView!
    @IBOutlet var bottomBorderView:UIView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
class ExplanationTableViewCell: UITableViewCell {
    private var loadingPlaceholderView = LoadingPlaceholderView()

    //    @IBOutlet var btnWord:UIButton!
    //    @IBOutlet var lblView:UILabel!
    @IBOutlet var headerHeight:NSLayoutConstraint!
    //    @IBOutlet var imgQueAns:UIImageView!
    //    @IBOutlet var imgSelected:UIImageView!
    @IBOutlet var bgView:UIView!
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var lblSubTitle:UILabel!
    @IBOutlet weak var webViewIn: WKWebView!

    //@IBOutlet var webViewIn:WKWebView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //    public func configure(text: String?, placeholder: String) {
    //        txtWriteAns.text = text
    ////        txtWriteAns.placeholder = placeholder
    //
    //        txtWriteAns.accessibilityValue = text
    //        txtWriteAns.accessibilityLabel = placeholder
    //    }

    //    override func setSelected(_ selected: Bool, animated: Bool) {
    //        super.setSelected(selected, animated: animated)
    //
    //        // Configure the view for the selected state
    //    }
    //MARK: WEBVIEW DELEGATE

    //
    //        func webViewDidStartLoad(_ webView: UIWebView)
    //        {
    ////            self.showActivityIndicator()
    //        }
    //
    //        func webViewDidFinishLoad(_ webView: UIWebView) {
    ////            self.hideActivityIndicator()
    //
    //    //        let contentSize:CGSize = self.webview.scrollView.contentSize
    //    //        let viewSize:CGSize = self.view.bounds.size
    //
    //    //        let rw = viewSize.width / contentSize.width
    //    //        self.webview.scalesPageToFit = true
    //    //        self.webview.contentMode = UIView.ContentMode.scaleAspectFit
    //    //        self.webview.scrollView.minimumZoomScale = 0
    //    //        self.webview.scrollView.maximumZoomScale = 20
    //    //        self.webview.scrollView.zoomScale = 0
    //    //                self.webview.scrollView.bouncesZoom = false
    //
    //        }
    //
    //        func webView(_ webView: UIWebView, didFailLoadWithError error: Error)
    //        {
    //            //Bhargav Hide
    ////print("loaderror",error)
    ////            self.hideActivityIndicator()
    //
    //        }
    //
    //        func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
    //    //        if (request.url?.absoluteString  == "https://biz.traknpay.in/tnp/return_page_android.php") {
    //    //            webview.addJavascriptInterface(JSInterface(), forKey: "Android");
    //    //        }
    //            return true
    //        }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
}
class SwAnalysisHeaderTableViewCell: UITableViewCell {

    @IBOutlet var imgIcon:UIImageView!
    //    @IBOutlet var imgBackGround:UIImageView!
    @IBOutlet var topbgView1:UIView!
    @IBOutlet var bottomBorderView:UIView!
    @IBOutlet var lblTitle:UILabel!
    //    @IBOutlet var lblSubTitle:UILabel!
    @IBOutlet var btnExpand:UIButton!
    @IBOutlet var imgDerctionIcon:UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
