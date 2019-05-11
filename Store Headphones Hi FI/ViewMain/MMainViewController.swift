//
//  MTableViewController.swift
//  Store Headphones Hi FI
//
//  Created by Antonyo Chavez Saucedo on 3/27/19.
//  Copyright © 2019 Antonyo Chavez Saucedo. All rights reserved.
//

import UIKit


class MMainViewController:
    UIViewController{

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var barButtonShopping: BadgeBarButtonItem!
    
    var Headphones = [Item]()
    var Buys = [Item]()
    
    var cleanCar = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        //collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        loadData()
        setupPanelUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updatePanels()
        updateCleanCar()
    }
    
    func loadData(){
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
                let querySubJson = json["items"] as! [Any]
                for item in querySubJson{
                    if let itemArray = item as? [String:Any]{
                        var itemHeadphone = Item()
                        if let value = itemArray["id"], let id = value as? Int{
                            itemHeadphone.id = id
                        }
                        if let value = itemArray["name"], let name = value as? String{
                            itemHeadphone.name = name
                        }
                        if let value = itemArray["marca"], let marca = value as? String{
                            itemHeadphone.marca = marca
                        }
                        if let value = itemArray["descripcion"], let descripcion = value as? String{
                            itemHeadphone.descripcion = descripcion
                        }
                        if let value = itemArray["precio"], let precio = value as? Double{
                            itemHeadphone.precio = precio
                        }
                        if let value = itemArray["existencias"], let existencias = value as? Int{
                            itemHeadphone.existencias = existencias
                        }
                        if let value = itemArray["imagen"], let imagen = value as? String{
                            itemHeadphone.imagen = imagen
                        }
                        if let value = itemArray["imagenes"], let imagenes = value as? [String]{
                            itemHeadphone.imagenes = imagenes
                        }
                        self.Headphones.append(itemHeadphone)
                    }
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch {
                
            }
        }
    }
    
    
    
    //Ingresa a prepare antes de enviar a siguiente patalla en Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showItem"{
            if let indexPath = collectionView.indexPathsForSelectedItems?.first{
                guard let showView = segue.destination as? MCollectionViewController else{
                    return
                }
                showView.setupData(itemShow: Headphones[indexPath.row], mainController: self)
            }
        }
        
        if segue.identifier == "showPay"{
            guard let showPay = segue.destination as? CheckViewController else{
                return
            }
            if Buys.count == 0{
                return
            }
            showPay.MainController = self
        }
    }
    
    
    @objc func actionShop(){
        
    }
    
    func AddBuy(HeadphoneBuy : Item){
        Buys.append(HeadphoneBuy)
        updatePanels()
    }
    
    func updatePanels(){
        barButtonShopping.badgeNumber = Buys.count
        if Buys.count > 0{
            barButtonShopping.image = UIImage(named: "shopping_cart_loaded")
        } else {
            barButtonShopping.image = UIImage(named: "shopping_cart")
        }
        var totalPagar : Double = 0.0
        for total in Buys{
            totalPagar = totalPagar + total.precio
        }
        setTotal(total: totalPagar)
    }
    
    // MARK: - PANEL BOTTOM
    func setupPanelUI() {
        view.addSubview(backBottomView)
        backBottomView.addSubview(totalTitleLabel)
        backBottomView.anchor(top: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, size : CGSize(width: 0, height: 60))
        totalTitleLabel.anchor(top: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil)
        totalTitleLabel.topAnchor.constraint(equalTo: backBottomView.topAnchor, constant: 15).isActive = true
        
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor,
                              trailing: view.safeAreaLayoutGuide.trailingAnchor, bottom: backBottomView.topAnchor)
    }
    
    private lazy var backBottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        //view.layer.cornerRadius = 10
        view.backgroundColor = UIColor.Flat.Blue.BlueWhale
        return view
    }()
    
    private lazy var totalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Total a Pagar: $ 0.0"
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        label.textColor = UIColor.Flat.Blue.PictonBlue
        label.textAlignment = .center
        return label
    }()
    
    func setTotal(total : Double){
        totalTitleLabel.text = "Total a Pagar: \(total.toCurrency())"
    }
    
    func updateCleanCar(){
        if cleanCar{
            Buys = [Item]()
            updatePanels()
            cleanCar = false
        }
    }
    
}


extension MMainViewController:
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout{
    
    //Total de objetos en la collection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Headphones.count
    }
    
    //Reutiliza las celdas y coloca los valores
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MMainViewCell.reuseIdentifier, for: indexPath) as! MMainViewCell
        //let imageName = imagenesShow[(indexPath as NSIndexPath).row]
        let row = Headphones[indexPath.row]
        cell.collectionView = collectionView
        cell.indexPath = indexPath
        cell.setPrecio(precio: row.precio)
        cell.setName(name: row.name)
        cell.imagen.image = nil
        DispatchQueue.global(qos: .background).async {
            if let imagen = row.imagen, let imagenUrl = UI.getImageURL(imagen){
                DispatchQueue.main.async {
                    cell.imagen.image = imagenUrl
                    cell.imagen.contentMode = .scaleAspectFit
                }
            }
        }
        
        return cell
    }
    //Tamaño de Rows
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let perImageMax = self.view.frame.width / 1 - 10
        return CGSize(width: perImageMax, height: perImageMax)
    }
    
}
