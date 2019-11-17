//
//  OrderViewController.swift
//  App
//
//  Created by Javed Multani on 16/11/2019.
//  Copyright © 2019 iOS. All rights reserved.
//
import SwiftIcons
import UIKit

class OrderViewController: BaseVC,UITableViewDelegate,UITableViewDataSource {
    var objOrder:ObjOrder? = nil
    var orderArray:[ObjOrder] = [ObjOrder]()

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        
        listTableView.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderTableViewCell")
        
        orderButton.layer.cornerRadius = 10.0
        orderButton.clipsToBounds = true
        
        addButton.layer.cornerRadius = 10.0
        addButton.clipsToBounds = true
        
        self.listTableView.estimatedRowHeight = 76
        self.listTableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden (false, animated: false)
        self.setNavigationbarleft_imagename(left_icon_Name: IoniconsType.androidArrowBack, left_action: #selector(self.btnBackHandle(_:)),
                                            right_icon_Name:nil,
                                            right_action: nil,
                                            title: "My Order")
        self.getOrder()
    }
    //Manage caching...
    func getOrder(){
    
            //check data is updated....
            let arrData = UserDefaults.standard.object(forKey: "myOrder")
            if arrData != nil{
                
                self.orderArray = NSKeyedUnarchiver.unarchiveObject(with: arrData as! Data) as! [ObjOrder]
              //  self.populateGraph(graphData: arrayGraph as! [ObjGraph])
                
            }
        self.listTableView.reloadData()
        var total = 0.0
        for order in orderArray{
           let rate = Double(order.price!)
            total = total + rate!
        }
        self.priceLabel.text = "$ \(total.rounded(toPlaces: 2))"
    }
    //MARK: - button action
    @IBAction func buttonHandlerOrder(_ sender: Any) {
        let arrayOrder:[ObjOrder] = [ObjOrder]()
        DispatchQueue.main.async{
        let myData = NSKeyedArchiver.archivedData(withRootObject: arrayOrder)
        UserDefaults.standard.set(myData, forKey: "myOrder")
        }
        
        let vc = loadVC(storyboardMain, "DeliveryViewController") as! DeliveryViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func buttonHandlerAdd(_ sender: Any) {
        let homeVC = loadVC(storyboardMain, viewImageDisplayerVC) as! ImageDisplayerViewController
                                   self.navigationController?.pushViewController(homeVC, animated: true)
                              
        
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return orderArray.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        return UITableViewAutomaticDimension
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as! OrderTableViewCell
        let obj = orderArray[indexPath.row]
        
        cell.titleLabel.text = obj.title!
        cell.priceLabel.text = "$ " + obj.price!
        if obj.ing! == ""{
              cell.ingLabel.text = "No extra ingredient"
        }else{
              cell.ingLabel.text = obj.ing
        }
      
        
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.clear
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
}
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
