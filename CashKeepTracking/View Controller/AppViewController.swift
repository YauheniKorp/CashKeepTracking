//
//  AppViewController.swift
//  CashKeepTracking
//
//  Created by Admin on 28.12.2020.
//

import UIKit

var arrOfPaymentByCash = [PaymentModel]()
var arrOfPaymentByCard = [PaymentModel]()
var collectionVC: UICollectionView?
var arrOfItem = [ItemModel(name: "Card: My Card", imageName: "card"),
                 ItemModel(name: "Cash: My Cash", imageName: "cash")]

class AppViewController: UIViewController, CreateCollectionView, UIGestureRecognizerDelegate {
    
    var detailButton = UIButton()
    
    func createCollectionView() {
        print("")
    }
    
    let arrOfValue = ["Магазин", "АЗС", "Стройматериалы", "Техника", "Автозапчасти", "Обслуживание авто", "Другое" ]
    let arrOfMethods = ["Card", "Cash"]
    
    let view1 = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let paym = self.gettingPaymentList()
        arrOfItem += self.gettingItemList()
        
        for value in paym {
            arrOfItem[value.numberOfItem].payments.append(value)
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 30, right: 10)
        layout.itemSize = CGSize(width: 335, height: 150)
        
        let frameCollectionVC = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        collectionVC = UICollectionView(frame: frameCollectionVC, collectionViewLayout: layout)
        
        self.title = "Cash Keep Tracking"
        
        detailButton.addTarget(self, action: #selector(actionForDetailButton), for: .touchUpInside)
        createCollectionView(self, collectionVC!, detailButton, view1)
        
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton))
        let detailButton1 = UIBarButtonItem(title: "Detail", style: .plain, target: self, action: #selector(actionForDetailButton))
        let updateButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(updateBut))
        
        navigationItem.leftBarButtonItems = [updateButton]
        navigationItem.rightBarButtonItems = [button, detailButton1]
    }
    
    //MARK: - @objc func
    @objc func addButton() {
        
        let alert = UIAlertController(title: "Выберите метод оплаты: \n\n\n\n", message: "Введите имя метода оплаты", preferredStyle: .alert)
        
        alert.addTextField { (tf) in
            tf.placeholder = "enter name"
        }
        
        let pick = UIPickerView(frame: CGRect(x: 30, y: 30, width: 200, height: 100))
        pick.dataSource = self
        pick.delegate = self
        pick.tag = 0
        
        let okaction = UIAlertAction(title: "Ok", style: .default) { (action) in
            let str = alert.textFields?[0].text
            let cardString = " Card: "
            let cashString = " Cash: "
            
            switch pick.selectedRow(inComponent: 0) {
            case 0:
                self.addingItemModel(ItemModel(name: "\(cardString) \(str ?? "")", imageName: "card"))
                arrOfItem.append(ItemModel(name: "\(cardString) \(str ?? "")", imageName: "card"))
                self.createCollectionView(self, collectionVC!, self.detailButton, self.view1)
                
            case 1:
                self.addingItemModel(ItemModel(name: "\(cashString) \(str ?? "")", imageName: "cash"))
                arrOfItem.append(ItemModel(name: "\(cashString) \(str ?? "")", imageName: "cash"))
                self.createCollectionView(self, collectionVC!, self.detailButton, self.view1)
                
            default:
                break
            }
        }
        alert.addAction(okaction)
        alert.view.addSubview(pick)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func actionForDetailButton() {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "Detail") else { return }
        //vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func updateBut() {
        self.createCollectionView(self, collectionVC!, self.detailButton, self.view1)
    }
}

extension AppViewController: UICollectionViewDelegate, UICollectionViewDataSource, InsertPaymentModel {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrOfItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ItemCollectionViewCell
        cell.clipsToBounds = false
        cell.setCell(arrOfItem[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        var methodOfPayment: MethodOfPayment?
//
//        switch arrOfItem[indexPath.row].name.contains("rd") {
//        case true:
//            methodOfPayment = .Card
//        case false:
//            methodOfPayment = .Cash
//        }
//
//        switch indexPath.row {
//        case 0:
//            methodOfPayment = .Card
//        case 1:
//            methodOfPayment = .Cash
//        default:
//            break
//        }
        let alert = UIAlertController(title: "Добавление оплаты", message: "Укажите данные оплаты: \n\n\n\n\n\n\n\n", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        
        alert.addTextField { (textField) in
            textField.placeholder = "Введите сумму"
            textField.keyboardType = .numberPad
        }
        
        let pickerView = UIPickerView(frame: CGRect(x: 10, y: 80, width: alert.view.frame.width - self.view.frame.width / 3, height: 100))
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = 1
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            let today = Date()
            let formatter3 = DateFormatter()
            formatter3.dateFormat = "HH:mm:ss E, d MMM"
            
            let selectedValue = pickerView.selectedRow(inComponent: 0)
            let price = alert.textFields?[0].text
            
            print(indexPath.row)
            self.addingPaymentModel(PaymentModel(method: "\(arrOfItem[indexPath.row].name)", name: self.arrOfValue[selectedValue], payment: Float(price ?? "") ?? 0.0, dateOfPayment: formatter3.string(from: today), numberOfItem: indexPath.row))
            arrOfItem[indexPath.row].payments.append(PaymentModel(method: "\(arrOfItem[indexPath.row].name)", name: self.arrOfValue[selectedValue], payment: Float(price ?? "") ?? 0.0, dateOfPayment: formatter3.string(from: today), numberOfItem: indexPath.row))
            self.createCollectionView(self, collectionVC!, self.detailButton, self.view1)
            
        }
        
        alert.view.addSubview(pickerView)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

extension AppViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView.tag {
        case 0:
            return arrOfMethods.count
        case 1:
            return arrOfValue.count
        default:
            break
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return arrOfMethods[row]
        case 1:
            return arrOfValue[row]
        default:
            break
        }
        return ""
    }
    
}
