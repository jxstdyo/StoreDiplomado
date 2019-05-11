//
//  MTableViewCell.swift
//  Store Headphones Hi FI
//
//  Created by Antonyo Chavez Saucedo on 3/27/19.
//  Copyright © 2019 Antonyo Chavez Saucedo. All rights reserved.
//

import UIKit

class MMainViewCell: UICollectionViewCell {
    public static let reuseIdentifier = "row"
    @IBOutlet weak var nombre: UITextView!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var marca: UITextView!
    
    var indexPath : IndexPath!
    var collectionView : UICollectionView!
    
    private lazy var backBottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.alpha = 0.5
        view.backgroundColor = UIColor.Flat.Blue.BlueWhale
        return view
    }()
    
    private lazy var totalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "$ 0.0"
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.alpha = 1.0
        return label
    }()
    
    private lazy var backTopView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.alpha = 0.5
        view.backgroundColor = UIColor.Flat.Blue.BlueWhale
        return view
    }()
    private lazy var nameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.alpha = 1.0
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func setupUI(){
        self.layer.cornerRadius = CGFloat(20.0)
        self.layer.borderColor = UIColor.Flat.Gray.Iron.cgColor
        self.layer.borderWidth = 2.0;
        
        self.addSubview(backTopView)
        self.addSubview(backBottomView)
        
        backBottomView.addSubview(totalTitleLabel)
        backBottomView.anchor(top: nil,
                              leading: self.leadingAnchor,
                              trailing: self.trailingAnchor,
                              bottom: self.bottomAnchor,
                              size : CGSize(width: 0, height : 40))
        totalTitleLabel.anchor(top: nil,
                               leading: self.leadingAnchor,
                               trailing: self.trailingAnchor,
                               bottom: nil)
        totalTitleLabel.topAnchor.constraint(equalTo: backBottomView.topAnchor, constant: 10).isActive = true
        
        backTopView.addSubview(nameTitleLabel)
        backTopView.anchor(top: self.topAnchor,
                           leading: self.leadingAnchor,
                           trailing: self.trailingAnchor,
                           bottom: nil,
                           size : CGSize(width: 0, height : 40))
        nameTitleLabel.anchor(top: nil,
                              leading: self.leadingAnchor,
                              trailing: self.trailingAnchor,
                              bottom: nil)
        nameTitleLabel.topAnchor.constraint(equalTo: backTopView.topAnchor, constant: 10).isActive = true
        
    }
    
    func setPrecio(precio : Double){
        totalTitleLabel.text = precio.toCurrency()
    }
    func setName(name : String){
        nameTitleLabel.text = name
    }
}
