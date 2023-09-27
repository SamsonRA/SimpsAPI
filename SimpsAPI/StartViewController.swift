//
//  ViewController.swift
//  SimpsAPI
//
//  Created by . on 27.09.2023.
//

import UIKit
import Spring
import SnapKit

class StartViewController: UIViewController {
    
    
    var cloudOneImageView = UIImageView()
    var cloudTwoImageView = UIImageView()
    var cloudThreeImageView = UIImageView()
    
    var cloudOneImage = UIImage(named: "cloud1")
    var cloudTwoImage = UIImage(named: "cloud3")
    var cloudThreeImage = UIImage(named: "cloud2")
    var startButton = SpringButton()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStartButton()
        
        
        
        cloudOneImageView = UIImageView(image: cloudOneImage)
        view.addSubview(cloudOneImageView)
        cloudOneImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(200)
        }
        
        cloudTwoImageView = UIImageView(image: cloudTwoImage)
        view.addSubview(cloudTwoImageView)
        cloudTwoImageView.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalToSuperview().inset(300)
        }
        
        cloudThreeImageView = UIImageView(image: cloudThreeImage)
        view.addSubview(cloudThreeImageView)
        cloudThreeImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(500)
        }
        
        

    }
    
   
    func setupStartButton() {
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(UIColor(red: 246/255, green: 225/255, blue: 117/255, alpha: 1), for: .normal)
        startButton.titleLabel?.font = UIFont(name: "Chalkduster", size: 45)
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(100)
            make.centerX.centerY.equalToSuperview()
        }
        startButton.duration = 0.5
        startButton.delay = 0
        
        startButton.addTarget(self, action: #selector(startButtonIsTapped), for: .touchUpInside)
        
        
    }
    
    @objc func startButtonIsTapped() {
      
        UIView.animate(withDuration: 1.0) {
            self.cloudOneImageView.frame.origin.x -= self.cloudOneImageView.frame.width
            self.cloudTwoImageView.frame.origin.x += self.cloudTwoImageView.frame.width
            self.cloudThreeImageView.frame.origin.x -= self.cloudThreeImageView.frame.width
        } completion: { _ in
            self.cloudOneImageView.isHidden = true
            self.cloudTwoImageView.isHidden = true
            self.cloudThreeImageView.isHidden = true
            self.showCharacter()
        }
    }
    func showCharacter() {
        let vc = CharacterViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true )
    }
}
