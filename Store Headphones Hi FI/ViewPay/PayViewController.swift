//
//  PayViewController.swift
//  Store Headphones Hi FI
//
//  Created by Antonyo Chavez Saucedo on 4/26/19.
//  Copyright © 2019 Antonyo Chavez Saucedo. All rights reserved.
//  Clase donde se realizara el pago

import UIKit

class PayViewController: UIViewController {

    var checkViewController = CheckViewController()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var direccion: UITextField!
    @IBOutlet weak var ciudad: UITextField!
    @IBOutlet weak var cp: UITextField!
    @IBOutlet weak var estado: UITextField!
    @IBOutlet weak var tarjeta: UITextField!
    @IBOutlet weak var mesVencimiento: UITextField!
    @IBOutlet weak var annioVencimiento: UITextField!
    @IBOutlet weak var codigo: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cancelButton : UIBarButtonItem = UIBarButtonItem(title: "Cancelar", style: .done, target: self, action: #selector(cancelarButton))
        self.navigationItem.rightBarButtonItem = cancelButton
        
        setupUI();
    }
    
    func setupUI(){
        scrollView.anchor(top: view.layoutMarginsGuide.topAnchor, leading: view.layoutMarginsGuide.leadingAnchor, trailing: view.layoutMarginsGuide.trailingAnchor, bottom: view.bottomAnchor)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target:self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    @objc func cancelarButton(){
        self.dismiss(animated: true, completion: nil)
    }
    
    //Oculta el teclado
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func finalizePay(_ sender: UIButton) {
        
        if !validate(){
            return
        }
        
        let alert = UIAlertController(title: "Mensaje!", message: "Gracias por su Compra \n Este es su numero de seguimiento [\(self.token())]", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: { (action) in
            self.checkViewController.backRoot = true
            self.checkViewController.MainController.cleanCar = true
            self.dismiss(animated: true)
        }))
        self.present(alert, animated: true)
    }
    
    //Numero random para mostrar como guia
    func token() -> String{
        var token = ""
        for _ in 1...8 {
            token = "\(token)\(Int.random(in: 0 ... 9))"
        }
        return token
    }
    
    //Valida campos del formulario
    func validate() -> Bool{
        if nombre.text!.isEmpty(){
            return presentAlert(message: "El campo 'Nombre' es requerido.")
        }
        if direccion.text!.isEmpty(){
            return presentAlert(message: "El campo 'Dirección' es requerido.")
        }
        if ciudad.text!.isEmpty(){
            return presentAlert(message: "El campo 'Ciudad' es requerido.")
        }
        if tarjeta.text!.isEmpty(){
            return presentAlert(message: "El campo 'Tarjeta' es requerido.")
        }
        if mesVencimiento.text!.isEmpty(){
            return presentAlert(message: "El campo 'Tarjeta' es requerido.")
        }
        if annioVencimiento.text!.isEmpty(){
            return presentAlert(message: "El campo 'Tarjeta' es requerido.")
        }
        if codigo.text!.isEmpty(){
            return presentAlert(message: "El campo 'Codigo' es requerido.")
        }
        if nombre.text!.maxLength(max: 100){
            return presentAlert(message: "El campo 'Nombre' es demasiado grande.")
        }
        if !email.text!.isValidEmail(){
            return presentAlert(message: "El campo 'Email' es invalido.")
        }
        if direccion.text!.maxLength(max: 100){
            return presentAlert(message: "El campo 'Dirección' es demasiado grande.")
        }
        if ciudad.text!.maxLength(max: 100){
            return presentAlert(message: "El campo 'Ciudad' es demasiado grande.")
        }
        if cp.text!.maxLength(max: 5){
            return presentAlert(message: "El campo 'CP' es demasiado grande.")
        }
        if !cp.text!.isNumeric{
            return presentAlert(message: "El campo 'CP' es invalido.")
        }
        if estado.text!.maxLength(max: 100){
            return presentAlert(message: "El campo 'Estado' es demasiado grande.")
        }
        if !tarjeta.text!.isLength(size: 16){
            return presentAlert(message: "El campo 'Tarjeta' es invalido.")
        }
        if !tarjeta.text!.isNumeric{
            return presentAlert(message: "El campo 'Tarjeta' es invalido.")
        }
        if mesVencimiento.text!.maxLength(max: 2){
            return presentAlert(message: "El campo 'Mes Vencimiento' es demasiado grande.")
        }
        if !mesVencimiento.text!.isNumeric{
            return presentAlert(message: "El campo 'Mes Vencimiento' es invalido.")
        }
        if !mesVencimiento.text!.isRange(start: 1, end: 12){
            return presentAlert(message: "El campo 'Mes Vencimiento' es invalido.")
        }
        if annioVencimiento.text!.maxLength(max: 4){
            return presentAlert(message: "El campo 'Año Vencimiento' es demasiado grande.")
        }
        if !annioVencimiento.text!.isNumeric{
            return presentAlert(message: "El campo 'Año Vencimiento' es invalido.")
        }
        if !annioVencimiento.text!.isRange(start: 1900, end: 2030){
            return presentAlert(message: "El campo 'Año Vencimiento' es invalido.")
        }
        if codigo.text!.maxLength(max: 3){
            return presentAlert(message: "El campo 'Codigo es demasiado grande.")
        }
        if !codigo.text!.isNumeric{
            return presentAlert(message: "El campo 'Codigo' es invalido.")
        }
        return true
    }
    
    // Muestra errores del formulario
    func presentAlert(message : String) -> Bool{
        let alert = UIAlertController(title: "Precaucíon!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cerrar", style: .destructive, handler: nil))
        self.present(alert, animated: true)
        return false
    }
    
    
}
