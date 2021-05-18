//  ViewController.swift

import UIKit
import CoreMotion

class SearchViewController: UIViewController{
    
    let motionManager = CMMotionManager()
    var timer: Timer!
    var webSocketTask : URLSessionWebSocketTask!
    var connectionKey = ""
    var subscribed = false
    var isTorchLightOn = false
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var torchImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true
        motionManager.startAccelerometerUpdates()
        connectSocket()
        self.infoTextView.text = "You are connected.\nPress ‘ON’ to start searching."

    }
    @IBAction func goHome(_ sender: Any) {
        if (self.webSocketTask != nil && timer != nil){
            self.webSocketTask.cancel(with: .normalClosure, reason: nil)
            timer.invalidate()
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func toggleSearch(_ sender: Any) {
        searchButton.setTitle("", for: .normal)
        if (timer != nil && timer.isValid){
            timer.invalidate()
//            searchButton.titleLabel?.text = "Start Searching"
//            searchButton.setTitle("Start Searching", for: .normal)
//            searchButton.setTitleColor(.green, for: .normal)
//            infoImage.image = UIImage(named: "tilt.png")
            torchImage.image = UIImage(named: "on.png")
            infoTextView.text = "You are connected.\nPress ‘ON’ to start searching."
        }else{
            timer = Timer.scheduledTimer(timeInterval: 0.04, target: self, selector: #selector(SearchViewController.update), userInfo: nil, repeats: true)
//            searchButton.setTitle("Stop Searching", for: .normal)
//            searchButton.setTitleColor(.red, for: .normal)
            torchImage.image = UIImage(named: "off.png")
            infoTextView.text = "Slowly tilt & move your phone, your action will be reflected on your computer screen. Search the sounds & images of Kuala Lumpur. Take your time to guess the location of where by listening to it. \n\nPress the ‘X’ button on the top right corner when you have done enough searching. You'll get your question on the next page."
        }]
    }
    
    @objc func update() {
        if let accelerometerData = motionManager.accelerometerData {
            var x = Double(round(100*accelerometerData.acceleration.x)/100) * 10
            var y = Double(round(100*accelerometerData.acceleration.y)/100) * 10
            if (x > 0 && y > 0){
                x = x + 10.0;
                y = y + 5.0;
            }
            if(!self.subscribed){
                    do {
                        if let channelKey = UserDefaults.standard.object(forKey:"ConnectionKey") as? String{
                            let subscribeDict:[String:String] = ["command":"subscribe", "channel":"\(channelKey)"]
                            let message = URLSessionWebSocketTask.Message.string(try subscribeDict.toJson())
                            self.webSocketTask.send(message) { error in
                                if let error = error {
                                    print("WebSocket couldn’t send message because: \(error)")
                                }
                            }
                            print("subscribed")
                            self.subscribed = true
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }else{
                    do {
                        let messageDict:[String:String] = ["command":"message", "message":"\(x),\(y)"]
                        let message = URLSessionWebSocketTask.Message.string(try messageDict.toJson())
                        self.webSocketTask.send(message) { error in
                            if let error = error {
                                print("WebSocket couldn’t send message because: \(error)")
                            }
                        }
//                        print("updating.. \(self.connectionKey)")
//                        print(x, y)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
        }
    }
    
    func connectSocket(){
        let urlSession = URLSession(configuration: .default)
        self.webSocketTask = urlSession.webSocketTask(with:URL(string: "wss://tbmatekl.com/wss2/NNN")!)
        self.webSocketTask.resume()
        
        webSocketTask.receive { result in
            switch result {
            case .failure(let error):
                print("Error in receiving message: \(error)")
            case .success(let message):
                switch message {
                case .string(let text):
                    let dict = self.convertToDictionary(text: text)
                    if let connKey = dict?["connection_key"] as? String {
                        print("Received string: \(connKey)")
                    }
                case .data(let data):
                    print("Received data: \(data)")
                @unknown default:
                    print("Fatal error")
                }
            }
        }
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}

extension Dictionary {
    func toJson() throws -> String {
        let data = try JSONSerialization.data(withJSONObject: self)
        if let string = String(data: data, encoding: .utf8) {
            return string
        }
        throw NSError(domain: "Dictionary", code: 1, userInfo: ["message": "Data cannot be converted to .utf8 string"])
    }
}
