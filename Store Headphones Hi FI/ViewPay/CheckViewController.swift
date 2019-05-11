//
//  PayViewController.swift
//  Store Headphones Hi FI
//
//  Created by Antonyo Chavez Saucedo on 4/9/19.
//  Copyright © 2019 Antonyo Chavez Saucedo. All rights reserved.
//  Se muestra el detalle de las compras y se puede eliminar con los swipe

import UIKit

class CheckViewController: UIViewController{
    static let identifierCell = "celdaPay"
    
    @IBOutlet weak var tableViewCar: UITableView!
    
    var MainController = MMainViewController()
    
    var backRoot = false
    
    let botonBuyNow: Boton = {
        let b = Boton()
        b.setTitle("Pagar", for: .normal)
        b.backgroundColor = UIColor.Flat.Blue.Mariner
        b.addTarget(self, action: #selector(clickBuy), for: .touchUpInside)
        b.layer.cornerRadius = CGFloat(10.0)
        return b
    }()
    
    let totalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Total a Pagar: $ 0.0"
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        label.textColor = UIColor.Flat.Blue.BlueWhale
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        back()
        tableViewCar.delegate = self
        tableViewCar.dataSource = self
        tableViewCar.rowHeight = CGFloat(80)
        view.addSubview(botonBuyNow)
        view.addSubview(totalTitleLabel)
        botonBuyNow.anchor(top: nil,
                           leading: view.safeAreaLayoutGuide.leadingAnchor,
                           trailing: view.safeAreaLayoutGuide.trailingAnchor,
                           bottom: view.safeAreaLayoutGuide.bottomAnchor,
                           padding: UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10),
                           size : CGSize(width: 0, height: 50))
        
        totalTitleLabel.anchor(top: nil,
                           leading: view.safeAreaLayoutGuide.leadingAnchor,
                           trailing: view.safeAreaLayoutGuide.trailingAnchor,
                           bottom: botonBuyNow.topAnchor,
                           padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10),
                           size : CGSize(width: 0, height: 80))
        
        tableViewCar.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                           leading: view.safeAreaLayoutGuide.leadingAnchor,
                           trailing: view.safeAreaLayoutGuide.trailingAnchor,
                           bottom: botonBuyNow.topAnchor)

        updateTolal()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        back()
    }
    
    @objc func clickBuy(){
        //Se crea instancia del StoryBoard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // Se obtiene el controller por Id del storyboard
        let controllerPay = storyboard.instantiateViewController(withIdentifier: "IdPayViewController") as! PayViewController
        controllerPay.checkViewController = self
        //Se agrega el controller a la navegacion
        let navBarOnModal: UINavigationController = UINavigationController(rootViewController: controllerPay)
        // Se presenta Vista
        self.present(navBarOnModal, animated: true, completion: nil)
    }
    
    func back(){
        if backRoot{
            self.navigationController?.popToRootViewController(animated: false)
        }
    }

    //actualiza el carrito
    func updateTolal(){
        if (MainController.Buys.count == 0){
            self.navigationController?.popViewController(animated: true)
        }
        
        var totalPagar : Double = 0.0
        for total in MainController.Buys{
            totalPagar = totalPagar + total.precio
        }
        totalTitleLabel.text = "Total a Pagar: \(totalPagar.toCurrency())"
        
    }
}


extension CheckViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MainController.Buys.count
    }
    
    //Se reutiliza las celdas y se colocan la info necesaria
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CheckViewController.identifierCell, for: indexPath)
        let buy = MainController.Buys[indexPath.row]
        
        cell.textLabel?.text = buy.name
        cell.detailTextLabel?.text = buy.precio.toCurrency()
        cell.imageView?.image = UIImage(named: "image_file")
        DispatchQueue.global(qos: .background).async {
            if let imagen = buy.imagen, let imagenUrl = UI.getImageURL(imagen){
                DispatchQueue.main.async {
                    cell.imageView?.image = imagenUrl
                    cell.imageView?.contentMode = .scaleAspectFit
                }
            }
        }
        return cell
    }
    //Se agrega funcionalidad para eliminar compras
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete{
                MainController.Buys.remove(at: indexPath.row)
                tableView.reloadData()
                updateTolal()
            }
    }
    
}
