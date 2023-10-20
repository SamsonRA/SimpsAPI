//
//  CharacterViewController.swift
//  SimpsAPI
//
//  Created by . on 27.09.2023.
//

import UIKit
import SnapKit
import Alamofire

class CharacterViewController: UIViewController {
    //    private let presenter: CharacterPresenter
    //    init(presenter: CharacterPresenter){
    //        self.presenter = presenter
    //        super.init(nibName: nil, bundle: nil)
    //
    //    }
    
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    private lazy var showButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 254/255, green: 228/255, blue: 106/255, alpha: 1)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 6
        button.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        return button
    }()
    
    private lazy var closeButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 254/255, green: 228/255, blue: 106/255, alpha: 1)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 6
        button.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        
        return button
    }()
    
    private var mainLabel = {
        let label =  UILabel()
        label.text = "Quotes by\n" + "The Simpsons"
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont(name: "Bradley Hand", size: 25)
        label.textColor = UIColor(red: 242/255, green: 75/255, blue: 80/255, alpha: 1)
        
        return label
    }()
    
    private var quote = {
        let label = UILabel()
        label.font = UIFont(name: "Noteworthy", size: 20)
        label.numberOfLines = 0
        return label
    }()
    private  var characterImageView = {
        let character = UIImageView()
        return character
    }()
    private  var characterName = {
        let name = UILabel()
        name.font = UIFont(name: "Noteworthy", size: 25)
        
        
        return name
    }()
    
    var imageActivityIndicatorView = UIActivityIndicatorView()
    
    
    
    let url = "https://thesimpsonsquoteapi.glitch.me/quotes"
    
    private var networkService = NetworkService()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.backgroundColor = .red
        showButtonSetup()
        closeButtonSetup()
        mainLabelSetup()
        quoteSet()
        characterImageViewSet()
        characterNameSet()
        activitySet()
        fetchData()
        
        
        
    }
    //        presenter.fetchData { [weak self] character, image in
    //                    self?.quote.text = character.quote
    //                    self?.characterName.text = character.character
    //                    self?.characterImageView.image = image
    //                    self?.imageActivityIndicatorView.stopAnimating()
    //        }
    private  func showData(character: Character) {
        
        quote.text = character.quote
        characterName.text = character.character
        networkService.requestImage(url: URL(string: character.image)!) { [weak self] image in
            self?.characterImageView.image = image
        }
        imageActivityIndicatorView.stopAnimating()
        
    }
    
    private func fetchData() {
        networkService.sendRequest(url: url) { [weak self] (result) in
            switch result {
            case .success(let value):
                self?.showData(character: value.first!)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    private func showButtonSetup()  {
        view.addSubview(showButton)
        showButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(70)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            showButton.addTarget(self, action: #selector(showButtonIsTapped), for: .touchUpInside)
        }
        
    }
    @objc func showButtonIsTapped() {
        
        fetchData()
        imageActivityIndicatorView.isHidden = false
        imageActivityIndicatorView.startAnimating()
        
    }
    
    private func closeButtonSetup() {
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.right.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(70)
            closeButton.addTarget(self, action: #selector(backButtonIsTapped), for: .touchUpInside)
        }
    }
    @objc func backButtonIsTapped() {
        
        dismiss(animated: true)
        
    }
    
    private func mainLabelSetup() {
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(70)
        }
    }
    private func quoteSet() {
        view.addSubview(quote)
        quote.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(25)
            make.top.equalToSuperview().inset(150)
            quote.text = ""
        }
    }
    private func characterImageViewSet() {
        view.addSubview(characterImageView)
        characterImageView.snp.makeConstraints { make in
            make.height.equalTo(379)
            make.width.equalTo(305)
            make.centerX.equalToSuperview()
            make.top.equalTo(quote).inset(120)
        }
    }
    private func characterNameSet(){
        view.addSubview(characterName)
        characterName.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp_bottomMargin).offset(25)
            make.right.equalToSuperview().inset(55)
        }
        characterName.text = ""
    }
    private func activitySet() {
        view.addSubview(imageActivityIndicatorView)
        imageActivityIndicatorView.startAnimating()
        imageActivityIndicatorView.hidesWhenStopped = true
        imageActivityIndicatorView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            
        }
    }
    
}
