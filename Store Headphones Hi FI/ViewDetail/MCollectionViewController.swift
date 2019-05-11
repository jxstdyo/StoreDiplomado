//
//  MCollectionViewController.swift
//  Store Headphones Hi FI
//
//  Created by Antonyo Chavez Saucedo on 4/2/19.
//  Copyright © 2019 Antonyo Chavez Saucedo. All rights reserved.
//

import UIKit




class MCollectionViewController :
    UIViewController{
    
    @IBOutlet weak var wraper: UIScrollView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var marcaShow: UITextView!
    @IBOutlet weak var nombreShow: UITextView!
    @IBOutlet weak var descripcionShow: UITextView!

    var indexOfCellBeforeDragging = 0
    
    let botonAddToCar: Boton = {
        let b = Boton()
        b.setTitle("Agregar a Carrito", for: .normal)
        b.backgroundColor = UIColor.Flat.Green.Fern
        b.addTarget(self, action: #selector(clickAddCar), for: .touchUpInside)
        b.layer.cornerRadius = CGFloat(10.0)
        return b
    }()
    
    var data : Item!
    var mainController : MMainViewController!
    var imagenesShow = [String]()
    var currentPage: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.setupLayout()
        self.currentPage = 0
    }
    
    func setupData(itemShow : Item, mainController : MMainViewController){
        self.data = itemShow
        self.mainController = mainController
    }
    
    func setupLayout(){
        if let value = self.data.marca{
            marcaShow.text = value
        }
        if let value = self.data.name{
            nombreShow.text = value
        }
        if let value = self.data.descripcion{
            descripcionShow.text = value
        }
        if let value = self.data.imagenes{
            imagenesShow = value
        }
        
        collectionView.anchor(top: view.layoutMarginsGuide.topAnchor, leading: view.layoutMarginsGuide.leadingAnchor, trailing: view.layoutMarginsGuide.trailingAnchor, bottom: nil,
            size: CGSize(width: 0, height: 280))
        
       
        let botonAddToCarA = botonAddToCar
        view.addSubview(botonAddToCarA)
        botonAddToCarA.anchor(
            top: nil,
            leading: view.safeAreaLayoutGuide.leadingAnchor,
            trailing: view.safeAreaLayoutGuide.trailingAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            padding: UIEdgeInsets(top: 0, left: 10, bottom: 5, right: 10),
            size: CGSize(width: 0, height: 50))
        view.addSubview(wraper)

        
        wraper.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, bottom: botonAddToCarA.topAnchor)
        
        wraper.isUserInteractionEnabled = true
        wraper.contentSize = CGSize(width: view.frame.size.width, height: (view.frame.size.height + 300)
        )
        
        nombreShow.anchor(top: collectionView.bottomAnchor, leading: view.layoutMarginsGuide.leadingAnchor, trailing: view.layoutMarginsGuide.trailingAnchor, bottom: nil,
                          size : CGSize(width: 0, height: 40))
        
        marcaShow.anchor(top: nombreShow.bottomAnchor, leading: view.layoutMarginsGuide.leadingAnchor, trailing: view.layoutMarginsGuide.trailingAnchor, bottom: nil,
                          size : CGSize(width: 0, height: 40))
        
        descripcionShow.anchor(top: marcaShow.bottomAnchor, leading: view.layoutMarginsGuide.leadingAnchor, trailing: view.layoutMarginsGuide.trailingAnchor, bottom: botonAddToCarA.topAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0))
        
    }

    @objc func clickAddCar(){
        self.mainController.AddBuy(HeadphoneBuy: data)
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension MCollectionViewController :
    UICollectionViewDataSource,
    UICollectionViewDelegate
     {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagenesShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MCollectionViewCell.reuseIdentifier, for: indexPath) as! MCollectionViewCell
        let imageName = imagenesShow[(indexPath as NSIndexPath).row]
        cell.imagenView.image = nil
        DispatchQueue.global(qos: .background).async {
            if let imagenUrl = UI.getImageURL(imageName){
                DispatchQueue.main.async {
                    cell.imagenView.image = imagenUrl
                    cell.imagenView.contentMode = .scaleAspectFit
                }
            }
        }
        
        return cell
    }
    
    
}
