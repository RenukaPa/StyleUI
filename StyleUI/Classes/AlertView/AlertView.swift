//
//  AlertView.swift
//  FBSnapshotTestCase
//
//  Created by Renuka Pandey on 29/07/22.
//

import Foundation
import UIKit

public class AlertView: UIView {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lbl: UILabel!
    
    var dissmiss: (() -> Void)?
    
    public enum AlertType {
        case warn
        case success
        case fail
        case notify
    }
    
    var type: AlertType = .success {
        didSet {
            var bgColor: UIColor!
            switch type {
            case .success:
                bgColor = UIColor(red: 0, green: 169, blue: 54, alpha: 1)
            case .fail:
                bgColor = UIColor(red: 150, green: 0, blue: 0, alpha: 1)
            case .warn:
                bgColor = .orange
            case .notify:
                bgColor = .lightGray
            }
            self.bgView.backgroundColor = bgColor
        }
    }
    
    public var textContent: String? {
        willSet(value) {
            self.lbl.text = value
        }
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initializeContent()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initializeContent()
    }
    
    private func initializeContent() {
        _ = fromNib(nibName: String(describing: AlertView.self), isInherited: true)
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipe(gesture:)))
        self.bgView.backgroundColor = UIColor.clear
        upSwipe.direction = .up
        upSwipe.delegate = self
        bgView.isUserInteractionEnabled = true
        bgView.addGestureRecognizer(upSwipe)
    }
}

extension AlertView: UIGestureRecognizerDelegate {
    @objc func respondToSwipe(gesture: UIGestureRecognizer) {
        if let swipe = gesture as? UISwipeGestureRecognizer {
            if swipe.direction == .up{
                DispatchQueue.main.async {
                    self.dissmiss?()
                }
            }
        }
    }
}

extension UIView {
    func fromNib<T: UIView>(nibName: String, isInherited: Bool = false) -> T? {
        let bundle = Bundle(for: type(of: self))
        guard let customView = bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as? T else {
            return nil
        }
        customView.backgroundColor = .clear
        if isInherited {
            self.insertSubview(customView, at: 0)
        } else {
            self.addSubview(customView)
        }
        
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.viewConstraint(view: self)
        return customView
    }
    
    func viewConstraint(view: UIView) {
        NSLayoutConstraint(item: self,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .leading,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: self,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .trailing,
                           multiplier: 1.0,
                           constant: 0).isActive = true

        NSLayoutConstraint(item: self,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .top,
                           multiplier: 1.0,
                           constant: 0).isActive = true

        NSLayoutConstraint(item: self,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: 0).isActive = true
    }
}
