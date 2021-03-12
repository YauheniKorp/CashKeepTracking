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
//var closeButton = UIButton()

class AppViewController: UIViewController, CreateCollectionView, UIGestureRecognizerDelegate {
    
    var detailButton = UIButton()
    var button = UIBarButtonItem()
    var detailButton1 = UIBarButtonItem()
    var updateButton = UIBarButtonItem()
    var deleteButton = UIBarButtonItem()
    
    func createCollectionView() {
        print("")
    }
    
    let arrOfValue = ["Магазин", "АЗС", "Стройматериалы", "Техника", "Автозапчасти", "Обслуживание авто", "Другое" ]
    let arrOfMethods = ["Card", "Cash"]
    
    let view1 = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //closeButton.isHidden = false
        
        //let closeImage = UIImage(named: "close")
        //closeButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        //closeButton.setBackgroundImage(closeImage, for: .normal)
        let paym = self.gettingPaymentList()
        arrOfItem += self.gettingItemList()
        
        var index = 0
        
        for val in paym.indices{
            index = 0
            for value in arrOfItem {
                if value.name == paym[val].method {
                    arrOfItem[index].payments.append(paym[val])
                }
                index += 1
            }
        }
        
        //        for value in paym {
        //            arrOfItem[value.numberOfItem].payments.append(value)
        //        }
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 30, right: 10)
        layout.itemSize = CGSize(width: 335, height: 150)
        
        let frameCollectionVC = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        collectionVC = UICollectionView(frame: frameCollectionVC, collectionViewLayout: layout)
        
        self.title = "Cash Keep Tracking"
        
        detailButton.addTarget(self, action: #selector(actionForDetailButton), for: .touchUpInside)
        createCollectionView(self, collectionVC!, detailButton, view1)
        
        button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton))
        deleteButton = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteButtonAction))
        
        detailButton1 = UIBarButtonItem(title: "Detail", style: .plain, target: self, action: #selector(actionForDetailButton))
        updateButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(updateBut))
        //let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(deleteItem))
        
        
        navigationItem.leftBarButtonItems = [updateButton, deleteButton]
        navigationItem.rightBarButtonItems = [button, detailButton1]
    }
    
    //MARK: - @objc func
    //    @objc func deleteItem() {
    //        if closeButton.isHidden {
    //            closeButton.isHidden = false
    //        } else {
    //            closeButton.isHidden = true
    //        }
    //    }
    
    @objc func deleteButtonAction() {
        let alert = UIAlertController(title: "Удаление метода оплаты", message: "Выберите метод, который хотите удалить\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        
        let picker = UIPickerView(frame: CGRect(x: 30, y: 80, width: 200, height: 100))
        picker.dataSource = self
        picker.delegate = self
        picker.tag = 2
        
        let okAction = UIAlertAction(title: "Delete", style: .cancel) { (action) in
            let selectedValue = picker.selectedRow(inComponent: 0)
            if selectedValue == 0 || selectedValue == 1 {
                self.present(alert, animated: true, completion: nil)
                return
            }
            self.deleteItem(arrOfItem[selectedValue].name)
            self.deletePaymentListByItem(selectedValue)
            arrOfItem.remove(at: selectedValue)
            print("selected value is \(selectedValue)")
            self.createCollectionView(self, collectionVC!, self.detailButton, self.view1)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.view.addSubview(picker)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
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
            
            for value in arrOfItem.indices {
                if arrOfItem[value].name == "\(cardString) \(str ?? "")" || arrOfItem[value].name == "\(cashString) \(str ?? "")" {
                    self.present(alert, animated: true, completion: nil)
                    return
                }
            }
            
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
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
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
            guard let price = alert.textFields?[0].text else {return}
            if price == "" || price.contains("-") {
                self.present(alert, animated: true, completion: nil)
                return
            }
            self.addingPaymentModel(PaymentModel(method: "\(arrOfItem[indexPath.row].name)", name: self.arrOfValue[selectedValue], payment: Float(price) ?? 0.0, dateOfPayment: formatter3.string(from: today), numberOfItem: indexPath.row))
            arrOfItem[indexPath.row].payments.append(PaymentModel(method: "\(arrOfItem[indexPath.row].name)", name: self.arrOfValue[selectedValue], payment: Float(price) ?? 0.0, dateOfPayment: formatter3.string(from: today), numberOfItem: indexPath.row))
            self.createCollectionView(self, collectionVC!, self.detailButton, self.view1)
            
        }
        
        alert.view.addSubview(pickerView)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
//    override func setEditing(_ editing: Bool, animated: Bool) {
//        super.setEditing(editing, animated: animated)
//
//        detailButton1.isEnabled = !editing
//        updateButton.isEnabled = !editing
//        button.isEnabled = !editing
//
//    }
    
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
        case 2:
            return arrOfItem.count
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
        case 2:
            return arrOfItem[row].name
        default:
            break
        }
        return ""
    }
    
}
