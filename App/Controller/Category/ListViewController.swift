//
//  ListViewController.swift
//  App
//
//  Created by Javed Multani on 16/11/2019.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit
import SwiftIcons
import SwiftyJSON

class ListViewController: BaseVC,UITableViewDataSource,UITableViewDelegate {
    
    var titleArray = ["Indian Desi", "Heavy Meal","Light Meal","Italian Food","Veg Delicious","Spicy nonveg","Healthy Chinese Meal","Fresh Curry"]
    var dishArray:[ObjOrder] = [ObjOrder]()
    @IBOutlet weak var listTableVie: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableVie.delegate = self
        listTableVie.dataSource = self
        
        listTableVie.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeTableViewCell")
        

        self.setDish()
        listTableVie.backgroundColor = UIColor.clear
        // Do any additional setup after loading the view.
    }
    func setDish(){
        addDish(name: "Veg.Biryani", price: 19)
        addDish(name: "Chiken Biryani", price: 9.99)
        addDish(name: "Mutton Biryani", price: 19)
        addDish(name: "Lamb Biryani", price: 19)
        addDish(name: "Prawn Biryani", price: 19)
        addDish(name: "Spicy Biryani", price: 19)
        
       
    }
    func addDish(name:String,price:Double){
        let dic = ["Title":name,
                   "Ing":"",
                   "Price":"\(price)"]
        let json = JSON(dic)
        let obj:ObjOrder = ObjOrder.init(json: json)
        self.dishArray.append(obj)
    }
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden (false, animated: false)
        self.setNavigationbarleft_imagename(left_icon_Name: IoniconsType.androidArrowBack, left_action: #selector(self.btnBackHandle(_:)),
                                                    right_icon_Name:nil,
                                                    right_action: nil,
                                                    title: "Recipes")
        
    }
    // MARK: - UITableViewDataSource
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          
        return self.dishArray.count
          
      }
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
      {
          
        return 75.0
          
          
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
          let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell
          
        cell.titleLabel.text = self.dishArray[indexPath.row].title
          let img = indexPath.row + 1
              cell.imageViewGallery.image = UIImage(named: "\(img)")
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.clear
          return cell
      }
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = loadVC(storyboardMain, "DetailViewController") as! DetailViewController
        vc.objOrder = dishArray[indexPath.row]
                                        self.navigationController?.pushViewController(vc, animated: true)
      
         
      }

   

}
