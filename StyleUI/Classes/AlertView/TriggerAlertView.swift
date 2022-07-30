//
//  TriggerAlertView.swift
//  Pods-StyleUI_Example
//
//  Created by Renuka Pandey on 30/07/22.
//

import Foundation
import UIKit

struct MessageStyle {
    var type: AlertView.AlertType!
    var msg: String!
}

public class TriggerAlertView {
    public init() {}
    var alertView: AlertView!
    let alertHeight: CGFloat = 120.0
    var defaultYPos: CGFloat = -100.0
    var animationTime: TimeInterval = 0.5
    var timer: Timer?
    var openAlertInBottom: (() -> Void)?
    
    public func setAlert(message: String? = "",
                         type: AlertView.AlertType,
                     fromBottom: (() -> Void)? = nil) {
        self.openAlertInBottom = fromBottom
        let msgStyle = MessageStyle(type: type, msg: message)
        self.showAlertView(msg: msgStyle)
    }
    
    func showAlertView(msg: MessageStyle) {
        if self.alertView == nil {
            let rect = CGRect(x: 0,
                              y: defaultYPos,
                              width: UIApplication.shared.keyWindow?.frame.width ?? 0.0,
                              height: alertHeight)
            alertView = AlertView(frame: rect)
        }
        
        alertView.dissmiss = {
            self.timer?.invalidate()
            UIView.animate(withDuration: self.animationTime,
                           delay: 0.0,
                           options: [.allowUserInteraction],
                           animations: {self.alertView.frame.origin.y = self.defaultYPos},
                           completion: { _ in
                            self.alertView.removeFromSuperview()
                            self.alertView = nil
                           })
        }
        
        alertView.textContent = msg.msg
        alertView.type = msg.type
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(alertView)
            window.bringSubviewToFront(alertView)
        }
        self.startAnimation()
    }
    
    func startAnimation() {
        guard alertView != nil else {
            return
        }
        
        UIView.animate(withDuration: animationTime) {
            self.alertView.frame.origin.y = 0.0
        }
        
        timer = Timer.scheduledTimer(timeInterval: 5.0,
                                     target: self,
                                     selector: #selector(hideAlertView),
                                     userInfo: nil,
                                     repeats: false)
    }
    
    @objc func hideAlertView() {
        if alertView != nil {
            UIView.animate(withDuration: self.animationTime,
                           delay: 5.0,
                           options: [.allowUserInteraction],
                           animations: {
                            self.alertView.frame.origin.y = self.defaultYPos
                           },
                           completion: { _ in
                            self.alertView.removeFromSuperview()
                            self.alertView = nil
                           })
        }
    }
}
