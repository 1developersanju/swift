//  ViewController.swift

import UIKit
import AVFoundation
//import QRCodeScanner
//import QRCodeReader
import SwiftQRScanner

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = false
        let screenHeight = UIScreen.main.bounds.height
        print("UIScreen.main.bounds.height \(screenHeight)")

        let screenBounds = UIScreen.main.bounds
        let screenScale = UIScreen.main.scale
        let screenSize = CGSize(width: screenBounds.size.width * screenScale, height: screenBounds.size.height * screenScale)
        print("resolution \(screenSize), height \(screenSize.height)")
        
        var backgroundImageName = "bg-\(screenSize.height).jpg".replacingOccurrences(of: ".0", with: "")
        let bgImg = UIImage(named: backgroundImageName)
        if(bgImg != nil) {
            backgroundImage.image = bgImg
        }else{
            backgroundImage.image = UIImage(named: "bg-2436.png")
        }
        print("backg \(backgroundImageName)")
    }

//    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
//        reader.dismiss(animated: true, completion: {
//            let key = String(result.value.suffix(12))
//            let defaults = UserDefaults.standard
//            defaults.set(key, forKey: "ConnectionKey")
//            print("connkey = \(key)")
//    //            let searchVC = SearchViewController()
//    //            self.present(searchVC, animated: true, completion: nil)
//            let vc = self.storyboard!.instantiateViewController(withIdentifier: "SearchVC")
//            self.present(vc, animated: true, completion: nil)
//        })
//    }
//
//    func readerDidCancel(_ reader: QRCodeReaderViewController) {
//        reader.dismiss(animated: true, completion: {
//            print("QR Canceled")
//        })
//    }
//
//    lazy var readerVC: QRCodeReaderViewController = {
//        let builder = QRCodeReaderViewControllerBuilder {
//            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
//
//            // Configure the view controller (optional)
//            $0.showTorchButton        = false
//            $0.showSwitchCameraButton = false
//            $0.showCancelButton       = true
//            $0.showOverlayView        = false
//            $0.rectOfInterest         = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
//        }
//        return QRCodeReaderViewController(builder: builder)
//    }()
//
    /// Start the QR code scan
    @IBAction func scanQR(_ sender: Any) {
//        let viewController = QRCodeScanViewController.create()
//        viewController.delegate = self
//        self.present(viewController, animated: true)
        
//        readerVC.delegate = self
//        readerVC.modalPresentationStyle = .formSheet
//        present(readerVC, animated: true, completion: nil)

        let scanner = QRCodeScannerController()
        scanner.delegate = self
        self.present(scanner, animated: true, completion: nil)
    }
    
    // MARK: QRCodeScanViewControllerDelegate
    
    /// Called when the camera scans a QR code
    /// - Parameters:
    ///   - viewController: View controller that scanned the QR code
    ///   - value: String encoded in the QR code
//    func qrCodeScanViewController(_ viewController: QRCodeScanViewController, didScanQRCode value: String) {
//
//        // Dismiss the view controller
//        viewController.dismiss(animated: true) {
//            // Show an alert with the scanned value
////            let alert = UIAlertController(title: "Scanned value", message: value, preferredStyle: .alert)
////            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
////            self.present(alert, animated: true)
//            let key = String(value.suffix(12))
//            let defaults = UserDefaults.standard
//            defaults.set(key, forKey: "ConnectionKey")
//            print("connkey = \(key)")
////            let searchVC = SearchViewController()
////            self.present(searchVC, animated: true, completion: nil)
//            let vc = self.storyboard!.instantiateViewController(withIdentifier: "SearchVC")
//            self.present(vc, animated: true, completion: nil)
//        }
//    }
}


extension ViewController: QRScannerCodeDelegate {
    func qrScanner(_ controller: UIViewController, scanDidComplete result: String) {
        controller.dismiss(animated: true, completion: {
            let key = String(result.suffix(12))
            let defaults = UserDefaults.standard
            defaults.set(key, forKey: "ConnectionKey")
            print("connkey = \(key)")
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "SearchVC")
            self.present(vc, animated: true, completion: nil)
        })
    }
    
    func qrScannerDidFail(_ controller: UIViewController, error: String) {
        controller.dismiss(animated: true, completion: {
        })
    }
    
    func qrScannerDidCancel(_ controller: UIViewController) {
        controller.dismiss(animated: true, completion: {
        })
    }
    
    
}
