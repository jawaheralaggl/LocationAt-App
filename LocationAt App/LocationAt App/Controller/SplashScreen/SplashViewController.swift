//
//  SplashViewController.swift
//  LocationAt App
//
//  Created by Jawaher Alagel on 12/27/20.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    var animationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lottieAnimation()
    }
    
    // MARK: - lottieAnimation method
    
    func lottieAnimation() {
        animationView = .init(name: "splash")
        animationView?.frame = CGRect(x: 0, y: 0, width: 500, height: 500)
        animationView?.center = CGPoint(x: view.frame.size.width  / 2,
                                        y: view.frame.size.height / 2)
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .playOnce
        view.addSubview(animationView!)
        animationView?.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            // Enter app first VC..
            let vc = PlacesViewController()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.show(vc, sender: nil)
        }
    }
    
}
